unit Controller.FrmCadFuncionario;

interface
uses
Model.agendar,model.funcionario,UDao;
Type
IControllerFuncionario = interface
  ['{8412E7A7-0082-4B60-96DF-B15E9C661F08}']
   function CadastrarFuncionario(cord,nome,login,senha:string):boolean;
end;

TControllerFuncionario= class (TInterfacedObject,IControllerFuncionario)
  function CadastrarFuncionario(cord,nome,login,senha:string):boolean;
end;

implementation

{ TController }

function TControllerFuncionario.CadastrarFuncionario(cord,nome,login,senha:string): boolean;
var
 Agendar:TAgendar;
 Funcionario:TFuncionario;
 Dao:IDao;
begin
try
   Agendar:=TAgendar.GetInstance;
   try
     Funcionario:=TFuncionario.create;
    funcionario.Cordialidade:=cord;
    funcionario.Nome:=Nome;
    funcionario.Login:=Login;
    Funcionario.Senha:=Senha;
   finally
    Agendar.Funcionarios.Add(Funcionario);
    Result:=true;
    if Agendar.Key.Name<>'' then
    begin
     Dao:=Tfirebase.create;
     Dao.Update;
    end;

   end;

Except
 Result:=False;
end;

end;

end.
