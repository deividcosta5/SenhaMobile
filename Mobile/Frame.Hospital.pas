unit Frame.Hospital;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.DialogService;

type
  TFrameHospital = class(TFrame)
    rectBackground: TRectangle;
    txtHospital: TText;
    CircleLogo: TCircle;
    procedure rectBackgroundClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses View.QRCode, View.Clientes;

procedure TFrameHospital.rectBackgroundClick(Sender: TObject);
begin
  if NOT Assigned(frmQRCode) then
    Application.CreateForm(TfrmQRCode, frmQRCode);

  Application.MainForm := frmQRCode;
  frmQRCode.Show;
  frmHospital.Close;
end;

end.
