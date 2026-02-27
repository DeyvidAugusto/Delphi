unit exercicio3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
  Valor1, Valor2, Soma : double;
begin
  Valor1 := strtofloat(Edit1.Text);
  Valor2 := strtofloat(Edit2.Text);
  Soma := Valor1+Valor2;

  ShowMessage('O Resultado da soma é: '+ floattostr(Soma));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Valor1, Valor2, Sub : double;
begin
  Valor1 := strtofloat(Edit1.Text);
  Valor2 := strtofloat(Edit2.Text);
  Sub := Valor1-Valor2;

  ShowMessage('O Resultado da subtração é: '+ floattostr(Sub));
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Valor1, Valor2, Mult : double;
begin
  Valor1 := strtofloat(Edit1.Text);
  Valor2 := strtofloat(Edit2.Text);
  Mult := Valor1*Valor2;

  ShowMessage('O Resultado da multiplicação é: '+ floattostr(Mult));
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Valor1, Valor2, Divs : double;
begin
  Valor1 := strtofloat(Edit1.Text);
  Valor2 := strtofloat(Edit2.Text);
  Divs := Valor1/Valor2;

  ShowMessage('O Resultado da divisão é: '+ floattostr(Divs));
end;

end.
