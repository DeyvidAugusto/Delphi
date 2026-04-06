unit InteiroParaRomano;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils;

type
  TForm1 = class(TForm)
    EdtNumeros: TEdit;
    BtnChecarIntToRom: TButton;
    procedure BtnChecarIntToRomClick(Sender: TObject);
  private
    const
      IntArray : array[0..12] of integer = (1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1);
      StrArray : array[0..12] of string = ('M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I');
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnChecarIntToRomClick(Sender: TObject);
var
  Numero, Index : integer;
  str : string;
begin
  try
    Numero := StrToInt(EdtNumeros.Text);
    Index := 0;
      while Numero > 0 do
        if Numero >= IntArray[Index] then
        begin
          str := str + StrArray[Index];
          Numero := Numero - IntArray[Index]
        end
        else
          Index := Index + 1;

    ShowMessage(str);

  except
    on E: Exception do
      ShowMessage(E.Message)
  end;
end;

end.
