unit Veiculo;

interface
uses
  Windows, SysUtils, Classes, Dialogs;

type
  TVeiculo = class
  Nome : string;
  tipo: string;
  marca: string;
    private
    public
      procedure Mover(); virtual; abstract;
      procedure Parar(); virtual; abstract;
      procedure Info();
  end;
implementation

procedure TVeiculo.Info();
begin
  ShowMessage('Seu veiculo é um ' + tipo + #13 + 'Marca: ' + marca);
end;

end.
