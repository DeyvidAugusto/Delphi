unit uCadastroForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, ExtCtrls, SqlExpr, uCadastroController, FireDAC.Comp.Client;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    LbCPF: TLabel;
    LbEndereco: TLabel;
    LbNascimento: TLabel;
    LbNome: TLabel;
    LbTelefone: TLabel;
    CbEstadoCivil: TComboBox;
    EdtEndereco: TEdit;
    EdtID: TEdit;
    EdtNome: TEdit;
    MEdtCPF: TMaskEdit;
    MEdtNascimento: TMaskEdit;
    MEdtTelefone: TMaskEdit;
    BntCancelar: TButton;
    BntIncluir: TButton;
    GroupBox1: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtIDKeyPress(Sender: TObject; var Key: Char);
    procedure BntIncluirClick(Sender: TObject);
    procedure BntCancelarClick(Sender: TObject);
  private
    FController: TCadastroController;
    FModoAlterar : Boolean;
    procedure HabilitarCampos(AHabilitar: Boolean);
    procedure ValidarID;
    procedure EditIDKeyPress(Sender: TObject; var Key: Char);
  public
    procedure Inicializar(AConn: TFDConnection);
        procedure InicializarAlterar(AConn: TFDConnection;
                                  AID: Integer;
                                  ANome, ACPF, ATelefone,
                                  ANascimento, AEstadoCivil,
                                  AEndereco: string);
  end;

var
  Form2: TForm2;

implementation
{$R *.dfm}

procedure TForm2.Inicializar(AConn: TFDConnection);
begin
  FController  := TCadastroController.Create(AConn);
  FModoAlterar := False;  // <-- adicione esta linha
  EdtID.Text   := IntToStr(FController.ProximoID);
  HabilitarCampos(False);
  Position := poScreenCenter;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  HabilitarCampos(False);
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TForm2.HabilitarCampos(AHabilitar: Boolean);
begin
  EdtNome.Enabled       := AHabilitar;
  EdtEndereco.Enabled   := AHabilitar;
  MEdtCPF.Enabled       := AHabilitar;
  MEdtNascimento.Enabled := AHabilitar;
  MEdtTelefone.Enabled  := AHabilitar;
  CbEstadoCivil.Enabled := AHabilitar;
  BntIncluir.Enabled    := AHabilitar;
end;

procedure TForm2.EditIDKeyPress(Sender: TObject; var Key: Char);
var
  Mensagem: string;
  ID: Integer;
begin
  if Key = #13 then  // Enter
  begin
    Key := #0;  // evita o beep

    if not TryStrToInt(EdtID.Text, ID) then
    begin
      ShowMessage('ID inválido. Digite apenas números.');
      EdtID.SetFocus;
      Exit;
    end;

    if FController.ValidarID(ID, Mensagem) then
    begin
      // Habilita as outras edits
      EdtNome.Enabled       := True;
      MEdtCPF.Enabled        := True;
      MEdtTelefone.Enabled   := True;
      MEdtNascimento.Enabled := True;
      CbEstadoCivil.Enabled := True;
      EdtEndereco.Enabled   := True;

      EdtNome.SetFocus;  // já move o cursor para o próximo campo
    end
    else
    begin
      ShowMessage(Mensagem);
      EdtID.SetFocus;
    end;
  end;
end;

procedure TForm2.ValidarID;
var
  ID  : Integer;
  Msg : string;
begin
  try
    ID := StrToInt(EdtID.Text);
    if FController.ValidarID(ID, Msg) then
    begin
      EdtID.Enabled := False;
      HabilitarCampos(True);
    end
    else
      ShowMessage(Msg);
  except
    on E: Exception do
      ShowMessage('ID inválido: ' + E.Message);
  end;
end;

procedure TForm2.EdtIDKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    ValidarID;
end;

procedure TForm2.BntIncluirClick(Sender: TObject);
begin
  try
    if FModoAlterar then
    begin
      FController.Alterar(
        StrToInt(EdtID.Text),
        EdtNome.Text,
        MEdtCPF.Text,
        MEdtTelefone.Text,
        MEdtNascimento.Text,
        CbEstadoCivil.Text,
        EdtEndereco.Text
      );
      ShowMessage('Usuário alterado com sucesso!');
    end
    else
    begin
      FController.Salvar(
        StrToInt(EdtID.Text),
        EdtNome.Text,
        MEdtCPF.Text,
        MEdtTelefone.Text,
        MEdtNascimento.Text,
        CbEstadoCivil.Text,
        EdtEndereco.Text
      );
      ShowMessage('Cadastro realizado com sucesso!');
    end;
    ModalResult := mrOk;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar: ' + E.Message);
  end;
end;

procedure TForm2.InicializarAlterar(AConn: TFDConnection;
                                     AID: Integer;
                                     ANome, ACPF, ATelefone,
                                     ANascimento, AEstadoCivil,
                                     AEndereco: string);
begin
  FController  := TCadastroController.Create(AConn);
  FModoAlterar := True;

  // Preenche os campos
  EdtID.Text          := IntToStr(AID);
  EdtNome.Text        := ANome;
  MEdtCPF.Text        := ACPF;
  MEdtTelefone.Text   := ATelefone;
  MEdtNascimento.Text := ANascimento;
  CbEstadoCivil.Text  := AEstadoCivil;
  EdtEndereco.Text    := AEndereco;

  // ID não pode ser alterado
  EdtID.Enabled := False;

  // Habilita todos os campos
  HabilitarCampos(True);

  // Muda o caption do botão e do form
  BntIncluir.Caption := 'Alterar';
  Caption            := 'Alterar Usuário';

  Position := poScreenCenter;
end;

procedure TForm2.BntCancelarClick(Sender: TObject);
begin
  Close;
end;

end.
