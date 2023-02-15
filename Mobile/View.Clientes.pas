unit View.Clientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Layouts, FMX.ListBox;

type
  TfrmHospital = class(TForm)
    RectBackground: TRectangle;
    Text1: TText;
    StyleBook1: TStyleBook;
    ListBoxHospital: TListBox;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure LoadHospital;
    procedure AddHospital(const LOGO: TBitmap; NOME: String; ID: Integer);
  public
    { Public declarations }
  end;

var
  frmHospital: TfrmHospital;

implementation

{$R *.fmx}

uses Frame.Hospital;

{ TfrmHospital }

procedure TfrmHospital.AddHospital(const LOGO: TBitmap; NOME: String; ID: Integer);
var
  Item:  TListBoxItem;
  Frame: TFrameHospital;
begin
  Item := TListBoxItem.Create(ListBoxHospital);
  Item.Selectable := False;
  Item.Text := '';
  Item.Height := 64;
  Item.Tag := ID;
  ITem.TagString := NOME;

  Frame := TFrameHospital.Create(Item);
  Frame.txtHospital.Text := NOME;

  if LOGO <> nil then
  begin
    Frame.CircleLogo.Fill.Kind := TBrushKind.Bitmap;
    Frame.CircleLogo.Fill.Bitmap.Bitmap.LoadFromStream(nil);
  end
  else
    Frame.CircleLogo.Fill.Kind := TBrushKind.Solid;

  Item.AddObject(Frame);
  ListBoxHospital.AddObject(Item);
end;

procedure TfrmHospital.LoadHospital;
begin
  ListBoxHospital.Items.Clear;
  for var I := 0 to 10 do
    AddHospital(nil, 'Hospital Teste Sistema ' + I.ToString, I);
end;

procedure TfrmHospital.FormShow(Sender: TObject);
begin
  LoadHospital;
end;

end.
