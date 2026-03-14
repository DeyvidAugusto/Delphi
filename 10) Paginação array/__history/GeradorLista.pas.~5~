unit GeradorLista;

interface
uses
  Classes, SysUtils;

type
  TGeradorLista = class
  public
    class function GerarAleatorio(Quantidade: integer): TStringList;
  end;

implementation

class function TGeradorLista.GerarAleatorio(Quantidade: integer): TStringList;
var
  ListaTemp: TStringList;
  I, J: integer;
  Temp: string;
begin
  Randomize;
  ListaTemp := TStringList.Create;
  try
    for I := 1 to Quantidade do
      ListaTemp.Add(IntToStr(I));

    for I := ListaTemp.Count - 1 downto 1 do
    begin
      J       := Random(I + 1);
      Temp    := ListaTemp[I];
      ListaTemp[I] := ListaTemp[J];
      ListaTemp[J] := Temp;
    end;

    Result := ListaTemp;
  except
    ListaTemp.Free;
    raise;
  end;
end;

end.
