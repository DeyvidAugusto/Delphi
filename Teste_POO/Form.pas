unit Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Carro, Aviao, Barco;

type
  TForm1 = class(TForm)
    CarroCheckBox: TRadioButton;
    AviaoCheckBox: TRadioButton;
    BarcoCheckBox: TRadioButton;
    Mover: TButton;
    Parar: TButton;
    Info: TButton;
    procedure MoverClick(Sender: TObject);
    procedure PararClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure InfoClick(Sender: TObject);
  private
    Panameira: TCarro;
    Boing: TAviao;
    Navio: TBarco;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Panameira.Free;
  Boing.Free;
  Navio.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Panameira := TCarro.Create;
  Boing := TAviao.Create;
  Navio := TBarco.Create;

  Panameira.Nome := 'Panameira';
  Panameira.tipo := 'Carro';
  Panameira.marca := 'Porche';

  Boing.Nome := 'Boing 737';
  Boing.tipo := 'Avião';
  Boing.Marca := 'Boing';

  Navio.Nome := 'Navio';
  Navio.tipo := 'Barco';
  Navio.Marca := 'Ferrari'
end;

procedure TForm1.InfoClick(Sender: TObject);
begin
  if CarroCheckBox.Checked then
    Panameira.info();
  if AviaoCheckBox.Checked then
    Boing.info();
  if BarcoCheckBox.Checked then
    Navio.info();

end;

procedure TForm1.MoverClick(Sender: TObject);
begin
  if CarroCheckBox.Checked then
    Panameira.Mover();
  if AviaoCheckBox.Checked then
    Boing.Mover();
  if BarcoCheckBox.Checked then
    Navio.Mover();
end;

procedure TForm1.PararClick(Sender: TObject);
begin
  if CarroCheckBox.Checked then
    Panameira.Parar();
  if AviaoCheckBox.Checked then
    Boing.Parar();
  if BarcoCheckBox.Checked then
    Navio.Parar();

end;

end.
