unit Paginador;

interface
uses
  Classes, SysUtils, Math;

type
  TPaginador = class
  private
    FLista: TStringList;
    FItensPorPagina: integer;
    FPaginaAtual: integer;
    function GetTotalPaginas: integer;
    function GetPaginaCorrente: integer;
  public
    constructor Create(ItensPorPagina: integer);
    destructor Destroy; override;
    procedure CarregarLista(Lista: TStringList);
    function ObterPaginaAtual: TStringList;
    function ProximaPagina: TStringList;
    function PaginaAnterior: TStringList;
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

procedure TPaginador.CarregarLista(Lista: TStringList);
begin
  FLista := Lista;
  FPaginaAtual := 0;
end;

function TPaginador.GetTotalPaginas: integer;
begin
  if (FLista = nil) or (FItensPorPagina = 0) then
    Result := 0
  else
    Result := Ceil(FLista.Count / FItensPorPagina);
end;

function TPaginador.GetPaginaCorrente: integer;
begin
  Result := FPaginaAtual + 1;
end;

function TPaginador.ObterPaginaAtual: TStringList;
var
  I, Inicio, Fim: integer;
begin
  Result := TStringList.Create;
  if FLista = nil then Exit;

  Inicio := FPaginaAtual * FItensPorPagina;
  Fim    := Min(Inicio + FItensPorPagina - 1, FLista.Count - 1);

  for I := Inicio to Fim do
    Result.Add(FLista[I]);
end;

function TPaginador.ProximaPagina: TStringList;
begin
  if FPaginaAtual >= TotalPaginas - 1 then
    raise Exception.Create('Já está na última página');

  Inc(FPaginaAtual);
  Result := ObterPaginaAtual;
end;

function TPaginador.PaginaAnterior: TStringList;
begin
  if FPaginaAtual = 0 then
    raise Exception.Create('Já está na primeira página');

  Dec(FPaginaAtual);
  Result := ObterPaginaAtual;
end;

end.
