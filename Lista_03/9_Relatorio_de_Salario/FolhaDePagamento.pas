unit FolhaDePagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RelatorioMemo;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    VerRelatorio: TButton;
    EdtHrsTrabalhadas: TEdit;
    EdtValorHrsTrabalhadas: TEdit;
    procedure VerRelatorioClick(Sender: TObject);
  private
    HrsTrabalhadas: double;
    ValorHrsTrabalhadas: double;


  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.VerRelatorioClick(Sender: TObject);
var
  SalarioBruto : double;
  SalarioLiquido : double;
  ImpostoRendaTaxa : double;
  ImpostoRenda : double;
  Fgts : double;
  SindicatoTaxa : double;
  ListaRelatorio : TStringList;
begin
  ValorHrsTrabalhadas := strtofloat(EdtValorHrsTrabalhadas.Text);
  HrsTrabalhadas := strtoint(EdtHrsTrabalhadas.Text);
  ImpostoRendaTaxa := 0;

  SalarioBruto := ValorHrsTrabalhadas * HrsTrabalhadas;

  if SalarioBruto <= 900 then
    ImpostoRendaTaxa := 0
  else
  if SalarioBruto <= 1500 then
    ImpostoRendaTaxa := 0.05
  else
  if SalarioBruto <= 2500 then
    ImpostoRendaTaxa := 0.1
  else
    ImpostoRendaTaxa := 0.2;

  ImpostoRenda := ImpostoRendaTaxa * SalarioBruto;
  SindicatoTaxa := SalarioBruto * 0.03 {Taxa do Sindicato};
  Fgts := SalarioBruto * 0.11;
  SalarioLiquido := SalarioBruto - ImpostoRenda - SindicatoTaxa;

  ListaRelatorio := TStringList.Create;
  try
    ListaRelatorio.add(Format('Salario Bruto: R$ %.2f', [SalarioBruto]));
    ListaRelatorio.add(Format('Valor Descontado pelo Sindicato: R$ %.2f', [SindicatoTaxa]));
    ListaRelatorio.add(Format('Valor do Imposto de Renda: R$ %.2f', [ImpostoRenda]));
    ListaRelatorio.add(Format('Valor do FGTS (Pago pela empresa): R$ %.2f', [Fgts]));
    ListaRelatorio.add(Format('Salario Liquido: R$ %.2f', [SalarioLiquido]));

    Form2.ExibirMemoRelatorio(ListaRelatorio);
  finally
    ListaRelatorio.Free;
  end;
  
end;

end.
