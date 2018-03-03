unit model.marcacao;

interface
uses
 model.cliente,model.servico,System.generics.collections;
Type
TMarcacao =class
  private
    FCliente: TCliente;
    FHoras: TList<TTime>;
    FData: Tdate;
    FServico: TServico;
    FStatus: string;
    procedure SetCliente(const Value: TCliente);
    procedure SetData(const Value: Tdate);
    procedure SetHoras(const Value: TList<TTime>);
    procedure SetServico(const Value: TServico);
    procedure SetStatus(const Value: string);
  published
 property Data:Tdate read FData write SetData;
 property Horas:TList<TTime> read FHoras write SetHoras;
 property Cliente:TCliente read FCliente write SetCliente;
 property Status:string read FStatus write SetStatus;
 property Servico:TServico read FServico write SetServico;
 constructor create;
 destructor destroy;override;
end;

implementation

{ TMarcacao }


{ TMarcacao }

constructor TMarcacao.create;
begin
FHoras:=TList<TTime>.Create;
FCliente:=TCliente.create;
FServico:=TServico.Create;
end;

destructor TMarcacao.destroy;
begin
FHoras.Free;
FCliente.Free;
FServico.Free;
  inherited;
end;

procedure TMarcacao.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TMarcacao.SetData(const Value: Tdate);
begin
  FData := Value;
end;

procedure TMarcacao.SetHoras(const Value: TList<TTime>);
begin
  FHoras := Value;
end;

procedure TMarcacao.SetServico(const Value: TServico);
begin
  FServico := Value;
end;

procedure TMarcacao.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

end.
