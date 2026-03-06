unit Unit2;

interface

type
   TJogador = class
   private
      const
         QTD_TENTATIVAS = 6;
      var
         FNome: string;
         FQtdAcertos: Integer;
         FQtdErros: Integer;
   public
      constructor Create(ANome: string);
      procedure Acertou;
      procedure Errou;
      function Venceu: Boolean;
      property Nome: string read FNome;
      property QtdAcertos: Integer read FQtdAcertos;
      property QtdErros: Integer read FQtdErros;
   end;

implementation

constructor TJogador.Create(ANome: string);
begin
   FNome := ANome;
   FQtdAcertos := 0;
   FQtdErros := 0;
end;

procedure TJogador.Acertou;
begin
   Inc(FQtdAcertos);
end;

procedure TJogador.Errou;
begin
   Inc(FQtdErros);
end;

function TJogador.Venceu: Boolean;
begin
   Result := (FQtdAcertos = QTD_TENTATIVAS);
end;

end.
