unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Num1: TEdit;
    Num2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Num1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Num2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    Numero1 : integer;
    Numero2 : integer;
    Soma : integer;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Num1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then
  begin
  try
    Numero1 := strtoint(Num1.Text);
    Num2.Visible := True;
    Label2.Visible := True;
    Num2.SetFocus;
  except
    on E: Exception do
      ShowMessage(E.Message);

  end;
  end;

end;


procedure TForm1.Num2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then
  begin
  try
    Numero2 := strtoint(Num2.Text);
    Soma := Numero1 + Numero2;
    ShowMessage('O Resultado da some é ' + inttostr(Soma));
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  end;
end;



end.
