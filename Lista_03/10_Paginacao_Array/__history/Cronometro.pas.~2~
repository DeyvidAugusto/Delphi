unit Cronometro;

interface
uses
  Windows, SysUtils;

type
  TCronometro = class
  private
    FInicio: Int64; {Integer normal não estava funcionado, talvez problema com o QueryPerformance?}
    FFrequencia: Int64;
  public
    constructor Create;
    procedure Iniciar;
    function TempoDecorrido: string;
  end;

implementation

constructor TCronometro.Create;
begin
  inherited;
  QueryPerformanceFrequency(FFrequencia);
end;

procedure TCronometro.Iniciar;
begin
  QueryPerformanceCounter(FInicio);
end;

function TCronometro.TempoDecorrido: string;
var
  Fim: Int64;
  TempoMs: double;
begin
  QueryPerformanceCounter(Fim);
  TempoMs := ((Fim - FInicio) / FFrequencia) * 1000;
  Result := FormatFloat('0.000', TempoMs) + ' ms';
end;

end.
