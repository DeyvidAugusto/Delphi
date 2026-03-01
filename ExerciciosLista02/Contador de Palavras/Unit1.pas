unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, StrUtils, Unit2;

type
  TForm1 = class(TForm)
    MemoTexto: TMemo;
    btnChecarRepeticao: TButton;
    CaseSensitive: TCheckBox;
    procedure btnChecarRepeticaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Texto: string;

implementation

{$R *.dfm}

procedure TForm1.btnChecarRepeticaoClick(Sender: TObject);
var
  I: Integer;
  Lista: TStringList;
  ListaSemDup: TStringList;
  MemoResultado: TForm2;
  TotalPalavras: Integer;
  porcento: Double;
  Contagens: array of Integer;
  Posicao: Integer;
begin
  SetLength(Contagens, 0);

  Texto := MemoTexto.Text;

  Lista := TStringList.Create;
  ListaSemDup := TStringList.Create;
  try
    MemoResultado := TForm2.Create(Application);

    ListaSemDup.Duplicates    := dupIgnore;
    ListaSemDup.CaseSensitive := CaseSensitive.Checked;

    Lista.CommaText := Texto;

    TotalPalavras := Lista.Count;

    if TotalPalavras = 0 then
    begin
      MemoResultado.Free;
      Exit;
    end;

    MemoResultado.Resultado.Clear;
    MemoResultado.Resultado.Lines.Add(Format('Total de palavras: %d', [TotalPalavras]));
    MemoResultado.Resultado.Lines.Add('Palavra              | Qtde | Porcentagem');
    MemoResultado.Resultado.Lines.Add('------------------------------------------');

    for I := 0 to Lista.Count - 1 do
    begin
      if ListaSemDup.IndexOf(Lista[I]) = -1 then
      begin
        ListaSemDup.Add(Lista[I]);
        SetLength(Contagens, Length(Contagens) + 1);
        Contagens[High(Contagens)] := 1;
      end
      else
      begin
        Posicao := ListaSemDup.IndexOf(Lista[I]);
        Inc(Contagens[Posicao]);
      end;
    end;

    for I := 0 to ListaSemDup.Count - 1 do
    begin
      porcento := (Contagens[I] / TotalPalavras) * 100;
      MemoResultado.Resultado.Lines.Add(
        Format('%-20s | %4d | %6.2f%%', [ListaSemDup[I], Contagens[I], porcento])
      );
    end;

    MemoResultado.Show;

  finally
    Lista.Free;
    ListaSemDup.Free;
  end;
end;

end.
