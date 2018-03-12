unit model.singletons;

interface
uses
System.Generics.Collections,
model.servico,
model.funcionario;
Type
TSingletons = class
  private
    FFuncionarios: TObjectList<TFuncionario>;
    FServicos: TObjectList<TServico>;
    procedure SetFuncionarios(const Value: TObjectList<TFuncionario>);
    procedure SetServicos(const Value: TObjectList<TServico>);
  published
  property Funcionarios:TObjectList<TFuncionario> read FFuncionarios write SetFuncionarios;
  property Servicos:TObjectList<TServico> read FServicos write SetServicos;
  constructor Create;
  Destructor Destroy;override;
  public
    class function GetInstance: TSingletons;
  strict private
    class var FInstance: TSingletons;
  end;

implementation

{ TSingletons }

constructor TSingletons.Create;
begin
FFuncionarios:=TObjectList<TFuncionario>.create;
FServicos:=TObjectList<TServico>.create;
end;

destructor TSingletons.Destroy;
begin
FFuncionarios.Disposeof;
FServicos.Disposeof;
end;

procedure TSingletons.SetFuncionarios(const Value: TObjectList<TFuncionario>);
begin
  FFuncionarios := Value;
end;

procedure TSingletons.SetServicos(const Value: TObjectList<TServico>);
begin
  FServicos := Value;
end;

class function TSingletons.GetInstance: TSingletons;
begin
  If FInstance = nil Then
  begin
    FInstance := model.singletons.TSingletons.Create();
  end;
  Result := FInstance;
end;

end.
