unit model.telefone;

interface

Type
TTelefone = class
  private
    FDDD: string;
    FCelular: string;
    FCodPais: string;
    procedure SetCelular(const Value: string);
    procedure SetDDD(const Value: string);
    procedure SetCodPais(const Value: string);
    function GetCelular: string;
  public
  property DDD:string read FDDD write SetDDD;
  property Celular:string read GetCelular write SetCelular;
  property CodPais:string read FCodPais write SetCodPais;
end;

implementation
uses
model.agendar;

{ TTelefone }

function TTelefone.GetCelular: string;
var
Agendar:TAgendar;
begin
Agendar:=TAgendar.getinstance;
if (FDDD='')or (FCodPais='') then
begin
  FDDD:=Agendar.Empresa.Telefone.FDDD;
  FCodPAis:=Agendar.Empresa.Telefone.CodPais;
end;

   try
     if Length(FCelular) = 8 then
    begin
     FCelular:= FCodPais+Fddd+Fcelular;
     Result:=Fcelular;
    end;
    if Length(FCelular) = 9 then
    begin
     FCelular:= FCodPais+Fddd+Fcelular;
     Result:=Fcelular;
    end;
      if  Length(FCelular) =11 then
    begin
      FCelular:= FCodPais+Fcelular;
      Result:=Fcelular;
    end;
      if  Length(FCelular) =12 then
    begin
      Result:= FCelular;
    end;
    if  Length(FCelular) >=13 then
    begin
      FCelular:= copy(Fcelular,1,25);
      Result:=FCelular
    end;

  Except
  Result := FCelular;
 end;
 Result:=FCelular;
end;

procedure TTelefone.SetCelular(const Value: string);
begin
FCelular:=Value;

end;

procedure TTelefone.SetCodPais(const Value: string);
begin
  FCodPais := Value;
end;

procedure TTelefone.SetDDD(const Value: string);
begin
    if  Length(value) >2 then
  begin
   FDDD := copy(Value,1,2);
  end else
  begin
    FDDD:=value;
  end;
end;

end.
