unit Frame.Clientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.DialogService;

type
  TFrameClientes = class(TFrame)
    rectBackground: TRectangle;
    txtHospital: TText;
    procedure rectBackgroundClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses View.QRCode, View.Clientes, Controller.Clientes, Commons.Global;

procedure TFrameClientes.rectBackgroundClick(Sender: TObject);
var
  Cliente: TCliente;
begin
  for Cliente in ListaClientes do
  begin
    if Cliente.ID = Tag then
    begin
      if not Assigned(frmHospital.ClienteSelecionado) then
        frmHospital.ClienteSelecionado := TCliente.Create(Cliente.ID, Cliente.Nome, Cliente.EnderecoAPI, Cliente.IDFirebase);
      Break;
    end;
  end;
  if not Assigned(frmQRCode) then
    Application.CreateForm(TfrmQRCode, frmQRCode);

  Application.MainForm := frmQRCode;
  frmQRCode.Show;
  frmHospital.Close;
end;

end.
