unit Barco;

interface
uses
  Veiculo, SysUtils, Classes, Dialogs;

type
  TBarco = class(TVeiculo)
    private
    public
      procedure Mover(); override;
      procedure Parar(); override;
  end;


implementation

procedure TBarco.Mover();
begin
  ShowMessage(Format('%s começou a navegar', [Nome]));
end;

procedure TBarco.Parar();
begin
  ShowMessage(Format('%s parou de navegar', [Nome]));
end;
end.
