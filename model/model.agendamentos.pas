unit model.agendamentos;

interface
uses
 model.marcacao,System.Generics.collections;
Type
TAgendamentos = class
  private
    FMarcacoes: TObjectList<TMarcacao>;
    procedure SetMarcacoes(const Value: TObjectList<TMarcacao>);
  published
  property Marcacoes:TObjectList<TMarcacao> read FMarcacoes write SetMarcacoes;
  constructor create;
  destructor destroy;override;
end;

implementation

{ TAgendamentos }

constructor TAgendamentos.create;
begin
Fmarcacoes:=TObjectList<TMarcacao>.create;
end;

destructor TAgendamentos.destroy;
begin
FMarcacoes.Free;
  inherited;
end;

procedure TAgendamentos.SetMarcacoes(const Value: TObjectList<TMarcacao>);
begin
  FMarcacoes := Value;
end;

end.
