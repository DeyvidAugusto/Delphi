unit exercicio7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
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

procedure TForm1.Button1Click(Sender: TObject);
var
  Valor1, Valor2, Valor3 : integer;
begin
  Valor1 := strtoint(Edit1.Text);
  Valor2 := strtoint(Edit2.Text);
  Valor3 := strtoint(Edit3.Text);

  if (Valor1 > Valor2) and (Valor1 > Valor3) then
    showMessage('O maior valor é o primeiro: ' + inttostr(Valor1))
  else if (Valor2 > Valor1) and (Valor2 > Valor3) then
    showMessage('O maior valor é o segundo: ' + inttostr(Valor2))
  else if (Valor3 > Valor1) and (Valor3 > Valor2) then
    showMessage('O maior numero é o terceiro: ' + inttostr(Valor3));

  if (Valor1 < Valor2) and (Valor1 < Valor3) then
    showMessage('O Menor valor é o primeiro: ' + inttostr(Valor1))
  else if (Valor2 < Valor1) and (Valor2 < Valor3) then
    showMessage('O Menor valor é o segundo: ' + inttostr(Valor2))
  else if (Valor3 < Valor1) and (Valor3 < Valor2) then
    showMessage('O Menor numero é o terceiro: ' + inttostr(Valor3))
  else if (Valor1 = Valor2) or (Valor1 = Valor3) or (Valor2 = Valor3) then
    showMessage('Você tem  numeros iguais');
       
  
end;

end.
