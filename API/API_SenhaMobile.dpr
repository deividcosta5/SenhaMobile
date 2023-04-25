program API_SenhaMobile;

uses
  Vcl.Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  Controller.Global in 'Controller\Controller.Global.pas',
  DataModule.Global in 'DataModule\DataModule.Global.pas' {DMGlobal: TDataModule},
  Controller.Cadastro in 'Controller\Controller.Cadastro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
