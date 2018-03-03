unit model.tratamento;

interface
uses
model.servico,
System.Generics.Collections;
Type
TTratamento = class
  private
    FValorTratamento: currency;
    FNomeTratamento: string;
    FServicos: TObjectList<TServico>;
    procedure SetNomeTratamento(const Value: string);
    procedure SetServicos(const Value: TObjectList<TServico>);
    procedure SetValorTratamento(const Value: currency);
  published
  property NomeTratamento:string read FNomeTratamento write SetNomeTratamento;
  property ValorTratamento:currency read FValorTratamento write SetValorTratamento;
  property Servicos:TObjectList<TServico> read FServicos write SetServicos;
  constructor create;
  destructor destroy;override;
end;

implementation

{ TTratamento }

constructor TTratamento.create;
begin
FServicos:=TObjectList<TServico>.create;
end;

destructor TTratamento.destroy;
begin
FServicos.Free;
end;

procedure TTratamento.SetNomeTratamento(const Value: string);
begin
  FNomeTratamento := Value;
end;

procedure TTratamento.SetServicos(const Value: TObjectList<TServico>);
begin
  FServicos := Value;
end;

procedure TTratamento.SetValorTratamento(const Value: currency);
begin
  FValorTratamento := Value;
end;

end.
