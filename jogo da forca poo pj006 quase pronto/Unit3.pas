unit Unit3;

interface

uses
   SysUtils, Dialogs,
   Classes;

type
   TJogoForca = class
   private
      FDisplay: string;
      FGameOver: Boolean;
      Palavra: string;
      Jogadores: TStringList;
      LetrasUtilizadas: TStringList;
      IndexJogador: integer;
      VezDoJogador: integer;

   public
      constructor Create(APalavra: string; QtdJogadores : integer);
      property Display: string read FDisplay;
      property GameOver: Boolean read FGameOver;
      procedure Jogar(Letra: Char);
      function VezJogador(Print: string) : integer;
      function JogadorAtual: string;
      procedure GetEstatisticas(out Lista: TStringList);
      function GetNomeVencedor: string;
      function GetLetrasUtilizadas: string;
      function GerarPalavra: string;
      destructor Destroy; override;
      property LJogadores : TStringList read Jogadores;
   end;

implementation

uses
   Unit2;

constructor TJogoForca.Create(APalavra: string; QtdJogadores : integer);
var
   I: Integer;
   NomeJogador: string;
begin
   IndexJogador := 0;
   FGameOver := False;

   Palavra := AnsiUpperCase(APalavra);

   FDisplay := '_';
   for I := 2 to Length(Palavra) do
      FDisplay := FDisplay + ' _';

   Jogadores := TStringList.Create;

   for I := 0 to QtdJogadores - 1 do
   begin
      NomeJogador := InputBox('Digite o nome do Jogador', 'Nome', '');
      Jogadores.AddObject(AnsiUpperCase(NomeJogador), TJogador.Create(NomeJogador));
   end;

   LetrasUtilizadas := TStringList.Create;
   VezDoJogador := Random(Jogadores.Count);
end;

procedure TJogoForca.Jogar(Letra: Char);
var
   Encontrou: Boolean;
   I: Integer;
   Jogador: TJogador;
   Tmp: string;
begin
   Letra := UpCase(Letra);

   if LetrasUtilizadas.IndexOf(Letra) >= 0 then
      raise Exception.Create('Letra já utilizada.');

   LetrasUtilizadas.Add(Letra);

   Encontrou := False;

   for I := 1 to Length(Palavra) do
   begin
      if Palavra[I] = Letra then
      begin
         FDisplay[(I * 2) - 1] := Letra;
         Encontrou := True;
      end;
   end;

   Jogador := Jogadores.Objects[VezJogador('')] as TJogador;


   if Encontrou then
      Jogador.Acertou
   else
      Jogador.Errou;

   Tmp := '';
   for I := 1 to Length(Display) do
      if Display[I] in ['A'..'Z'] then
         Tmp := Tmp + Display[I];

   FGameOver := (Tmp = Palavra);
end;

function TJogoForca.VezJogador(Print:string) : integer;
begin
   if Print = 'exibir' then
   begin
      if (VezDoJogador + 1) >= Jogadores.Count then
          VezDoJogador := 0
      else
          Inc(VezDoJogador);
      Result := VezDoJogador
   end
   else
      Result := VezDoJogador;

end;

function TJogoForca.JogadorAtual: string;
begin
  Result := Jogadores[VezJogador('exibir')]
end;

procedure TJogoForca.GetEstatisticas(out Lista: TStringList);
var
   I: Integer;
   Jogador: TJogador;
begin
   for I := 0 to Jogadores.Count - 1 do
   begin
      Jogador := TJogador(Jogadores.Objects[I]);

      Lista.Add(Format('» Jogador %s', [Jogador.Nome]));
      Lista.Add(Format('  Quantidade de acertos: %d', [Jogador.QtdAcertos]));
      Lista.Add(Format('  Quantidade de erros: %d', [Jogador.QtdErros]));
      Lista.Add('');
   end;
end;

function TJogoForca.GetNomeVencedor: string;
var
   I, Maior: Integer;
   Jogador: TJogador;
begin
   Maior := 0;
   Result := '';
   for I := 0 to Jogadores.Count - 1 do
   begin
      Jogador := TJogador(Jogadores.Objects[I]);
      if Jogador.QtdAcertos > Maior then
      begin
         Maior := Jogador.QtdAcertos;
         Result := Jogador.Nome;
      end;
   end;
end;

function TJogoForca.GetLetrasUtilizadas: string;
begin
   Result := LetrasUtilizadas.Text;
end;
function TJogoForca.GerarPalavra: string;
var
   ListaPalavras: TStringList;
begin
   Result := '';
   ListaPalavras := TStringList.Create;
   try
     if FileExists('C:\Users\pjr006\OneDrive\Desktop (ATENÇÃO !!! Amanhã esta pasta será deletada, não sincronizar pastas do Usuário)\jogo da forca poo\jogo da forca poo pj006\Palavras_Aleatorias.txt') then
     begin
       ListaPalavras.LoadFromFile('C:\Users\pjr006\OneDrive\Desktop (ATENÇÃO !!! Amanhã esta pasta será deletada, não sincronizar pastas do Usuário)\jogo da forca poo\jogo da forca poo pj006\Palavras_Aleatorias.txt');
       if ListaPalavras.Count > 0 then
       begin
         Randomize;
         Result := ListaPalavras[Random(ListaPalavras.Count)];
       end
       else
         ShowMessage('Nenhuma palavra encontrada para iniciar o jogo');
     end;
   finally
     ListaPalavras.free;

   end;
end;

destructor TJogoForca.Destroy;
var
  I: Integer;
begin
   LetrasUtilizadas.Free;
   try
      for I := 0 to Jogadores.Count - 1 do
      begin
        TJogador(Jogadores.Objects[I]).Free
      end;
   finally
      Jogadores.Free;
   end;

   inherited Destroy;
end;

end.
