unit mode.agendamento;

interface
uses
model.servico,
model.funcionario;

Type
 TAgendamento = class
  private
    FFuncionario: TFuncionario;
    FServico: TServico;
    FHora: TTime;
    FStatus: string;
    FData: Tdate;
    procedure SetData(const Value: Tdate);
    procedure SetFuncionario(const Value: TFuncionario);
    procedure SetHora(const Value: TTime);
    procedure SetServico(const Value: TServico);
    procedure SetStatus(const Value: string);
  public
   property Data:Tdate read FData write SetData;
   property Hora:TTime read FHora write SetHora;
   property Funcionario:TFuncionario read FFuncionario write SetFuncionario;
   property Servico:TServico read FServico write SetServico;
   property Status:string read FStatus write SetStatus;
   constructor Create;
   destructor destroy;override;
 end;

implementation

{ TAgendamento }

constructor TAgendamento.Create;
begin
  FFuncionario:=TFuncionario.Create;
  FServico:=TServico.Create;
end;

destructor TAgendamento.destroy;
begin
FFuncionario.DisposeOf;
FServico.DisposeOf;
end;

procedure TAgendamento.SetData(const Value: Tdate);
begin
  FData := Value;
end;

procedure TAgendamento.SetFuncionario(const Value: TFuncionario);
begin
  FFuncionario := Value;
end;

procedure TAgendamento.SetHora(const Value: TTime);
begin
  FHora := Value;
end;

procedure TAgendamento.SetServico(const Value: TServico);
begin
  FServico := Value;
end;

procedure TAgendamento.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

end.
