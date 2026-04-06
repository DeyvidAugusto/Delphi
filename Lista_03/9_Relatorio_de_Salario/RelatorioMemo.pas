unit RelatorioMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    MemoRelatorio: TMemo;
  private

  public
    procedure ExibirMemoRelatorio(var Lista: TStringList);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.ExibirMemoRelatorio(var Lista: TStringList);
var
  I : integer;
begin
  MemoRelatorio.Lines.Clear;
  for I := 0 to Lista.Count - 1 do
    MemoRelatorio.Lines.Add(Lista[I]);
  Self.Show;
end;

end.
