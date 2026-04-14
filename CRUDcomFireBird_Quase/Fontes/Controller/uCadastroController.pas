unit uCadastroController;

interface

uses uUsuarioDAO, SqlExpr, SysUtils;

type
  TCadastroController = class
  private
    FDAO: TUsuarioDAO;
  public
    constructor Create(AConn: TSQLConnection);
    destructor Destroy; override;
    function ProximoID: Integer;
    function ValidarID(AID: Integer; out Mensagem: string): Boolean;
    function BuscarPorID(AID: Integer; out Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco: string): Boolean;
    procedure Salvar(ID: Integer; Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco: string);
    procedure Alterar(ID: Integer; Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco: string);
    procedure Deletar(AID: Integer);
  end;

implementation

constructor TCadastroController.Create(AConn: TSQLConnection);
begin
  FDAO := TUsuarioDAO.Create(AConn);
end;

destructor TCadastroController.Destroy;
begin
  FDAO.Free;
  inherited;
end;

function TCadastroController.ProximoID: Integer;
begin
  Result := FDAO.ProximoID;
end;

function TCadastroController.ValidarID(AID: Integer; out Mensagem: string): Boolean;
begin
  Result := False;
  if AID <= 0 then
  begin
    Mensagem := 'ID deve ser maior que zero.';
    Exit;
  end;
  if not FDAO.isIDDisponivel(AID) then
  begin
    Mensagem := 'ID já cadastrado. Digite um ID válido.';
    Exit;
  end;
  Result := True;
end;

function TCadastroController.BuscarPorID(AID: Integer;
  out Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco: string): Boolean;
var
  Q: TSQLQuery;
begin
  Result := False;
  Q := FDAO.BuscarPorID(AID);
  try
    if Q.IsEmpty then
      Exit;

    Nome        := Q.FieldByName('NOME').AsString;
    CPF         := Q.FieldByName('CPF').AsString;
    Telefone    := Q.FieldByName('TELEFONE').AsString;
    { Converte a data do banco para dd/mm/yyyy para os MaskEdits do form }
    Nascimento  := FormatDateTime('dd/mm/yyyy', Q.FieldByName('DATANASCIMENTO').AsDateTime);
    EstadoCivil := Q.FieldByName('ESTADOCIVIL').AsString;
    Endereco    := Q.FieldByName('ENDERECO').AsString;
    Result := True;
  finally
    Q.Free;
  end;
end;

procedure TCadastroController.Salvar(ID: Integer; Nome, CPF, Telefone,
                                       Nascimento, EstadoCivil, Endereco: string);
begin
   FDAO.Inserir(ID, Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco);
end;

procedure TCadastroController.Alterar(ID: Integer; Nome, CPF, Telefone,
                                       Nascimento, EstadoCivil, Endereco: string);
begin
  if Trim(Nome) = '' then
    raise Exception.Create('Nome é obrigatório.');
  if Trim(CPF) = '' then
    raise Exception.Create('CPF é obrigatório.');

  FDAO.Atualizar(ID, Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco);
end;

procedure TCadastroController.Deletar(AID: Integer);
begin
  if AID <= 0 then
    raise Exception.Create('ID inválido para exclusão.');

  FDAO.Deletar(AID);
end;

end.
