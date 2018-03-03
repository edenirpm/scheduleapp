unit model.empresa;

interface
uses
model.endereco,
model.telefone;
type
TEmpresa = class
  private
    FNome: string;
    FEndereco: TEndereco;
    FTelefone: TTelefone;
    FSenha: string;
    FLogin: string;
    FBloqued: boolean;
    procedure SetEndereco(const Value: TEndereco);
    procedure SetNome(const Value: string);
    procedure SetTelefone(const Value: TTelefone);
    procedure SetLogin(const Value: string);
    procedure SetSenha(const Value: string);
    procedure SetBloqued(const Value: boolean);
  public
  property Nome:string read FNome write SetNome;
  property Endereco:TEndereco read FEndereco write SetEndereco;
  property Telefone:TTelefone read FTelefone write SetTelefone;
  property Login:string read FLogin write SetLogin;
  property Senha:string read FSenha write SetSenha;
  property Bloqued:boolean read FBloqued write SetBloqued;
  constructor create;
  destructor destroy;override;
end;

implementation

{ TEmpresa }

constructor TEmpresa.create;
begin
FEndereco:=TEndereco.create;
FTelefone:=TTelefone.create;
end;

destructor TEmpresa.destroy;
begin
 Fendereco.disposeof;
 FTelefone.Disposeof;
end;

procedure TEmpresa.SetBloqued(const Value: boolean);
begin
  FBloqued := Value;
end;

procedure TEmpresa.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TEmpresa.SetLogin(const Value: string);
begin
  FLogin := Value;
end;

procedure TEmpresa.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TEmpresa.SetSenha(const Value: string);
begin
  FSenha := Value;
end;

procedure TEmpresa.SetTelefone(const Value: TTelefone);
begin
  FTelefone := Value;
end;

end.
