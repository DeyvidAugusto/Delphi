unit exercicio6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
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
  contador : integer;
begin
  contador := 10;
  while contador > 0 do
    begin
      showMessage(inttostr(contador));
      contador := contador - 1;
      sleep(1000);
    end;
  showMessage('Feliz Ano Novo!');

end;

end.
