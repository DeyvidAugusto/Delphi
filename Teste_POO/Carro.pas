unit Carro;

interface
uses
  Veiculo, SysUtils, Classes, Dialogs;

type
  TCarro = class(TVeiculo)
    private
    public
      procedure Mover(); override;
      procedure Parar(); override;
  end;


implementation

procedure TCarro.Mover();
begin
  ShowMessage(Format('%s começou a andar', [Nome]));
end;

procedure TCarro.Parar();
begin
  ShowMessage(Format('%s Parou de andar', [Nome]));
end;

end.
