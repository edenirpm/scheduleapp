unit model.telefone;

interface
Type
TTelefone = class
  private
    FDDD: string;
    FCelular: string;
    FCodPais: string;
    procedure SetCelular(const Value: string);
    procedure SetDDD(const Value: string);
    procedure SetCodPais(const Value: string);
  public
  property DDD:string read FDDD write SetDDD;
  property Celular:string read FCelular write SetCelular;
  property CodPais:string read FCodPais write SetCodPais;
end;

implementation

{ TTelefone }

procedure TTelefone.SetCelular(const Value: string);
begin
  FCelular := Value;
end;

procedure TTelefone.SetCodPais(const Value: string);
begin
  FCodPais := Value;
end;

procedure TTelefone.SetDDD(const Value: string);
begin
  FDDD := Value;
end;

end.
