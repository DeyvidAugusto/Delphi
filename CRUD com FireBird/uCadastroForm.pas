unit uCadastroForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls;

type
  TForm2 = class(TForm)
    EdtID: TEdit;
    Label1: TLabel;
    LbNome: TLabel;
    EdtNome: TEdit;
    LbCPF: TLabel;
    LbTelefone: TLabel;
    LbNascimento: TLabel;
    Label2: TLabel;
    CbEstadoCivil: TComboBox;
    EdtEndereco: TEdit;
    LbEndereco: TLabel;
    BntIncluir: TButton;
    BntCancelar: TButton;
    MEdtCPF: TMaskEdit;
    MEdtTelefone: TMaskEdit;
    MEdtNascimento: TMaskEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
