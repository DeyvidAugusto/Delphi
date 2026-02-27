unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    EdtLetra: TEdit;
    Tmemo: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Palavra: string = 'Poggers'; {Pensei em colocar uma lista com nomes aleatorios, mas ainda tem outra atividade pra fazer :p}
  Lista : array of string;
  Erros : integer;
  memoString : string;

implementation

{$R *.dfm}
function ChecarLetra(x : string): boolean;
var
  I : integer;
  checar : string;
begin
  x := UpperCase(x);
  checar := '';
  for I := 0 to Length(Palavra) do
    if x = UpperCase(Palavra[I]) then
      checar := 's';
  if checar = 's' then
    Result := True

end;



procedure TForm1.Button1Click(Sender: TObject);
var
  Letra : string;
  posicao: integer;
begin
  Letra := EdtLetra.Text;
  SetLength(Lista, Length(Palavra));


  if Length(Letra) > 1 then
    ShowMessage('Digite apenas umas letra!')
  else
    Letra := UpperCase(Letra);
    Palavra := UpperCase(Palavra);
    posicao := 0;
    if ChecarLetra(Letra) then
    begin
    repeat
      posicao := PosEx(letra, Palavra, posicao + 1);
      if posicao > 0 then
      begin
        memoString[posicao] := Letra[1];
      end;
    until posicao = 0;
    end;
    if not ChecarLetra(Letra) then
    begin
      Erros := Erros + 1;
      ShowMessage('Você tem ' + inttostr(Erros) + ' erros');
      if Erros >= 6 then
      begin
        ShowMessage('Você perdeu :(');
        Close;
      end;
    end;
  if Tmemo.Text <> memoString then
  begin
    Tmemo.Text := memoString;
  end;
  if Pos('_', Tmemo.Text) = 0 then
  begin
    ShowMessage('Você Venceu!!');
    ShowMessage('Fechando o Programa');
    Close;

  end;




end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I : integer;
begin
  Erros := 0;
  for I := 0 to Length(Palavra) - 1 do
    Tmemo.Text := Tmemo.Text + '_';
  memoString := Tmemo.Text;

end;

end.
