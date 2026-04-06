unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
  private
  public
     procedure ExibirLista(var Lista: TStringList);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
procedure TForm2.ExibirLista(var Lista : TStringList);
var
  I: Integer;
begin
  Memo1.Lines.Clear;
  for I := 0 to Lista.Count - 1 do
    Memo1.Lines.Add(Lista[I]);
  Self.Show;

end;

end.
