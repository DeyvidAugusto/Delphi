unit Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Observers;

type
  TForm1 = class(TForm)
    EdtEmail: TEdit;
    EdtMessage: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BtnSendMsg: TButton;
    BtnLog: TButton;
    MemoLog: TMemo;
    procedure BtnSendMsgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnLogClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    LogObs: TLogObserver;
    SistemaEmail : TSystemEmail;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnLogClick(Sender: TObject);
var
   FilePath: string;
begin
   MemoLog.Visible := True;
   FilePath := ExtractFilePath(Application.ExeName);
   MemoLog.Lines.LoadFromFile(FilePath + 'Log.txt');
end;

procedure TForm1.BtnSendMsgClick(Sender: TObject);
var
   EmailEdt : string;
   MsgEdt : string;
begin
   EmailEdt := EdtEmail.Text;
   MsgEdt := EdtMessage.Text;

   LogObs := TLogObserver.Create;

   SistemaEmail.Adicionar(LogObs);

   SistemaEmail.Status := (' Enviada para: ' + EmailEdt + ' | Mensagem: ' + MsgEdt);
   ShowMessage('Email Enviado');

   SistemaEmail.Remover(LogObs);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   SistemaEmail.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   inherited;
   SistemaEmail := TSystemEmail.Create;
end;

end.
