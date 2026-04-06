program ProjectTeste_POO;

uses
  Forms,
  Form in 'Form.pas' {Form1},
  Veiculo in 'Veiculo.pas',
  Carro in 'Carro.pas',
  Aviao in 'Aviao.pas',
  Barco in 'Barco.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
