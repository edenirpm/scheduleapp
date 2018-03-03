unit model.cliente;

interface
uses
 System.Generics.collections,
 model.tratamento,
 model.orcamento,
 model.endereco,
 model.servico,
 model.telefone;
Type
TCliente = class
  private
    FServico: TServico;
    FHora: TTime;
    FStatus: string;
    FNome: string;
    FEndereco: TEndereco;
    FTelefone: TTelefone;
    FTratamentos: TObjectList<TTratamento>;
    FOrcamentos: TObjectList<TOrcamento>;
    procedure SetEndereco(const Value: TEndereco);
    procedure SetHora(const Value: TTime);
    procedure SetNome(const Value: string);
    procedure SetServico(const Value: TServico);
    procedure SetStatus(const Value: string);
    procedure SetTelefone(const Value: TTelefone);
    procedure SetTratamentos(const Value: TObjectList<TTratamento>);
    procedure SetOrcamentos(const Value: TObjectList<TOrcamento>);
  published
  property Nome:string read FNome write SetNome;
  property Telefone:TTelefone read FTelefone write SetTelefone;
  property Endereco:TEndereco read FEndereco write SetEndereco;
  property Tratamentos:TObjectList<TTratamento> read FTratamentos write SetTratamentos;
  property Hora:TTime read FHora write SetHora;
  property Status:string read FStatus write SetStatus;
  property Servico:TServico read FServico write SetServico;
  property Orcamentos:TObjectList<TOrcamento> read FOrcamentos write SetOrcamentos;
  constructor create;
  destructor destroy;override;
end;

implementation

{ TCliente }

constructor TCliente.create;
begin
FServico:=TServico.Create;
FEndereco:=TEndereco.Create;
FTelefone:=TTelefone.Create;
FTratamentos:=TObjectList<TTratamento>.create;
FOrcamentos:=TObjectList<TOrcamento>.create;
end;

destructor TCliente.destroy;
begin
FServico.Free;
FEndereco.Free;
FTelefone.Free;
FTratamentos.free;
FOrcamentos.Free;
  inherited;
end;

procedure TCliente.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TCliente.SetHora(const Value: TTime);
begin
  FHora := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TCliente.SetOrcamentos(const Value: TObjectList<TOrcamento>);
begin
  FOrcamentos := Value;
end;

procedure TCliente.SetServico(const Value: TServico);
begin
  FServico := Value;
end;

procedure TCliente.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TCliente.SetTelefone(const Value: TTelefone);
begin
  FTelefone := Value;
end;

procedure TCliente.SetTratamentos(const Value: TObjectList<TTratamento>);
begin
  FTratamentos := Value;
end;

end.
