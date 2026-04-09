program ProjectCRUDcomFireBird;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {Form1},
  uCadastroForm in 'uCadastroForm.pas',
  uCadastroController in 'uCadastroController.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
