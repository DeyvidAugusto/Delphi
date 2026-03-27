object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Maior numero'
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
  object Edit1: TEdit
    Left = 152
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Numero 1'
  end
  object Edit2: TEdit
    Left = 152
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Numero 2'
  end
  object Edit3: TEdit
    Left = 152
    Top = 152
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Numero 3'
  end
  object Button1: TButton
    Left = 168
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Checar'
    TabOrder = 3
    OnClick = Button1Click
  end
end
