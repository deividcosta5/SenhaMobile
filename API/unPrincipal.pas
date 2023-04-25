unit unPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls,
  Horse.Logger, Horse.Logger.Provider.LogFile, Horse.HandleException, Horse.Compression, Horse.Exception.Logger;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    spPorta: TSpinEdit;
    Label1: TLabel;
    btnIniciar: TButton;
    MemoLog: TMemo;
    procedure btnIniciarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses Horse,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Horse.CORS,
  DataSet.Serialize.Config,
  Controller.Cadastro;

procedure TfrmPrincipal.btnIniciarClick(Sender: TObject);
begin
  THorse.Use(Compression());
  THorse.Use(Jhonson());
  THorse.Use(CORS);
  THorse.Use(HandleException);
  THorse.Use(THorseExceptionLogger.New());

  THorseLoggerManager.RegisterProvider(THorseLoggerProviderLogFile.New());
  THorse.Use(THorseLoggerManager.HorseCallback);

  THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
      Result := AUsername.Equals('deivid') and APassword.Equals('srnpftJ6oy5SArU@');
    end));


  // Registro das rotas...
  Controller.Cadastro.RegistrarRotas;

  // Subir a aplicacao...
  THorse.Listen(spPorta.Value);
  MemoLog.Lines.Add('Servidor executando na porta ' + spPorta.Value.ToString);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  MemoLog.Clear;
end;

end.
