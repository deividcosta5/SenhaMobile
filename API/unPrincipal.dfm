object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Servidor Senha Mobile'
  ClientHeight = 333
  ClientWidth = 306
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 306
    Height = 41
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 302
    DesignSize = (
      306
      41)
    object Label1: TLabel
      Left = 24
      Top = 13
      Width = 31
      Height = 15
      Caption = 'Porta:'
    end
    object spPorta: TSpinEdit
      Left = 61
      Top = 10
      Width = 76
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 8030
    end
    object btnIniciar: TButton
      Left = 152
      Top = 9
      Width = 139
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Iniciar'
      TabOrder = 1
      OnClick = btnIniciarClick
      ExplicitWidth = 135
    end
  end
  object MemoLog: TMemo
    Left = 0
    Top = 41
    Width = 306
    Height = 292
    Align = alClient
    Lines.Strings = (
      'MemoLog')
    TabOrder = 1
    ExplicitWidth = 302
    ExplicitHeight = 291
  end
end
