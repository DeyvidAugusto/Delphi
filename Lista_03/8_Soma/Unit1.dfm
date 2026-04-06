object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 118
  ClientWidth = 313
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 19
    Width = 131
    Height = 13
    Caption = 'Informe o primeiro numero:'
  end
  object Label2: TLabel
    Left = 8
    Top = 65
    Width = 134
    Height = 13
    Caption = 'Informe o segundo numero:'
    Visible = False
  end
  object Num1: TEdit
    Left = 145
    Top = 19
    Width = 121
    Height = 13
    BorderStyle = bsNone
    TabOrder = 0
    OnKeyDown = Num1KeyDown
  end
  object Num2: TEdit
    Left = 148
    Top = 62
    Width = 121
    Height = 13
    BorderStyle = bsNone
    TabOrder = 1
    Visible = False
    OnKeyDown = Num2KeyDown
  end
end
