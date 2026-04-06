unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    CheckBox5: TCheckBox;
    Image5: TImage;
    Label1: TLabel;
    BtnResultado: TButton;
    procedure BtnResultadoClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnResultadoClick(Sender: TObject);
var
  Resultado: integer;
begin
  Resultado := 0;

  if CheckBox1.Checked then
    Resultado := 1;
  if CheckBox2.Checked then
    Resultado := Resultado + 2;
  if CheckBox3.Checked then
    Resultado := Resultado + 4;
  if CheckBox4.Checked then
    Resultado := Resultado + 8;
  if CheckBox5.Checked then
    Resultado := Resultado + 16;

  ShowMessage(inttostr(Resultado));
end;

end.
