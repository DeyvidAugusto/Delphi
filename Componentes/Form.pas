unit Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, CustomMaskEditCPFeCNPJ;

type
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    CustomMaskEditCPFeCNPJ1: TCustomMaskEditCPFeCNPJ;
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
   if CheckBox1.Checked then
   begin
      CustomMaskEditCPFeCNPJ1.IsCNPJ := True;
      CustomMaskEditCPFeCNPJ1.Clear
   end
   else
   begin
      CustomMaskEditCPFeCNPJ1.IsCPF := True;
      CustomMaskEditCPFeCNPJ1.Clear
   end;
end;

end.
