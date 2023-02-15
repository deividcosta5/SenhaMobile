unit View.QRCode;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Objects, u99Permissions;

type
  TfrmQRCode = class(TForm)
    Text1: TText;
    RectBackground: TRectangle;
    ImgScan: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImgScanClick(Sender: TObject);
  private
    { Private declarations }
    Permissao: T99Permissions;
  public
    { Public declarations }
  end;

var
  frmQRCode: TfrmQRCode;

implementation

{$R *.fmx}

uses View.Camera;

procedure TfrmQRCode.FormCreate(Sender: TObject);
begin
  Permissao := T99Permissions.Create;
end;

procedure TfrmQRCode.FormDestroy(Sender: TObject);
begin
  Permissao.DisposeOf;
end;

procedure TfrmQRCode.ImgScanClick(Sender: TObject);
begin
  if not Permissao.VerifyCameraAccess then
    Permissao.Camera(nil,nil)
  else
  begin
    if NOT Assigned(frmCamera) then
      Application.CreateForm(TfrmCamera, frmCamera);
    {Application.MainForm := frmCamera;}
    frmCamera.ShowModal(procedure(ModalResult: TModalResult)
    begin
      ShowMessage(frmCamera.Codigo);
    end);
  end;
end;

end.
