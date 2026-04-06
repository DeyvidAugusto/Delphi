unit Aviao;

interface
uses
  Veiculo, SysUtils, Classes, Dialogs;

type
  TAviao = class(TVeiculo)
    private
    public
      procedure Mover(); override;
      procedure Parar(); override;
  end;


implementation

procedure TAviao.Mover();
begin
  ShowMessage(Format('%s começou a voar', [Nome]));
end;

procedure TAviao.Parar();
begin
  ShowMessage(Format('%s parou de voar', [Nome]));
end;

end.
