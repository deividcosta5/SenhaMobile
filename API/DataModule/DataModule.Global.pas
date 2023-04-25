unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.FMXUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, Data.DB, FireDAC.Comp.Client, DataSet.Serialize.Config, DataSet.Serialize, System.JSON, FireDAC.DApt;

type
  TDMGlobal = class(TDataModule)
    FDConn: TFDConnection;
    FDPhys: TFDPhysMSSQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDConnBeforeConnect(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarConfigDB(Connection: TFDConnection);
  public
    { Public declarations }
    function RegistrarSenha(Senha: TJSONObject): TJSONObject;
  end;

var
  DMGlobal: TDMGlobal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMGlobal.CarregarConfigDB(Connection: TFDConnection);
begin
  Connection.DriverName := 'MSSQL';
  with Connection.Params do
  begin
    Clear;
    Add('DriverID=MSSQL');
    Add('User_Name=hmsc');
    Add('Password=sbschmsc');
    Add('Port=1433');
    Add('Server=127.0.0.1');
    Add('Protocol=TCPIP');
  end;
end;

procedure TDMGlobal.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

  FDConn.Connected := true;
end;

procedure TDMGlobal.FDConnBeforeConnect(Sender: TObject);
begin
  CarregarConfigDB(FDConn);
end;

function TDMGlobal.RegistrarSenha(Senha: TJSONObject): TJSONObject;
var
  qry: TFDQuery;
begin
  if Senha.GetValue<Integer>('idsenha', 0) = 0 then
    raise Exception.Create('Senha não informada');
  if Senha.GetValue<Integer>('idcliente', 0) = 0 then
    raise Exception.Create('Cliente não informada');
  if Senha.GetValue<String>('token') = '' then
    raise Exception.Create('Token não informado');

  try
    qry := TFDQuery.Create(nil);
    qry.Connection := FDConn;
    with qry do
    begin
      SQL.Clear;
      SQL.Add('EXEC MOBILE.SENHA.SP_READ_QRCODE :ID_SENHA, :ID_CELULAR, :ID_CLIENTE');
      ParamByName('ID_CELULAR').Value := Senha.GetValue<String>('token');
      ParamByName('ID_SENHA').Value   := Senha.GetValue<Integer>('idsenha', 0);
      ParamByName('ID_CLIENTE').Value := Senha.GetValue<Integer>('idcliente', 0);
      Open;
    end;
    Result := qry.ToJSONObject;
  finally
    FreeAndNil(qry);
  end;
end;

end.
