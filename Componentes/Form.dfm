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
  object CheckBox1: TCheckBox
    Left = 173
    Top = 86
    Width = 97
    Height = 17
    Caption = 'CNPJ'
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object CustomMaskEditCPFeCNPJ1: TCustomMaskEditCPFeCNPJ
    Left = 173
    Top = 109
    Width = 121
    Height = 21
    IsCNPJ = False
    IsCPF = True
  end
end
