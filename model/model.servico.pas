unit model.servico;

interface
Type
TServico = class
  private
    FValor: Currency;
    FNome: string;
    procedure SetNome(const Value: string);
    procedure SetValor(const Value: Currency);
  public
  property Nome:string read FNome write SetNome;
  property Valor:Currency read FValor write SetValor;
end;

implementation

{ TServico }

procedure TServico.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TServico.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
