unit View.Senha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Objects;

type
  TfrmSenha = class(TForm)
    RectBackground: TRectangle;
    ListBoxSenha: TListBox;
    txtSenha: TText;
  private
    { Private declarations }
    procedure LoadStatus;
    procedure AddStatus(const SETOR, SALA: String; ID: Integer; DATAHORA: TDateTime);
  public
    { Public declarations }
  end;

var
  frmSenha: TfrmSenha;

implementation

{$R *.fmx}

uses Frame.Senha;

{ TForm1 }

procedure TfrmSenha.AddStatus(const SETOR, SALA: String; ID: Integer;
  DATAHORA: TDateTime);
var
  Item:  TListBoxItem;
  Frame: TFrameSenha;
begin
  Item := TListBoxItem.Create(ListBoxSenha);
  Item.Selectable := False;
  Item.Text := '';
  Item.Height := 70;
  Item.Tag := ID;
  ITem.TagString := SETOR + '|' + SALA;

  Frame := TFrameSenha.Create(Item);
  Frame.txtSenha.Text := SETOR + ' - ' + SALA;
  Frame.txrDataHora.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS', DATAHORA);

  Item.AddObject(Frame);
  ListBoxSenha.AddObject(Item);
end;

procedure TfrmSenha.LoadStatus;
begin
  ListBoxSenha.Items.Clear;
  for var I := 0 to 10 do
    AddStatus('RECEPÇÃO', 'GUICHE 1', I, Now());
end;

end.
