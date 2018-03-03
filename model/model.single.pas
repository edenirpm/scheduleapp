unit model.single;

interface
uses
System.Generics.collections,
model.funcionario,
mode.agendamento,
model.empresa,
model.servico;
Type
 TSingle = class
  private
    FFuncionarios: TObjectList<TFuncionario>;
    FServicos: TObjectList<TServico>;
    FEmpresa: TEmpresa;
    FAgendamentos: TObjectList<TAgendamento>;
    FHora: TTime;
    FData: TDate;
    procedure SetFuncionarios(const Value: TObjectList<TFuncionario>);
    procedure SetServicos(const Value: TObjectList<TServico>);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetAgendamentos(const Value: TObjectList<TAgendamento>);
    procedure SetData(const Value: TDate);
    procedure SetHora(const Value: TTime);
  public
   property Funcionarios:TObjectList<TFuncionario> read FFuncionarios write SetFuncionarios;
   property Servicos:TObjectList<TServico> read FServicos write SetServicos;
   property Empresa:TEmpresa read FEmpresa write SetEmpresa;
   property Agendamentos:TObjectList<TAgendamento> read FAgendamentos write SetAgendamentos;
   property Data:TDate read FData write SetData;
   property Hora:TTime read FHora write SetHora;
   constructor create;
   destructor destroy;override;
  public
    class function GetInstance: TSingle;
  strict private
    class var FInstance: TSingle;
  end;

implementation

{ TSingle }

constructor TSingle.create;
begin
FFuncionarios:=TObjectList<TFuncionario>.create;
FServicos:=TObjectList<TServico>.create;
Fempresa:=TEmpresa.create;
FAgendamentos:=TObjectList<TAgendamento>.create;
end;

destructor TSingle.destroy;
begin
FFuncionarios.DisposeOf;
FServicos.DisposeOf;
FEmpresa.Destroy;
FAgendamentos.DisposeOf;
end;

procedure TSingle.SetAgendamentos(const Value: TObjectList<TAgendamento>);
begin
  FAgendamentos := Value;
end;

procedure TSingle.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TSingle.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TSingle.SetFuncionarios(const Value: TObjectList<TFuncionario>);
begin
  FFuncionarios := Value;
end;

procedure TSingle.SetHora(const Value: TTime);
begin
  FHora := Value;
end;

procedure TSingle.SetServicos(const Value: TObjectList<TServico>);
begin
  FServicos := Value;
end;

class function TSingle.GetInstance: TSingle;
begin
  If FInstance = nil Then
  begin
    FInstance := model.single.TSingle.create();
  end;
  Result := FInstance;
end;

end.
