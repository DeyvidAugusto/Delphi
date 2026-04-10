unit uMainFormController;

interface

uses uConexao, uUsuarioDAO, SqlExpr, SysUtils, SimpleDS, FireDAC.Comp.Client;


type
  TMainController = class
  private
    FConexao : TConexao;
    FDAO     : TUsuarioDAO;
    function GetConnection: TFDConnection; //TSQLConnection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Conectar;
    function CarregarUsuarios: TFDQuery;
    procedure DeletarUsuario(AID: Integer);
    property Connection: TFDConnection {TSQLConnection} read GetConnection;
  end;

implementation

constructor TMainController.Create;
begin
   FConexao := TConexao.Create;
end;

destructor TMainController.Destroy;
begin
  FDAO.Free;
  FConexao.Free;
  inherited;
end;

function TMainController.GetConnection: TFDConnection; //TSQLConnection;
begin
  Result := FConexao.Connection;
end;

procedure TMainController.Conectar;
begin
   FConexao.Conectar;
   FDAO := TUsuarioDAO.Create(FConexao.Connection);
end;

function TMainController.CarregarUsuarios: TFDQuery;
begin
   Result := FDAO.CarregarUsuarios;
end;

procedure TMainController.DeletarUsuario(AID: Integer);
begin
  if AID <= 0 then
    raise Exception.Create('Selecione um usuário válido para deletar.');
  FDAO.Deletar(AID);
end;

end.
