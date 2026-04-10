unit uConexao;

interface

uses SqlExpr, SysUtils, Forms,
     FireDAC.Comp.Client, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Def, FireDAC.DApt,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,     // <-- esta
  FireDAC.Stan.Intf;

type
  TConexao = class
  private
    // FConnection: TSQLConnection;
    FConnection: TFDConnection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Conectar;
    // property Connection: TSQLConnection read FConnection;
    property Connection: TFDConnection read FConnection;
  end;

implementation

constructor TConexao.Create;
begin
  // FConnection := TSQLConnection.Create(nil);
  FConnection := TFDConnection.Create(nil);
end;

destructor TConexao.Destroy;
begin
  FConnection.Free;
  inherited;
end;

{procedure TConexao.Conectar;
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
end;}

procedure TConexao.Conectar;
var
  FilePath: string;
  DriverLink: TFDPhysIBDriverLink;
begin
  DriverLink := TFDPhysIBDriverLink.Create(nil);
  DriverLink.VendorLib := 'C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll';

  // NÃO libere o DriverLink aqui - mantenha vivo durante a conexão
  // Guarde como campo da classe se necessário

  FilePath := ExtractFilePath(Application.ExeName);
  FConnection.LoginPrompt := False;
  FConnection.Params.Clear;
  FConnection.Params.Values['DriverID']     := 'IB';
  FConnection.Params.Values['Database']     := 'localhost/3050:' + FilePath + 'Database\TESTE.FDB';
  FConnection.Params.Values['User_Name']    := 'SYSDBA';
  FConnection.Params.Values['Password']     := 'masterkey';
  FConnection.Params.Values['SQLDialect']   := '3';
  FConnection.Params.Values['CharacterSet'] := 'UTF8';
  FConnection.Connected := True;
end;
end.
