unit exercicio8;

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
  Palavra : string;
  i, contador : integer;
begin
  contador := 0;
  Palavra := lowercase(Edit1.Text);
  for i := 0 to length(Palavra) do
    if Palavra[i] = 'a' then
      contador := contador + 1
    else if Palavra[i] = 'e' then
      contador := contador + 1
    else if Palavra[i] = 'i' then
      contador := contador + 1
    else if Palavra[i] = 'o' then
      contador := contador + 1
    else if Palavra[i] = 'u' then
      contador := contador + 1;
  showMessage('Sua palavra tem ' + inttostr(contador) + ' vogais')



end;

end.
