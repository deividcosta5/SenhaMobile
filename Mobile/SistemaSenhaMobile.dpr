program SistemaSenhaMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Clientes in 'View.Clientes.pas' {frmHospital},
  Frame.Hospital in 'Frame.Hospital.pas' {FrameHospital: TFrame},
  View.QRCode in 'View.QRCode.pas' {frmQRCode},
  u99Permissions in 'u99Permissions.pas',
  View.Camera in 'View.Camera.pas' {frmCamera};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHospital, frmHospital);
  Application.Run;
end.
