unit exercicio5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Valor : integer;
begin
  Valor := strtoint(Edit1.Text);
  showMessage(
  inttostr(Valor)+ ' x 1 = ' + inttostr(Valor*1) +#13+
  inttostr(Valor)+ ' x 2 = ' + inttostr(Valor*2) +#13+
  inttostr(Valor)+ ' x 3 = ' + inttostr(Valor*3) +#13+
  inttostr(Valor)+ ' x 4 = ' + inttostr(Valor*4) +#13+
  inttostr(Valor)+ ' x 5 = ' + inttostr(Valor*5) +#13+
  inttostr(Valor)+ ' x 6 = ' + inttostr(Valor*6) +#13+
  inttostr(Valor)+ ' x 7 = ' + inttostr(Valor*7) +#13+
  inttostr(Valor)+ ' x 8 = ' + inttostr(Valor*8) +#13+
  inttostr(Valor)+ ' x 9 = ' + inttostr(Valor*9) +#13+
  inttostr(Valor)+ ' x 10 = ' + inttostr(Valor*10)
  );
end;

end.
