program ProjectEmailObserver;

uses
  Forms,
  Form in 'Form.pas' {Form1},
  Observers in 'Observers.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
