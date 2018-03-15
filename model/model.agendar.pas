unit model.agendar;

interface
uses
 System.generics.collections,
 model.funcionario,
 model.empresa,
 model.agendar1,
 model.cliente,
 model.agendados,
 model.key,
 model.servico;

 Type
 TAgendar= class
  private
    FDate:TDate;
    FFuncionarios: TObjectList<TFuncionario>;
    FDatas: Tlist<TDate>;
    FDataSelecionada: Tdate;
    FIndexFuncionario: integer;
    FClientes: TObjectList<TCliente>;
    FServicos: TObjectList<TServico>;
    FEmpresa: TEmpresa;
    FRequisicoes: TObjectList<TAgendar1>;
    FClienteName: string;
    FKey: TKey;
    procedure SetFuncionarios(const Value: TObjectList<TFuncionario>);
    procedure SetData(const Value: TDate);
    procedure SetDatas(const Value: TList<TDate>);
    procedure SetDataSelecionada(const Value: Tdate);
    procedure SetIndexFuncionario(const Value: integer);
    procedure SetClientes(const Value: TObjectList<TCliente>);
    procedure SetServicos(const Value: TObjectList<TServico>);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetRequisicoes(const Value: TObjectList<TAgendar1>);
    procedure SetClienteName(const Value: string);
    procedure SetKey(const Value: TKey);
  published
   property Datas:TList<TDate> read FDatas write SetDatas;
   property Funcionarios:TObjectList<TFuncionario> read FFuncionarios write SetFuncionarios;
   property DataSelecionada:Tdate read FDataSelecionada write SetDataSelecionada;
   property IndexFuncionario:integer read FIndexFuncionario write SetIndexFuncionario;
   property Clientes:TObjectList<TCliente> read FClientes write SetClientes;
   property Servicos:TObjectList<TServico> read FServicos write SetServicos;
   property Empresa:TEmpresa read FEmpresa write SetEmpresa;
   property Requisicoes:TObjectList<TAgendar1> read FRequisicoes write SetRequisicoes;
   property ClienteName:string read FClienteName write SetClienteName;
   property Key:TKey read FKey write SetKey;
   destructor destroy;override;
   procedure AddData(ADate:TDate);
  public
    class function GetInstance: TAgendar;
    class procedure ReleaseInstance;

  strict private
    constructor create;
    class var FInstance: TAgendar;
  end;

implementation

uses
  System.SysUtils, FMX.Dialogs;

{ TAgendar }

procedure TAgendar.AddData(ADate: TDate);
var
  I: Integer;
begin
   if FDatas.Contains(ADate)=true then
   begin
    Showmessage('Esta data ja tem');
   end else
        begin
          FDatas.Add(Adate);
        end;
  FDataSelecionada:=ADate;
end;

constructor TAgendar.create;
begin
FFuncionarios:=TObjectList<TFuncionario>.create;
FDatas:=TList<TDate>.create;
FClientes:=TObjectList<TCliente>.create;
FServicos:=TObjectList<TServico>.create;
FEmpresa:=TEmpresa.create;
FKey:=TKey.Create;
FRequisicoes:=TObjectList<TAgendar1>.create;
end;

destructor TAgendar.destroy;
begin
FFuncionarios.free;
FDatas.Clear;
FDatas.Free;
FClientes.Free;
FServicos.Free;
FEmpresa.Free;
FRequisicoes.Free;
FKey.free;
  inherited;
end;



procedure TAgendar.SetClienteName(const Value: string);
begin
  FClienteName := Value;
end;

procedure TAgendar.SetClientes(const Value: TObjectList<TCliente>);
begin
  FClientes := Value;
end;

procedure TAgendar.SetData(const Value: TDate);
begin
 FDate:=Value;
end;

procedure TAgendar.SetDatas(const Value: TList<TDate>);
begin
  FDatas := Value;
end;

procedure TAgendar.SetDataSelecionada(const Value: Tdate);
begin
 FDataSelecionada:=Value;
end;

procedure TAgendar.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TAgendar.SetFuncionarios(const Value: TObjectList<TFuncionario>);
begin
  FFuncionarios := Value;
end;

procedure TAgendar.SetIndexFuncionario(const Value: integer);
begin
  FIndexFuncionario := Value;
end;

procedure TAgendar.SetKey(const Value: TKey);
begin
  FKey := Value;
end;

procedure TAgendar.SetRequisicoes(const Value: TObjectList<TAgendar1>);
begin
  FRequisicoes := Value;
end;

procedure TAgendar.SetServicos(const Value: TObjectList<TServico>);
begin
  FServicos := Value;
end;

class function TAgendar.GetInstance: TAgendar;
begin
  If FInstance = nil Then
  begin
    FInstance := TAgendar.create();
  end;
  Result := FInstance;
end;

class procedure TAgendar.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
    Self.FInstance.Free;
end;
initialization
finalization
TAgendar.ReleaseInstance;
end.

