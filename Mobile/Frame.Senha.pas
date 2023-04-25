unit Frame.Senha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Effects;

type
  TFrameSenha = class(TFrame)
    rectBackground: TRectangle;
    Layout1: TLayout;
    txtSenha: TText;
    txrDataHora: TText;
    ShadowEffect1: TShadowEffect;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
