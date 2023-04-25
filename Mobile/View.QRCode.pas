unit View.QRCode;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Objects, u99Permissions, FMX.Media, ZXing.ScanManager, ZXing.ReadResult, ZXing.BarcodeFormat;

type
  TfrmQRCode = class(TForm)
    Text1: TText;
    RectBackground: TRectangle;
    CameraComponent: TCameraComponent;
    ImgCamera: TImage;
    txtErro: TText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CameraComponentSampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
  private
    { Private declarations }
    Permissao: T99Permissions;
    FScanManager: TScanManager;
    FScanInProgress: Boolean;
    FFrameTake: Integer;
    procedure ProcessarImagem;
  public
    { Public declarations }
    Codigo: String;
  end;

var
  frmQRCode: TfrmQRCode;

implementation

{$R *.fmx}

uses View.Camera, RESTRequest4D, System.JSON, DataModule.Global, View.Clientes, Commons.Global;

procedure TfrmQRCode.CameraComponentSampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
begin
  ProcessarImagem;
end;

procedure TfrmQRCode.FormCreate(Sender: TObject);
begin
  Permissao := T99Permissions.Create;
end;

procedure TfrmQRCode.FormDestroy(Sender: TObject);
begin
  Permissao.DisposeOf;
  if Assigned(FScanManager) then
    FScanManager.DisposeOf;
end;

procedure TfrmQRCode.FormShow(Sender: TObject);
begin
  if not Permissao.VerifyCameraAccess then
    Permissao.Camera(nil,nil)
  else
  begin
    FScanManager := TScanManager.Create(TBarcodeFormat.Auto, nil);
    FFrameTake := 0;
    CameraComponent.Active := False;
    CameraComponent.Kind := TCameraKind.BackCamera;
    CameraComponent.FocusMode := TFocusMode.ContinuousAutoFocus;
    CameraComponent.Quality := TVideoCaptureQuality.LowQuality;
    CameraComponent.Active := True;
  end;
end;

procedure TfrmQRCode.ProcessarImagem;
var
  Bmp: TBitmap;
  ReadResult: TReadResult;
begin
  CameraComponent.SampleBufferToBitmap(imgCamera.Bitmap, True);

  if FScanInProgress then
    Exit;

  Inc(FFrameTake);

  if (FFrameTake mod 4 <> 0) then
    Exit;

  Bmp := TBitmap.Create;
  Bmp.Assign(imgCamera.Bitmap);
  ReadResult := nil;

  try
    FScanInProgress := True;
    try
      ReadResult := FScanManager.Scan(Bmp);
      if ReadResult <> nil then
      begin
        CameraComponent.Active := False;
        Codigo := ReadResult.Text;
        //ShowMessage(ReadResult.Text);
        ShowMessage(DataModuleGlobal.GetSenha(StrToIntDef(Codigo,0), frmHospital.ClienteSelecionado.ID, TokenDevice).ToString);

      end;
    except on E: Exception do
      txtErro.Text := E.Message;
    end;
  finally
    Bmp.DisposeOf;
    ReadResult.DisposeOf;
    FScanInProgress := False;
  end;
end;

end.
