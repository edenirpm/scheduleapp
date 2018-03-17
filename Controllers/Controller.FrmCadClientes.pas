unit Controller.FrmCadClientes;

interface
uses
model.cliente,model.agendar,UControllers,Udao;
Type
IControllerCliente = interface
  ['{04D86979-E0E7-4E0A-AFBF-C13DA271ED6E}']
  function CadastrarCliente(Nome,DDD,Telefone:string):IControllerCliente;
  function EfectTextToUP(AObject:TObject):IControllerCliente;
end;

TControllerCliente = class(TInterfacedObject,IControllerCliente)
 function CadastrarCliente(Nome,DDD,Telefone:string):IControllerCliente;
 function EfectTextToUP(AObject:TObject):IControllerCliente;
end;

implementation

{ TControllerCliente }

function TControllerCliente.CadastrarCliente(Nome, DDD,
  Telefone:string): IControllerCliente;
var
 Cliente:TCliente;
 Agendar:TAgendar;
 dao:IDao;
begin
 Result:=Self;
 try
   Cliente:=TCliente.create;
   Cliente.Nome:=Nome;
   Cliente.Telefone.DDD:=DDD;
   Cliente.Telefone.Celular:=Telefone;
 finally
   Agendar:=TAgendar.GetInstance;
   Agendar.Clientes.Add(Cliente);
   if Agendar.Key.Name<>'' then
    begin
     Dao:=Tfirebase.create;
     Dao.Update;
    end;
 end;
end;

function TControllerCliente.EfectTextToUP(AObject: TObject): IControllerCliente;
var
 Efect:IController;
begin
 Result:=Self;
 Efect:=TController.Create;
 Efect.EfectTextToUp(AObject);
end;

end.
