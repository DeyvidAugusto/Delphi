unit uCadastroForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, ExtCtrls, SqlExpr, uCadastroController;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    LbCPF: TLabel;
    LbEndereco: TLabel;
    LbNascimento: TLabel;
    LbNome: TLabel;
    LbTelefone: TLabel;
    CbEstadoCivil: TComboBox;
    EdtEndereco: TEdit;
    EdtID: TEdit;
    EdtNome: TEdit;
    MEdtCPF: TMaskEdit;
    MEdtNascimento: TMaskEdit;
    MEdtTelefone: TMaskEdit;
    BntCancelar: TButton;
    BntIncluir: TButton;
    GroupBox1: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtIDKeyPress(Sender: TObject; var Key: Char);
    procedure BntIncluirClick(Sender: TObject);
    procedure BntCancelarClick(Sender: TObject);
  private
    FController: TCadastroController;
    procedure HabilitarCampos(AHabilitar: Boolean);
    procedure ValidarID;
  public
    procedure Inicializar(AConn: TSQLConnection);
  end;

var
  Form2: TForm2;

implementation
{$R *.dfm}


end.
