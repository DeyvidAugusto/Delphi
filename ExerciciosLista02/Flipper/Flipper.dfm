object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 261
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 104
    Top = 56
    Width = 87
    Height = 13
    Caption = 'Digite o Valor de P'
  end
  object Label2: TLabel
    Left = 328
    Top = 56
    Width = 88
    Height = 13
    Caption = 'Digite o Valor de R'
  end
  object EdtP: TEdit
    Left = 88
    Top = 75
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'EdtP'
  end
  object EdtR: TEdit
    Left = 312
    Top = 75
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'EdtR'
  end
  object Button1: TButton
    Left = 216
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Jogar'
    TabOrder = 2
    OnClick = Button1Click
  end
end
