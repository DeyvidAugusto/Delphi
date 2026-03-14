program ProjectPaginacao;

uses
  Forms,
  Form in 'Form.pas' {Form1},
  GeradorLista in 'GeradorLista.pas',
  Paginador in 'Paginador.pas',
  Ordenador in 'Ordenador.pas',
  Cronometro in 'Cronometro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
