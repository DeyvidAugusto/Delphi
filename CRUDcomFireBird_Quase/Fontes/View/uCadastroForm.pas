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
    procedure MEdtNascimentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MEdtNascimentoExit(Sender: TObject);
    procedure TeclaEnter(Sender: TObject; var Key: Char);
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

function DiasNoMes(Data: TDateTime): Integer;
const
  DiasMes: array[1..12] of Integer = (31,28,31,30,31,30,31,31,30,31,30,31);
var
  Ano, Mes: Word;
begin
  DecodeDate(Data, Ano, Mes, Result);
  if Mes = 2 then
  begin
    if (Ano mod 4 = 0) and ((Ano mod 100 <> 0) or (Ano mod 400 = 0)) then
      Result := 29
    else
      Result := 28;
  end
  else
    Result := DiasMes[Mes];
end;

function DataNascimentoToString(Data: string): string;
var
  DataObj: TDateTime;
begin
  Result := '';
  if Trim(Data) <> '' then
  begin
    DataObj := StrToDate(Data);
    Result := FormatDateTime('yyyy-mm-dd', DataObj);
  end;
end;


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

  EdtID.Enabled := False;   { ID confirmado � trava }

  if FModoAlterar then
  begin
    HabilitarCampos(True);  { campos edit�veis }
    EdtNome.SetFocus;
  end
  else
  begin
    HabilitarCampos(False); { campos s� leitura no modo deletar }
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
    { Modos Alterar/Deletar: busca o usu�rio pelo ID }
    CarregarCamposPorID(ID);
  end
  else
  begin
    { Modo Incluir: verifica se o ID est� dispon�vel }
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

   if Sender is TEdit then
      Texto := TEdit(Sender).Text
   else if Sender is TMaskEdit then
      Texto := TMaskEdit(Sender).Text
   else if Sender is TComboBox then
      Texto := TComboBox(Sender).Text
   else
      Exit;

   Texto := StringReplace(Texto, '.', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, '-', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, '/', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, '_', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, '(', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, ')', '', [rfReplaceAll, rfIgnoreCase]);
   Texto := StringReplace(Texto, ' ', '', [rfReplaceAll, rfIgnoreCase]);

   if Trim(Texto) = '' then
   begin
      ShowMessage('Valor Invalido!');
      if Sender is TEdit then
         TEdit(Sender).SetFocus
      else if Sender is TMaskEdit then
         TMaskEdit(Sender).SetFocus;
   end;
end;


procedure TForm2.BntIncluirClick(Sender: TObject);
var
  ID: Integer;
  DataNascimento, EstadoCivil: string;
begin
  if executando then Exit;
  executando := True;

  try
    if not TryStrToInt(EdtID.Text, ID) then
    begin
      ShowMessage('ID inv'+#225+'lido!');
      EdtID.SetFocus;
      executando := False;
      Exit;
    end;

    if (FModoAlterar or not FModoDeletar) and (Trim(EdtNome.Text) = '') then
    begin
      ShowMessage('Nome '+#233+' obrigat'+#243+'rio!');
      EdtNome.SetFocus;
      executando := False;
      Exit;
    end;

    if FModoDeletar then
    begin
      if MessageDlg('Confirma a exclus'+#227+'o do usu'+#225+'rio "' + EdtNome.Text +
        '" (ID ' + EdtID.Text + ')?' + #13#10 + 'Esta a'+#231+#227+'o n'+#227+'o pode ser desfeita.',
        mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        FController.Deletar(ID);
        ShowMessage('Usu'+#225+'rio deletado com sucesso!');
        Close;
      end;
    end
    else
    begin
      EstadoCivil    := Copy(CbEstadoCivil.Text, 1, 2);
      DataNascimento := DataNascimentoToString(MEdtNascimento.Text);

      if FModoAlterar then
      begin
        FController.Alterar(
          ID,
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
        FController.Salvar(
          ID,
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

procedure TForm2.MEdtNascimentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  DataAtual: TDateTime;
  Ano, Mes, Dia: Word;
  PrimeiroDia, UltimoDia: TDateTime;
begin
  if not MEdtNascimento.Enabled then
    Exit;

  DataAtual := Date;
  DecodeDate(DataAtual, Ano, Mes, Dia);

  PrimeiroDia := EncodeDate(Ano, Mes, 1);
  UltimoDia  := EncodeDate(Ano, Mes, DiasNoMes(DataAtual));

  case Key of
    VK_F2: MEdtNascimento.Text := FormatDateTime('dd/mm/yyyy', PrimeiroDia);
    VK_F3: MEdtNascimento.Text := FormatDateTime('dd/mm/yyyy', DataAtual);
    VK_F4: MEdtNascimento.Text := FormatDateTime('dd/mm/yyyy', UltimoDia);
  end;
end;

procedure TForm2.MEdtNascimentoExit(Sender: TObject);
var
  DataObj: TDateTime;
begin
  if ActiveControl = BntCancelar then
    Exit;

  if Trim(MEdtNascimento.Text) = '  /  /    ' then
    Exit;

  try
    DataObj := StrToDate(MEdtNascimento.Text);

    if DataObj > Date then
    begin
      ShowMessage('Data de nascimento n'+#227+'o pode ser futura!');
      MEdtNascimento.SetFocus;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Data inv'+#225+'lida!');
      MEdtNascimento.SetFocus;
    end;
  end;
end;

procedure TForm2.TeclaEnter(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(ActiveControl as TWinControl, True, True);
  end;
end;

end.
