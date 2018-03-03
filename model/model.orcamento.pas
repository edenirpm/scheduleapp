unit model.orcamento;

interface
uses
model.servico,system.generics.collections;
Type
TOrcamento = class
  private
    Fvalor: currency;
    FProcedimentos: Tobjectlist<TServico>;
    Fstatus: string;
    FData: TDate;
    procedure SetData(const Value: TDate);
    procedure SetProcedimentos(const Value: Tobjectlist<TServico>);
    procedure Setstatus(const Value: string);
    procedure Setvalor(const Value: currency);
  published
  property Data:TDate read FData write SetData;
  property Procedimentos:Tobjectlist<TServico> read FProcedimentos write SetProcedimentos;
  property valor:currency read Fvalor write Setvalor;
  property status:string read Fstatus write Setstatus;
  constructor create;
  destructor destroy;
end;

implementation

{ TOrcamento }

constructor TOrcamento.create;
begin
 Fprocedimentos:=TObjectList<TServico>.create;
end;

destructor TOrcamento.destroy;
begin
 Fprocedimentos.Free;
end;

procedure TOrcamento.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TOrcamento.SetProcedimentos(const Value: Tobjectlist<TServico>);
begin
  FProcedimentos := Value;
end;

procedure TOrcamento.Setstatus(const Value: string);
begin
  Fstatus := Value;
end;

procedure TOrcamento.Setvalor(const Value: currency);
begin
  Fvalor := Value;
end;

end.
