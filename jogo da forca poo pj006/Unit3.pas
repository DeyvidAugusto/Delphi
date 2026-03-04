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
   public
      constructor Create(APalavra: string; QtdJogadores : integer);
      property Display: string read FDisplay;
      property GameOver: Boolean read FGameOver;
      procedure Jogar(Letra: Char; NomeJogador: string);
      function GetEstatisticas: TStrings;
      function GetNomeVencedor: string;
      function GetLetrasUtilizadas: string;
      destructor Destroy; override;
      // procedure ProxJogador;
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
   // Jogadores.OwnsObjects := True;

   for I := 0 to QtdJogadores - 1 do
   begin
      NomeJogador := InputBox('Digite o nome do Jogador', 'Nome', '');
      Jogadores.AddObject(AnsiUpperCase(NomeJogador), TJogador.Create(NomeJogador));
   end;

   LetrasUtilizadas := TStringList.Create;
end;

procedure TJogoForca.Jogar(Letra: Char; NomeJogador: string);
var
   Encontrou: Boolean;
   I: Integer;
   Jogador: TJogador;
   Tmp: string;
begin
   Letra := UpCase(Letra);

   if LetrasUtilizadas.IndexOf(Letra) > 0 then
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

   I := Jogadores.IndexOf(AnsiUpperCase(NomeJogador));
   if I = -1 then
      raise Exception.Create(Format('Jogador "%s" não encontrado.', [NomeJogador]));
   Jogador := Jogadores.Objects[I] as TJogador;

   if Encontrou then
      Jogador.Acertou
   else
      Jogador.Errou;

   Tmp := '';
   for I := 1 to Length(Display) do
      if Display[i] in ['A'..'Z'] then
         Tmp := Tmp + Display[I];

   FGameOver := (Tmp = Palavra);
end;

function TJogoForca.GetEstatisticas: TStrings;
var
   I: Integer;
   Jogador: TJogador;
begin
   Result := TStringList.Create;

   for I := 0 to Jogadores.Count - 1 do
   begin
      Jogador := TJogador(Jogadores.Objects[I]);

      Result.Add(Format('» Jogador %s', [Jogador.Nome]));
      Result.Add(Format('  Quantidade de acertos: %d', [Jogador.QtdAcertos]));
      Result.Add(Format('  Quantidade de erros: %d', [Jogador.QtdErros]));
      Result.Add('');
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

{procedure TJogoForca.ProxJogador();
begin
   IndexJogador := (IndexJogador + 1) mod Jogadores.Count
end;} //ARRUMAR

destructor TJogoForca.Destroy;
begin
   Jogadores.Free;
   LetrasUtilizadas.Free;

   inherited Destroy;
end;

end.
