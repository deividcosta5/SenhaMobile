unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, RESTRequest4D, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, View.Clientes, Controller.Clientes;

type
  TDataModuleGlobal = class(TDataModule)
    TabSenha: TFDTable;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetSenha(const IDSENHA, IDCLIENTE: Integer; TOKEN: String): Integer;
  end;

var
  DataModuleGlobal: TDataModuleGlobal;

const
  VERSION_API: String = 'v1';
  LOGIN: String = 'deivid';
  SENHA: String = 'srnpftJ6oy5SArU@';

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TDataModuleGlobal.GetSenha(const IDSENHA, IDCLIENTE: Integer; TOKEN: String): Integer;
var
  Resp: IResponse;
  JSON: TJSONObject;
begin
  TabSenha.FieldDefs.Clear;
  try
    JSON := TJSONObject.Create;
    JSON.AddPair('idsenha', IDSENHA);
    JSON.AddPair('idcliente', IDCLIENTE);
    JSON.AddPair('token', TOKEN);

    Resp := TRequest.New.BaseURL(frmHospital.ClienteSelecionado.EnderecoAPI)
            .Resource(VERSION_API + '/registrarsenha')
            .AddBody(JSON.ToJSON)
            .BasicAuthentication(LOGIN, SENHA)
            .Accept('application/json')
            .DataSetAdapter(TabSenha)
            .Post;
    Result := Resp.StatusCode;
    if Resp.StatusCode <> 200 then
      raise Exception.Create('Resp.Content');
  finally
    JSON.DisposeOf;
  end;
end;

end.
