object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Tabuada'
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
    Left = 192
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Numero'
  end
  object Button1: TButton
    Left = 208
    Top = 144
    Width = 89
    Height = 25
    Caption = 'Gerar tabuada'
    TabOrder = 1
    OnClick = Button1Click
  end
end
