unit uUsuarioDAO;

interface

uses SqlExpr, DB, SimpleDS, SysUtils, FireDAC.Comp.Client;

type
   TUsuarioDAO = class
      private
         FConn : TFDConnection {TSQLConnection};
         function NovaQuery : TFDQuery; //TSQLQuery;
      public
         constructor Create(AConn : TFDConnection {TSQLConnection});
         function ProximoID: Integer;
         function isIDDisponivel(AID: integer): boolean;
         function CarregarUsuarios: TFDQuery;
         procedure Inserir(ID: Integer; Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco: string);
         procedure Deletar(AID: Integer);
         procedure Atualizar(ID: Integer; Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco: string);
   end;

implementation

constructor TUsuarioDAO.Create(AConn : TFDConnection {TSQLConnection});
begin
   FConn := AConn;
end;

function TUsuarioDAO.NovaQuery: TFDQuery;//TSQLQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConn;
end;

function TUsuarioDAO.ProximoID: integer;
var
   Q: TFDQuery;
begin
   Q := NovaQuery;
   try
      Q.SQL.Text := 'SELECT MAX(ID) AS ultimo_id FROM USUARIOS';
      Q.Open;
      Result := Q.FieldByName('ultimo_id').AsInteger + 1;
   finally
      Q.Free;
   end;
end;

function TUsuarioDAO.isIDDisponivel(AID: Integer): boolean;
var
   Q : TFDQuery;
begin
   Q := NovaQuery;
   try
      Q.SQL.Text := 'SELECT 1 FROM USUARIOS WHERE ID = :id';
      Q.ParamByName('id').AsInteger := AID;
      Q.Open;
      Result := Q.IsEmpty
   finally
      Q.Free;
   end;
end;

procedure TUsuarioDAO.Inserir(ID: Integer; Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco: string);
var
  Q: TFDQuery;
begin
  Q := NovaQuery;
  try
    Q.SQL.Text :=
      'INSERT INTO USUARIOS (ID, NOME, CPF, TELEFONE, NASCIMENTO, ESTADO_CIVIL, ENDERECO) ' +
      'VALUES (:id, :nome, :cpf, :tel, :nasc, :ec, :end)';
    Q.ParamByName('id').AsInteger  := ID;
    Q.ParamByName('nome').AsString := Nome;
    Q.ParamByName('cpf').AsString  := CPF;
    Q.ParamByName('tel').AsString  := Telefone;
    Q.ParamByName('nasc').AsString := Nascimento;
    Q.ParamByName('ec').AsString   := EstadoCivil;
    Q.ParamByName('end').AsString  := Endereco;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

procedure TUsuarioDAO.Deletar(AID: Integer);
var
  Q: TFDQuery;
begin
  Q := NovaQuery;
  try
    Q.SQL.Text := 'DELETE FROM USUARIOS WHERE ID = :id';
    Q.ParamByName('id').AsInteger := AID;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

function TUsuarioDAO.CarregarUsuarios: TFDQuery;
begin
   Result := NovaQuery;
   Result.SQL.Text := 'SELECT * FROM USUARIOS';
   Result.Open;

end;

procedure TUsuarioDAO.Atualizar(ID: Integer; Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco: string);
var
  Q: TFDQuery;
begin
  Q := NovaQuery;
  try
    Q.SQL.Text :=
      'UPDATE USUARIOS SET ' +
      'NOME = :nome, CPF = :cpf, TELEFONE = :tel, ' +
      'NASCIMENTO = :nasc, ESTADO_CIVIL = :ec, ENDERECO = :end ' +
      'WHERE ID = :id';
    Q.ParamByName('nome').AsString := Nome;
    Q.ParamByName('cpf').AsString  := CPF;
    Q.ParamByName('tel').AsString  := Telefone;
    Q.ParamByName('nasc').AsString := Nascimento;
    Q.ParamByName('ec').AsString   := EstadoCivil;
    Q.ParamByName('end').AsString  := Endereco;
    Q.ParamByName('id').AsInteger  := ID;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

end.
