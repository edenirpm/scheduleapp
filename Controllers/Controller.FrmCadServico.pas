unit Controller.FrmCadServico;

interface
uses
model.servico,UDao,
model.agendar;
Type
IControllerServico = interface
  ['{B1E672A9-E875-4328-9120-F44FC684DFB9}']
  function CadastrarServico(Nome:string;Valor:Currency):boolean;
end;

TControllerServico = class (TInterfacedObject,IControllerServico)
 function CadastrarServico(Nome:string;Valor:Currency):boolean;
end;

implementation

{ TControllerServico }

function TControllerServico.CadastrarServico(Nome: string;
  Valor: Currency): boolean;
var
 Agendar:TAgendar;
 Servico:TServico;
 Dao:IDao;
begin
 try
     Agendar:=TAgendar.GetInstance;
     try
      Servico:=TServico.Create;
      Servico.Nome:=Nome;
      Servico.Valor:=Valor;
     finally
      Agendar.Servicos.Add(Servico);
      Result:=true;
      Dao:=Tfirebase.create;
      Dao.Update;
     end;
 except
 Result:=False;
 end;
end;

end.
