unit Controller.FrmAgendar.Singleton;

interface
Type

TSingleton = class
  private
    FUltimoclick: TObject;
    FHoraSelecionada: string;
    procedure SetHoraSelecionada(const Value: string);
    procedure SetUltimoclick(const Value: TObject);
  public
  property Ultimoclick:TObject read FUltimoclick write SetUltimoclick;
  property HoraSelecionada:string read FHoraSelecionada
      write SetHoraSelecionada;
  strict private
    class var FInstance: TSingleton;
  public
    class function GetInstance: TSingleton;
    class procedure ReleaseInstance;
    destructor destroy;override;
  end;

implementation

{ TSingleton }

procedure TSingleton.SetHoraSelecionada(const Value: string);
begin
  FHoraSelecionada := Value;
end;

procedure TSingleton.SetUltimoclick(const Value: TObject);
begin
  FUltimoclick := Value;
end;


destructor TSingleton.destroy;
begin
FInstance.Free;
end;

class function TSingleton.GetInstance: TSingleton;
begin
  If FInstance = nil Then
  begin
    FInstance := Controller.FrmAgendar.Singleton.TSingleton.Create();
  end;
  Result := FInstance;
end;

class procedure TSingleton.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
    Self.FInstance.Free;
end;
initialization
finalization
TSingleton.ReleaseInstance;
end.
