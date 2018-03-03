unit model.funcionario;

interface
uses
 model.marcacao,System.generics.collections,model.agendamentos;
type
TFuncionario = class
  private
    FSenha: string;
    FCordialidade: string;
    FLogin: string;
    FNome: string;
    FAgendamentos: TAgendamentos;
    procedure SetCordialidade(const Value: string);
    procedure SetLogin(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetSenha(const Value: string);
    procedure SetAgendamentos(const Value: TAgendamentos);
  public
  property Cordialidade:string read FCordialidade write SetCordialidade;
  property Nome:string read FNome write SetNome;
  property Login:string read FLogin write SetLogin;
  property Senha:string read FSenha write SetSenha;
  property Agendamentos:TAgendamentos read FAgendamentos write SetAgendamentos;
  Constructor Create;
  Destructor destroy;override;
end;

implementation

{ TFuncionario }

constructor TFuncionario.Create;
begin
FAgendamentos:=TAgendamentos.create;
end;

destructor TFuncionario.destroy;
begin
FAgendamentos.Free;
end;

procedure TFuncionario.SetAgendamentos(const Value: TAgendamentos);
begin
  FAgendamentos := Value;
end;

procedure TFuncionario.SetCordialidade(const Value: string);
begin
  FCordialidade := Value;
end;

procedure TFuncionario.SetLogin(const Value: string);
begin
  FLogin := Value;
end;

procedure TFuncionario.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TFuncionario.SetSenha(const Value: string);
begin
  FSenha := Value;
end;

end.
