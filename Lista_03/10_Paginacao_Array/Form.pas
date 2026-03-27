unit Form;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Paginador, GeradorLista, Ordenador, Cronometro, ArrayHelper;

type
  TintArray = TMyIntArray;
  TForm1 = class(TForm)
    Label1: TLabel;
    EdtTamanhoArray: TEdit;
    Label2: TLabel;
    EdtQtdItens: TEdit;
    MemoNumeros: TMemo;
    BtnAnterior: TButton;
    BtnProximo: TButton;
    QtdPag: TLabel;
    BtnSair: TButton;
    BtnGerarLista: TButton;
    BtnCrescente: TButton;
    BtnDecrescente: TButton;
    Label3: TLabel;
    LblTempo: TLabel;
    procedure BtnGerarListaClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnOrdenarClick(Sender: TObject);
    procedure Sair(Sender: TObject);
    destructor FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FLista: TintArray;
    FPaginador: TPaginador;
    procedure ExibirPagina(Pagina: TintArray);
    procedure AtualizarLabel;
  end;

var
  Form1: TForm1;

implementation
{$R *.dfm}

destructor TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FPaginador);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FPaginador);
end;

procedure TForm1.Sair(Sender: TObject);
begin
  if MessageDlg('Deseja sair?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;


procedure TForm1.BtnGerarListaClick(Sender: TObject);
var
  TamanhoArray, QtdItens: integer;
  PaginaInicial: TintArray;
  Crono : TCronometro;
begin
  TamanhoArray := 0;
  QtdItens := 0;

  try
    TamanhoArray := StrToInt(EdtTamanhoArray.Text);
    QtdItens := StrToInt(EdtQtdItens.Text);
    ShowMessage('Gerando Lista, Aguarde...');
  except
    ShowMessage('Preencha o tamanho e a quantidade por pagina');
  end;
  Crono := TCronometro.Create;
  Crono.Iniciar;

  FreeAndNil(FPaginador);

  FLista := copy(TGeradorLista.GerarAleatorio(TamanhoArray));

  FPaginador := TPaginador.Create(QtdItens);
  FPaginador.CarregarLista(FLista);

  PaginaInicial := copy(FPaginador.ObterPaginaAtual);
  try
    ExibirPagina(PaginaInicial);
    AtualizarLabel;
    LblTempo.Caption := Crono.TempoDecorrido;
    ShowMessage('Lista Gerada!');
  finally
    Crono.Free;
  end;
end;

procedure TForm1.BtnProximoClick(Sender: TObject);
var
  Pagina: TintArray;
begin
  if FPaginador = nil then Exit;
  try
    Pagina := FPaginador.ProximaPagina;
    try
      ExibirPagina(Pagina);
      AtualizarLabel;
      ShowMessage('Proxima Pagina');
    finally
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TForm1.BtnAnteriorClick(Sender: TObject);
var
  Pagina: TintArray;
begin
  if FPaginador = nil then Exit;
  try
    Pagina := FPaginador.PaginaAnterior;
    try
      ExibirPagina(Pagina);
      AtualizarLabel;
      ShowMessage('Pagina Anterior');
    finally
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TForm1.ExibirPagina(Pagina: TintArray);
var
  I: integer;
begin
  // MemoNumeros.Lines.BeginUpdate;
  MemoNumeros.Lines.Clear;
  for I := 0 to Length(Pagina) - 1 do
    MemoNumeros.Lines.Add(IntToStr(Pagina[I]));
  // MemoNumeros.Lines.EndUpdate;
end;

procedure TForm1.AtualizarLabel;
begin
  QtdPag.Caption := 'Página ' + IntToStr(FPaginador.PaginaCorrente) + ' de ' + IntToStr(FPaginador.TotalPaginas);
end;

procedure TForm1.BtnOrdenarClick(Sender: TObject);
var
  ListaOrdenada: TintArray;
  PrimeiraPagina: TintArray;
  Crescente: boolean;
  Crono: TCronometro;
begin
  if FLista = nil then Exit;

  Crescente := (Sender = BtnCrescente); // true para crescente, false para decrescente
  if Crescente = True then
    ShowMessage('Ordenando Crescentemente')
  else
  if Crescente = False then
    ShowMessage('Ordenando Descrescentemente');

  Crono := TCronometro.Create;
  Crono.Iniciar;

  ListaOrdenada := copy(TOrdenador.OrdenarArray(FLista, Crescente));

  FLista := copy(ListaOrdenada);
  FPaginador.CarregarLista(FLista);

  PrimeiraPagina := FPaginador.ObterPaginaAtual;
  try
    ExibirPagina(PrimeiraPagina);
    AtualizarLabel;
    LblTempo.Caption := Crono.TempoDecorrido;
  finally
    Crono.Free;
  end;
end;

end.
