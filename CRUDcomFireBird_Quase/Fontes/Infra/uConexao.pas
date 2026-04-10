unit uConexao;

interface

uses SqlExpr, SysUtils, Forms;

type
  TConexao = class
  private
    FConnection: TSQLConnection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Conectar;
    property Connection: TSQLConnection read FConnection;
  end;

implementation

constructor TConexao.Create;
begin
  FConnection := TSQLConnection.Create(nil);
end;

destructor TConexao.Destroy;
begin
  FConnection.Free;
  inherited;
end;

procedure TConexao.Conectar;
var
  FilePath: string;
begin
  FilePath := ExtractFilePath(Application.ExeName);

  FConnection.ConnectionName := 'IBConnection';
  FConnection.DriverName     := 'Interbase';
  FConnection.GetDriverFunc  := 'getSQLDriverINTERBASE';
  FConnection.LibraryName    := 'dbxint30.dll';
  FConnection.VendorLib      := 'fbclient.dll';
  FConnection.LoginPrompt    := False;

  FConnection.Params.Clear;
  FConnection.Params.Values['Database']   := 'localhost/3050:' + FilePath + 'Database\SISTEMA.FDB';
  FConnection.Params.Values['User_Name']  := 'SYSDBA';
  FConnection.Params.Values['Password']   := 'masterkey';
  FConnection.Params.Values['BlobSize']   := '-1';
  FConnection.Params.Values['SQLDialect'] := '3';

  FConnection.Connected := True;
end;

end.
