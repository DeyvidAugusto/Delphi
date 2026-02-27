object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Checar numeros primos'
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
    Left = 176
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Digite um numero'
  end
  object Button1: TButton
    Left = 200
    Top = 131
    Width = 75
    Height = 25
    Caption = 'Checar primo'
    TabOrder = 1
    OnClick = Button1Click
  end
end
