unit GeradorLista;

interface
uses
  Classes, SysUtils, ArrayHelper;

type
  TintArray = TMyIntArray;
  TGeradorLista = class
  public
    class function GerarAleatorio(Quantidade: integer): TintArray;
  end;

implementation

class function TGeradorLista.GerarAleatorio(Quantidade: integer): TintArray;
var
  ListaTemp: TintArray;
  I, NumRandom : integer;

begin
  Randomize;
  try
    SetLength(ListaTemp, Quantidade);
    for I := 0 to Quantidade do
    begin
      NumRandom := Random(MaxInt);
      if not IndexOfInteger(ListaTemp, NumRandom) <> -1 then
         ListaTemp[I] := NumRandom;
    end;

    Result := copy(ListaTemp);

  except
    raise;
  end;
end;

end.
