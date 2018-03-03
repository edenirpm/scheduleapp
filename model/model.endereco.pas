unit model.endereco;

interface
Type
TEndereco = class
  private
    FBairro: string;
    FNumero: string;
    FCidade: string;
    FPais: string;
    FEstado: string;
    FRua: string;
    procedure SetBairro(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetEstado(const Value: string);
    procedure SetNumero(const Value: string);
    procedure SetPais(const Value: string);
    procedure SetRua(const Value: string);
  public
  property Rua:string read FRua write SetRua;
  property Numero:string read FNumero write SetNumero;
  property Bairro:string read FBairro write SetBairro;
  property Cidade:string read FCidade write SetCidade;
  property Estado:string read FEstado write SetEstado;
  property Pais:string read FPais write SetPais;
end;

implementation

{ TEndereco }

procedure TEndereco.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TEndereco.SetEstado(const Value: string);
begin
  FEstado := Value;
end;

procedure TEndereco.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TEndereco.SetPais(const Value: string);
begin
  FPais := Value;
end;

procedure TEndereco.SetRua(const Value: string);
begin
  FRua := Value;
end;

end.
