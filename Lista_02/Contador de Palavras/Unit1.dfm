object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Contador de Repeti'#231#227'o'
  ClientHeight = 261
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object MemoTexto: TMemo
    Left = 8
    Top = 8
    Width = 489
    Height = 209
    TabOrder = 0
  end
  object btnChecarRepeticao: TButton
    Left = 422
    Top = 228
    Width = 75
    Height = 25
    Caption = 'Checar'
    TabOrder = 1
    OnClick = btnChecarRepeticaoClick
  end
  object CaseSensitive: TCheckBox
    Left = 8
    Top = 228
    Width = 97
    Height = 25
    Caption = 'Case Sensitive'
    TabOrder = 2
  end
end
