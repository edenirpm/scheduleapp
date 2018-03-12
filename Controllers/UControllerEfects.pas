unit UControllerEfects;

interface
uses
UnitIEfects;
Type
TControllerEfect = class
  private
    FEfect: IEfect;
    procedure SetEfect(const Value: IEfect);
  published
  property Efect:IEfect read FEfect write SetEfect;
  constructor create;
end;
implementation

{ TController }

constructor TControllerEfect.create;
begin
FEfect:=TEfectLabelsTextUP.Create;
end;


procedure TControllerEfect.SetEfect(const Value: IEfect);
begin
  FEfect := Value;
end;

end.
