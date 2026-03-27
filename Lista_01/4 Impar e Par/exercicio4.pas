unit exercicio4;

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
  Valor : integer;
begin
  Valor := strtoint(Edit1.Text);
  if ((Valor mod 2) = 0) then
    showMessage('Par!')
  else
    showMessage('Impar!')
  
end;

end.
