unit Flipper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    EdtP: TEdit;
    EdtR: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function ValidarNum(Num1, Num2: integer): boolean;
begin
  if (Num1 in [0, 1]) and (Num2 in [0, 1]) then
    Result := True

end;


procedure TForm1.Button1Click(Sender: TObject);
var
  P, R : integer;
  Resultado : string;
begin
  Resultado := '';
  P := strtoint(EdtP.Text);
  R := strtoint(EdtR.Text);

  if ValidarNum(P, R) then
    if (P = 1) and (R = 1) then
      Resultado := 'A'
    else
    if (P = 1) and (R = 0) then
      Resultado := 'B'
    else
    if (P = 0) then
      Resultado := 'C';
    if Resultado <> '' then
      ShowMessage('O Resultado é: ' + Resultado)
    else
      ShowMessage('Input invalido Digite 0 ou 1!')

end;

end.
