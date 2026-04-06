program ProjectRegistro;

uses
  Forms,
  Form in 'Form.pas' {Form1},
  Pessoa in 'Pessoa.pas',
  MemoController in 'MemoController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
