unit exercicio2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
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
  Valor1, Valor2, Valor3, Valor4, total : integer;

begin
  Valor1 := strtoint(Edit1.Text);
  Valor2 := strtoint(Edit2.Text);
  Valor3 := strtoint(Edit3.Text);
  Valor4 := strtoint(Edit4.Text);
  total := (Valor1+Valor2+Valor3+Valor4)/4;

  ShowMessage('A media é ' + floattostr(total))
end;

end.
