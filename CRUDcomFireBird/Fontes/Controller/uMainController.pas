unit uMainController;

interface

uses uConexao, uUsuarioDAO, SqlExpr, SysUtils;

type
  TMainController = class
  private
    FConexao : TConexao;
    FDAO     : TUsuarioDAO;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Conectar;
    function CarregarUsuarios: TSQLQuery;
    procedure DeletarUsuario(AID: Integer);
    property Connection: TSQLConnection read FConexao.Connection;
  end;

implementation

constructor TMainController.Create;
begin
  FConexao := TConexao.Create;
  // DAO criado após conectar
end;

destructor TMainController.Destroy;
begin
  FDAO.Free;
  FConexao.Free;
  inherited;
end;

procedure TMainController.Conectar;
begin
  FConexao.Conectar;
  FDAO := TUsuarioDAO.Create(FConexao.Connection);
end;

function TMainController.CarregarUsuarios: TSQLQuery;
begin
  Result := FDAO.CarregarTodos;
end;

procedure TMainController.DeletarUsuario(AID: Integer);
begin
  if AID <= 0 then
    raise Exception.Create('Selecione um usuário válido para deletar.');
  FDAO.Deletar(AID);
end;

end.