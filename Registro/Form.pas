unit Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Pessoa;

type
  TForm1 = class(TForm)
    CampoNome: TEdit;
    BtnEnviar: TButton;
    CampoEmail: TEdit;
    Nome: TLabel;
    Email: TLabel;
    MemoRegistro: TMemo;
    BtnApagarRegistro: TButton;
    BtnAtualizarRegistro: TButton;
    SalvarRegistros: TButton;
    procedure BtnEnviarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PegarId(Sender: TObject);
    procedure CampoVerificarNumero(Sender: TObject; var Key: Char);
    procedure SalvarRegistrosClick(Sender: TObject);
  private
    var
      LastID : integer;
  public
  end;

var
  Form1: TForm1;

implementation

uses
  MemoController;


{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  LastID := 0;
end;

procedure TForm1.CampoVerificarNumero(Sender: TObject; var Key: Char);
begin
  if Key in ['0'..'9'] then
  begin
    Key := #0;
  end;
end;

procedure TForm1.PegarId(Sender: TObject);
var
  IdEscolhido : string;
begin
  IdEscolhido := InputBox('Digite o ID do Registro', 'ID', '');

  if Sender = BtnApagarRegistro then
    MemoCtrl.MemoApagar(IdEscolhido);

  if Sender = BtnAtualizarRegistro then
    MemoCtrl.MemoUpdate(IdEscolhido);
end;

procedure TForm1.BtnEnviarClick(Sender: TObject);
var
  FNome : string;
  FEmail : string;
  FPessoa : TPessoa;
begin
  FPessoa := TPessoa.Create;
  try
    FNome := CampoNome.Text;
    FEmail := CampoEmail.Text;

    LastID := LastID + 1;

    FPessoa.Insert(LastID, FNome, FEmail);

    MemoCtrl.MemoRegistrar(FPessoa);
  finally
    FPessoa.Free;
  end;
end;

procedure TForm1.SalvarRegistrosClick(Sender: TObject);
begin
  MemoCtrl.SalvarMemoToLista();
end;



end.
