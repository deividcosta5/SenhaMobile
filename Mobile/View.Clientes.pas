unit View.Clientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Layouts, FMX.ListBox, Commons.Global, Controller.Clientes,
  {$IFDEF ANDROID}
  FMX.PushNotification.Android,
  {$ENDIF}
  {$IFDEF IOS}
  FMX.PushNotification.FCM.iOS,
  {$ENDIF}
  System.PushNotification, System.Notification, FMX.Platform;

type
  TfrmHospital = class(TForm)
    RectBackground: TRectangle;
    Text1: TText;
    StyleBook1: TStyleBook;
    ListBoxHospital: TListBox;
    NotificationCenter: TNotificationCenter;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPushService: TPushService;
    FPushServiceConnection: TPushServiceConnection;
    procedure LoadHospital;
    procedure AddHospital(const LOGO: TBitmap; NOME: String; ID: Integer);
    function AppEventProc(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
    procedure LimparNotificacao;
    procedure OnServiceConnectionChange(Sender: TObject; PushChanges: TPushService.TChanges);
    procedure OnServiceConnectionReceiveNotification(Sender: TObject; const ServiceNotification: TPushServiceNotification);
  public
    { Public declarations }
    ClienteSelecionado: TCliente;
  end;

var
  frmHospital: TfrmHospital;

implementation

{$R *.fmx}

uses Frame.Clientes, Controller.Chamadas, System.Generics.Collections;

{ TfrmHospital }

procedure TfrmHospital.AddHospital(const LOGO: TBitmap; NOME: String; ID: Integer);
var
  Item:  TListBoxItem;
  Frame: TFrameClientes;
begin
  Item := TListBoxItem.Create(ListBoxHospital);
  Item.Selectable := False;
  Item.Text := '';
  Item.Height := 64;
  Item.Tag := ID;
  ITem.TagString := NOME;

  Frame := TFrameClientes.Create(Item);
  Frame.txtHospital.Text := NOME;

  Item.AddObject(Frame);
  ListBoxHospital.AddObject(Item);
end;

procedure TfrmHospital.LimparNotificacao;
begin
  NotificationCenter.CancelAll;
end;

procedure TfrmHospital.LoadHospital;
var
  Clientes: TCliente;
begin
  ListBoxHospital.Items.Clear;
  for Clientes in ListaClientes do
    AddHospital(nil, Clientes.Nome, Clientes.ID);
end;

procedure TfrmHospital.OnServiceConnectionChange(Sender: TObject; PushChanges: TPushService.TChanges);
begin
  if TPushService.TChange.Status in PushChanges then
  begin
    if FPushService.Status = TPushService.TStatus.Started then
    begin
      //
    end
    else if FPushService.Status = TPushService.TStatus.StartupError then
    begin
      FPushServiceConnection.Active := False;
    end;
  end;

  if TPushService.TChange.DeviceToken in PushChanges then
  begin
    TokenDevice := FPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];
  end;
end;

procedure TfrmHospital.OnServiceConnectionReceiveNotification(Sender: TObject; const ServiceNotification: TPushServiceNotification);
begin

end;

function TfrmHospital.AppEventProc(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
begin
  if (AAppEvent = TApplicationEvent.BecameActive) then
    LimparNotificacao;
end;

procedure TfrmHospital.FormActivate(Sender: TObject);
var
  Notifications: TArray<TPushServiceNotification>;
  X: integer;
  Chamadas: TChamada;
  ChamadaID, ChamadaIDSenha: Integer;
  ChamadaSetor, ChamadaSala, ChamadaDataHora: String;
begin
  Notifications := FPushService.StartupNotifications; // notificaoes que abriram meu app...

  if Length(Notifications) > 0 then
  begin
    for X := 0 to Notifications[0].DataObject.Count - 1 do
    begin

      if Notifications[0].DataObject.Pairs[x].JsonString.Value = 'chamadaid' then
        ChamadaID := Notifications[0].DataObject.Pairs[x].JsonValue.Value.ToInteger();
      if Notifications[0].DataObject.Pairs[x].JsonString.Value = 'chamadaidsenha' then
        ChamadaIDSenha := Notifications[0].DataObject.Pairs[x].JsonValue.Value.ToInteger();
      if Notifications[0].DataObject.Pairs[x].JsonString.Value = 'chamadasetor' then
        ChamadaSetor := Notifications[0].DataObject.Pairs[x].JsonValue.Value;
      if Notifications[0].DataObject.Pairs[x].JsonString.Value = 'chamadasala' then
        ChamadaSala := Notifications[0].DataObject.Pairs[x].JsonValue.Value;
      if Notifications[0].DataObject.Pairs[x].JsonString.Value = 'chamadaid' then
        ChamadaDataHora := Notifications[0].DataObject.Pairs[x].JsonValue.Value;

      if not Assigned(ListaChamadas) then
        ListaChamadas := TList<TChamada>.Create;
      for Chamadas in ListaChamadas do
          ListaChamadas.Add(TChamada.Create(ChamadaID, ChamadaIDSenha, ChamadaSetor, ChamadaSala, StrToDateTime(ChamadaDataHora)));
    end;
  end;
end;

procedure TfrmHospital.FormCreate(Sender: TObject);
var
  AppEvent : IFMXApplicationEventService;
begin
  LoadClientes;
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(AppEvent)) then
    AppEvent.SetApplicationEventHandler(AppEventProc);

  FPushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.FCM);
  FPushServiceConnection                       := TPushServiceConnection.Create(FPushService);

  FPushServiceConnection.OnChange              := OnServiceConnectionChange;
  FPushServiceConnection.OnReceiveNotification := OnServiceConnectionReceiveNotification;

  FPushServiceConnection.Active                := True;
end;

procedure TfrmHospital.FormDestroy(Sender: TObject);
begin
  FPushServiceConnection.Free;
end;

procedure TfrmHospital.FormShow(Sender: TObject);
begin
  LoadHospital;
end;

end.
