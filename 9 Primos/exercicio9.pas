unit exercicio9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
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
  Numero, i : integer;
begin
  Numero := strtoint(Edit1.Text);
  if Numero = 1 then
    showMessage('é primo')
  else if Numero > 1 then
    for i := 2 to Numero do
      begin
      if (Numero = 2) then
        showMessage('è primo')
      else if Numero mod i <> 0 then
        showMessage('è primo')
      else
        showMessage('Não é primo');
        Break
      end
  else if Numero = 0 then
    showMessage('O numero é 0')
  else
    showMessage('é negativo');
       

end;

end.
