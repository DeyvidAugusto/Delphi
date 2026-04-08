unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, WideStrings, ExtCtrls, DB, SqlExpr, FMTBcd,
  DBClient, SimpleDS;

type
  TForm1 = class(TForm)
    GridUsuarios: TDBGrid;
    SpBntInserir: TSpeedButton;
    SpBntAlterar: TSpeedButton;
    SpBntDeletar: TSpeedButton;
    SpBntFiltrar: TSpeedButton;
    SpBntSair: TSpeedButton;
    Panel1: TPanel;
    DataSourceDb: TDataSource;
    SQLConnectionDb: TSQLConnection;
    SimpleDataSetDb: TSimpleDataSet;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ConectarBanco;
    procedure CarregarUsuarios;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ConectarBanco;
  CarregarUsuarios;
end;

procedure TForm1.ConectarBanco;
var
  FILEPATH: string;
begin
  FILEPATH := ExtractFilePath(Application.ExeName);

  SQLConnectionDb.ConnectionName := 'IBConnection';
  SQLConnectionDb.DriverName     := 'Interbase';
  SQLConnectionDb.GetDriverFunc  := 'getSQLDriverINTERBASE';
  SQLConnectionDb.LibraryName    := 'dbxint.dll';
  SQLConnectionDb.VendorLib      := 'fbclient.dll';

  SQLConnectionDb.Params.Clear;
  SQLConnectionDb.Params.Values['Database']  := FILEPATH + 'Database\SISTEMA.FDB';
  SQLConnectionDb.Params.Values['User_Name'] := 'SYSDBA';
  SQLConnectionDb.Params.Values['Password']  := 'masterkey';
  SQLConnectionDb.Params.Values['BlobSize']  := '-1';

  SQLConnectionDb.LoginPrompt := False;
  SQLConnectionDb.Connected   := True;
end;

procedure TForm1.CarregarUsuarios;
begin
  SimpleDataSetDb.Active := False;
  SimpleDataSetDb.Connection          := SQLConnectionDb;
  SimpleDataSetDb.DataSet.CommandType := ctQuery;
  SimpleDataSetDb.DataSet.CommandText := 'SELECT * FROM USUARIOS';
  SimpleDataSetDb.PacketRecords       := -1;
  SimpleDataSetDb.Active              := True;

  DataSourceDb.DataSet    := SimpleDataSetDb;
  GridUsuarios.DataSource := DataSourceDb;
end;
end.
