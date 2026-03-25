unit Paginador;

interface
uses
  Classes, SysUtils, Math, ArrayHelper;

type
  TintArray = TMyIntArray;
  TPaginador = class
  private
    FLista: TintArray;
    FItensPorPagina: integer;
    FPaginaAtual: integer;
    function GetTotalPaginas: integer;
    function GetPaginaCorrente: integer;
  public
    constructor Create(ItensPorPagina: integer);
    destructor Destroy; override;
    procedure CarregarLista(Lista: TintArray);
    function ObterPaginaAtual: TintArray;
    function ProximaPagina: TintArray;
    function PaginaAnterior: TintArray;
    property TotalPaginas: integer read GetTotalPaginas;
    property PaginaCorrente: integer read GetPaginaCorrente;
  end;

implementation

constructor TPaginador.Create(ItensPorPagina: integer);
begin
  inherited Create;
  FItensPorPagina := ItensPorPagina;
  FPaginaAtual := 0;
  FLista := nil;
end;

destructor TPaginador.Destroy;
begin
  inherited;
end;

procedure TPaginador.CarregarLista(Lista: TintArray);
begin
  FLista := copy(Lista);
  FPaginaAtual := 0;
end;

function TPaginador.GetTotalPaginas: integer;
begin
  if (FLista = nil) or (FItensPorPagina = 0) then
    Result := 0
  else
    Result := Ceil(Length(FLista) / FItensPorPagina);
end;

function TPaginador.GetPaginaCorrente: integer;
begin
  Result := FPaginaAtual + 1;
end;

function TPaginador.ObterPaginaAtual: TintArray;
var
  I, Inicio, Fim, IndexAux: integer;
begin
  if FLista = nil then
    Exit;

  Inicio := FPaginaAtual * FItensPorPagina;
  Fim := Min(Inicio + FItensPorPagina - 1, Length(FLista) - 1);
  IndexAux := 0;
  SetLength(Result, FItensPorPagina);

  for I := Inicio to Fim do
  begin
    Result[IndexAux] := FLista[I];
    Inc(IndexAux);
  end;
end;

function TPaginador.ProximaPagina: TintArray;
begin
  if FPaginaAtual >= TotalPaginas - 1 then
    raise Exception.Create('Já está na última página');

  Inc(FPaginaAtual);
  Result := ObterPaginaAtual;
end;

function TPaginador.PaginaAnterior: TintArray;
begin
  if FPaginaAtual = 0 then
    raise Exception.Create('Já está na primeira página');

  Dec(FPaginaAtual);
  Result := ObterPaginaAtual;
end;

end.
