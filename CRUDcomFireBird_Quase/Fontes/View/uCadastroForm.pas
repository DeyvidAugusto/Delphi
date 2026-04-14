unit uCadastroForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, ExtCtrls, SqlExpr, uCadastroController;

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
    procedure BntIncluirClick(Sender: TObject);
    procedure BntCancelarClick(Sender: TObject);
    procedure EditIDKeyPress(Sender: TObject; var Key: Char);
    procedure EdtOnExit(Sender: TObject);
    procedure ResetarCampos;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    executando: boolean;
    FModoAlterar: Boolean;
    FModoDeletar: Boolean;
    FController: TCadastroController;
    procedure HabilitarCampos(AHabilitar: Boolean);
    procedure CarregarCamposPorID(AID: Integer);
  public
    procedure Inicializar(AConn: TSQLConnection);
    procedure AbrirModoDeletar(AID: Integer = 0);
    procedure AbrirModoAlterar(AID: Integer = 0);
  end;

var
  Form2: TForm2;

implementation
{$R *.dfm}


procedure TForm2.Inicializar(AConn: TSQLConnection);
begin
  FController   := TCadastroController.Create(AConn);
  FModoAlterar  := False;
  FModoDeletar  := False;
  HabilitarCampos(False);
  Position      := poScreenCenter;
  CbEstadoCivil.ItemIndex := 0;
  EdtID.Text    := IntToStr(FController.ProximoID);
end;

procedure TForm2.AbrirModoAlterar(AID: Integer);
begin
  FModoAlterar := True;
  FModoDeletar := False;

  BntIncluir.Caption    := 'Alterar';
  BntIncluir.Font.Color := clWindowText;
  BntIncluir.Font.Style := [];

  EdtID.Enabled := True;
  EdtID.Clear;
  HabilitarCampos(False);
  EdtID.SetFocus;

  if AID > 0 then
  begin
    EdtID.Text := IntToStr(AID);
    CarregarCamposPorID(AID);
  end;
end;

procedure TForm2.AbrirModoDeletar(AID: Integer);
begin
  FModoDeletar := True;
  FModoAlterar := False;

  BntIncluir.Caption    := 'Deletar';
  BntIncluir.Font.Color := clRed;
  BntIncluir.Font.Style := [fsBold];

  EdtID.Enabled := True;
  EdtID.Clear;
  HabilitarCampos(False);
  EdtID.SetFocus;

  if AID > 0 then
  begin
    EdtID.Text := IntToStr(AID);
    CarregarCamposPorID(AID);
  end;
end;

procedure TForm2.CarregarCamposPorID(AID: Integer);
var
  Nome, CPF, Telefone, Nascimento, EstadoCivil, Endereco: string;
  Idx: Integer;
begin
  if not FController.BuscarPorID(AID, Nome, CPF, Telefone,
                                  Nascimento, EstadoCivil, Endereco) then
  begin
    ShowMessage('Usu'+#225+'rio com ID ' + IntToStr(AID) + ' n'+#227+'o encontrado.');
    EdtID.Clear;
    EdtID.SetFocus;
    Exit;
  end;

  EdtNome.Text        := Nome;
  MEdtCPF.Text        := CPF;
  MEdtTelefone.Text   := Telefone;
  MEdtNascimento.Text := Nascimento;
  EdtEndereco.Text    := Endereco;

  for Idx := 0 to CbEstadoCivil.Items.Count - 1 do
    if Copy(CbEstadoCivil.Items[Idx], 1, 2) = Copy(EstadoCivil, 1, 2) then
    begin
      CbEstadoCivil.ItemIndex := Idx;
      Break;
    end;

  EdtID.Enabled := False;   { ID confirmado — trava }

  if FModoAlterar then
  begin
    HabilitarCampos(True);  { campos editáveis }
    EdtNome.SetFocus;
  end
  else
  begin
    HabilitarCampos(False); { campos só leitura no modo deletar }
    BntIncluir.Enabled := True;
  end;
end;

procedure TForm2.ResetarCampos;
var
  i: Integer;
begin
  for i := 0 to GroupBox1.ControlCount - 1 do
  begin
    if (GroupBox1.Controls[i] is TEdit) then
      (GroupBox1.Controls[i] as TEdit).Clear;
    if (GroupBox1.Controls[i] is TMaskEdit) then
      (GroupBox1.Controls[i] as TMaskEdit).Clear;
  end;
  HabilitarCampos(False);
  CbEstadoCivil.ItemIndex := 0;
  EdtID.Text   := IntToStr(FController.ProximoID);
  EdtID.SetFocus;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ModalResult := mrOk;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  HabilitarCampos(False);
  executando := false;
  FModoAlterar  := False;
  FModoDeletar  := False;
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
  ID: Integer;
  Mensagem: string;
begin
  if Key <> #13 then Exit;
  Key := #0;

  if not TryStrToInt(EdtID.Text, ID) then
  begin
    ShowMessage('ID inv'+#225+'lido. Digite apenas n'+#250+'meros.');
    EdtID.SetFocus;
    Exit;
  end;

  if ID <= 0 then
  begin
    ShowMessage('ID deve ser maior que zero.');
    EdtID.SetFocus;
    Exit;
  end;

  if FModoAlterar or FModoDeletar then
  begin
    { Modos Alterar/Deletar: busca o usuário pelo ID }
    CarregarCamposPorID(ID);
  end
  else
  begin
    { Modo Incluir: verifica se o ID está disponível }
    if FController.ValidarID(ID, Mensagem) then
    begin
      HabilitarCampos(True);
      EdtNome.SetFocus;
    end
    else
    begin
      ShowMessage(Mensagem);
      EdtID.SetFocus;
    end;
  end;
end;

procedure TForm2.EdtOnExit(Sender: TObject);
var
   Texto: string;
begin
   if ActiveControl = BntCancelar then
      exit;

   Texto := StringReplace(TEdit(Sender).Text, '.', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, '-', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, '/', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, '_', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, '(', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, ')', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, ' ', '', [rfReplaceAll, rfIgnoreCase]);

   if Trim(Texto) = '' then
   begin
      ShowMessage('Valor Invalido!');
      TEdit(Sender).SetFocus;
   end;
end;


procedure TForm2.BntIncluirClick(Sender: TObject);
var
  DataNascimento, EstadoCivil: string;
  DataObj: TDateTime;
begin
  if executando then Exit;
  executando := True;

  try
    if FModoDeletar then
    begin
      { ===== MODO DELETAR ===== }
      if MessageDlg('Confirma a exclus'+#227+'o do usu'+#225+'rio "' + EdtNome.Text +
        '" (ID ' + EdtID.Text + ')?' + #13#10 + 'Esta a'+#231+#227+'o n'+#227+'o pode ser desfeita.',
        mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        FController.Deletar(StrToInt(EdtID.Text));
        ShowMessage('Usu'+#225+'rio deletado com sucesso!');
        Close;
      end;
    end
    else if FModoAlterar then
    begin
      { ===== MODO ALTERAR ===== }
      EstadoCivil    := Copy(CbEstadoCivil.Text, 1, 2);
      DataNascimento := MEdtNascimento.Text;
      DataObj        := StrToDate(DataNascimento);
      DataNascimento := FormatDateTime('yyyy-mm-dd', DataObj);

      FController.Alterar(
        StrToInt(EdtID.Text),
        EdtNome.Text,
        MEdtCPF.Text,
        MEdtTelefone.Text,
        DataNascimento,
        EstadoCivil,
        EdtEndereco.Text
      );
      ShowMessage('Dados alterados com sucesso!');
      Close;
    end
    else
    begin
      { ===== MODO INCLUIR ===== }
      EstadoCivil    := Copy(CbEstadoCivil.Text, 1, 2);
      DataNascimento := MEdtNascimento.Text;
      DataObj        := StrToDate(DataNascimento);
      DataNascimento := FormatDateTime('yyyy-mm-dd', DataObj);

      FController.Salvar(
        StrToInt(EdtID.Text),
        EdtNome.Text,
        MEdtCPF.Text,
        MEdtTelefone.Text,
        DataNascimento,
        EstadoCivil,
        EdtEndereco.Text
      );
      ShowMessage('Cadastro realizado com sucesso!');
      ResetarCampos;
    end;
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;

  executando := False;
end;

procedure TForm2.BntCancelarClick(Sender: TObject);
begin
  Close;

end;

end.
