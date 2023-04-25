program SistemaSenhaMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Clientes in 'View.Clientes.pas' {frmHospital},
  Frame.Clientes in 'Frame.Clientes.pas' {FrameClientes: TFrame},
  View.QRCode in 'View.QRCode.pas' {frmQRCode},
  u99Permissions in 'u99Permissions.pas',
  View.Camera in 'View.Camera.pas' {frmCamera},
  Frame.Senha in 'Frame.Senha.pas' {FrameSenha: TFrame},
  View.Senha in 'View.Senha.pas' {frmSenha},
  Controller.Clientes in 'Controller\Controller.Clientes.pas',
  Commons.Global in 'Commons\Commons.Global.pas',
  Controller.Chamadas in 'Controller\Controller.Chamadas.pas',
  DataModule.Global in 'DataModule\DataModule.Global.pas' {DataModuleGlobal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHospital, frmHospital);
  Application.CreateForm(TDataModuleGlobal, DataModuleGlobal);
  Application.Run;
end.
