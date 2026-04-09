program ProjectCRUDcomBancoDeDados;

uses
  Forms,
  uMainForm in 'Fontes\View\uMainForm.pas' {Form1},
  uConexao in 'Fontes\Infra\uConexao.pas',
  uMainFormController in 'Fontes\Controller\uMainFormController.pas',
  uUsuarioDAO in 'Fontes\DAO\uUsuarioDAO.pas',
  uCadastroForm in 'Fontes\View\uCadastroForm.pas' {Form2},
  uCadastroController in 'Fontes\Controller\uCadastroController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
