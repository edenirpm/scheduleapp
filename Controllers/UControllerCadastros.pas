unit UControllerCadastros;

interface
uses
Fmx.Forms,
Controller.FrmLogin,
System.SysUtils,
model.servico,
model.cliente,
FMX.ListView,
FMX.ImgList,
model.agendar,{$ifdef Android}AndroidApi.jni.toast,{$endif}
model.funcionario,
UWorks,UDAO,
UfrmCadFuncionario,
UfrmCadServico,
UfrmCadClientes,
system.generics.collections;
Type
ICadastros = interface
['{1D09020B-41BA-4DF2-AF91-ECBD366D1AC2}']
  procedure CadastrarFuncionario(Cordialidade,Nome,Login,Senha:string);
  procedure CadastrarServico(NomeServico:string;ValorServico:Currency);
  function CadastrarEmpresa(Nome,Rua,num,bairro,cidade,uf,pais,ddd,celular,login,senha:string):IWork;
  function ListarServicos(AListview:TListview;AImageList:TImageList):ICadastros;
  function ListarFuncionarios(AListview:TListview;AImageList:TImageList):ICadastros;
  function CountFuncionarios:integer;
  function CountServicos:integer;
  function DeleteServico(AIndexServico:integer):ICadastros;
  Function DeleteFuncionario(AIndexFuncionaro:integer):ICadastros;
  function ListarClientes(AListview:TListview;AImageList:TImageList):ICadastros;
  function DeletarCliente(AIndexFuncionaro:integer):ICadastros;
  procedure ShowClients;
  procedure ShowFuncionarios;
  procedure ShowServicos;
  procedure update;

end;

TControllerCadastros = class(TinterfacedObject,ICadastros,IWork)
  procedure CadastrarFuncionario(Cordialidade,Nome,Login,Senha:string);
  procedure CadastrarServico(NomeServico:string;ValorServico:Currency);
  function CadastrarEmpresa(Nome,Rua,num,bairro,cidade,uf,pais,ddd,celular,login,senha:string):IWork;
  function ListarServicos(AListview:TListview;AImageList:TImageList):ICadastros;
  function ListarFuncionarios(AListview:TListview;AImageList:TImageList):ICadastros;
  function CountFuncionarios:integer;
  function CountServicos:integer;
  function DeleteServico(AIndexServico:integer):ICadastros;
  Function DeleteFuncionario(AIndexFuncionaro:integer):ICadastros;
  function ListarClientes(AListview:TListview;AImageList:TImageList):ICadastros;
  function DeletarCliente(AIndexFuncionaro:integer):ICadastros;
  function Execute:Iwork;
  procedure ShowClients;
  procedure ShowFuncionarios;
  procedure ShowServicos;
  procedure update;
  procedure SaveLogin(AKey:string);
end;

implementation

uses
  FMX.Dialogs;

{ TControllerCadastros }

procedure TControllerCadastros.SaveLogin(AKey:string);
var
 Ctrl:IControllerLogin;
begin
 Ctrl:=TControllerLogin.create;
 Ctrl.AutoLogin(AKey);
end;

function TControllerCadastros.CadastrarEmpresa(Nome, Rua, num, bairro, cidade,
  uf, pais, ddd, celular, login, senha:string):IWork;
var
 Agendar:TAgendar;
 Dao:IDao;
begin
   Result:=Self;
   try
     Agendar:=TAgendar.GetInstance;
     Agendar.Empresa.Nome:=Nome;
     Agendar.Empresa.Endereco.Rua:=Rua;
     Agendar.Empresa.Endereco.Numero:=num;
     Agendar.Empresa.Endereco.Bairro:=Bairro;
     Agendar.Empresa.Endereco.Cidade:=Cidade;
     Agendar.Empresa.Endereco.Estado:=uf;
     Agendar.Empresa.Endereco.pais:=pais;
     if (Agendar.empresa.Endereco.Pais = 'BR') or (Agendar.empresa.Endereco.Pais = 'Pais') then
     begin
      Agendar.Empresa.Telefone.CodPais:='55';
     end;
     Agendar.Empresa.Telefone.DDD:=ddd;
     Agendar.Empresa.Telefone.Celular:=celular;
     Agendar.Empresa.Login:=Login;
     Agendar.Empresa.Senha:=Senha;
     Agendar.Empresa.Bloqued:=False;
   finally
     Dao:=TFirebase.create;
    // Dao:=TDao.create;
     Dao.Save;
   end;


end;

procedure TControllerCadastros.CadastrarFuncionario(Cordialidade,Nome,Login,Senha:string);
var
 Funcionario:TFuncionario;
 Agendar:Tagendar;
begin
 Agendar:=TAgendar.GetInstance;
 try
  Funcionario :=TFuncionario.Create;
  Funcionario.Cordialidade:=Cordialidade;
  Funcionario.Nome:=Nome;
  Funcionario.Login:=Login;
  Funcionario.Senha:=Senha;
 finally
  Agendar.Funcionarios.Add(Funcionario);
 end;
end;


procedure TControllerCadastros.CadastrarServico(NomeServico: string;
  ValorServico: Currency);
var
Servico:TServico;
Agendar:TAgendar;
begin
Agendar:=TAgendar.GetInstance;
  try
   Servico:=TServico.Create;
   Servico.Nome:=NomeServico;
   Servico.Valor:=ValorServico;
  finally
   Agendar.Servicos.Add(Servico);
  end;
end;

function TControllerCadastros.CountFuncionarios: integer;
var
 Agendar:TAgendar;
begin
 Agendar:=TAgendar.GetInstance;
 Result:=Agendar.Funcionarios.Count;
end;

function TControllerCadastros.CountServicos: integer;
var
 Agendar:TAgendar;
begin
  Agendar:=TAgendar.GetInstance;
  Result:=Agendar.Servicos.Count;
end;

function TControllerCadastros.DeletarCliente(
  AIndexFuncionaro: integer): ICadastros;
var
 Agendar:TAgendar;
begin
 Agendar:=TAgendar.GetInstance;
 Agendar.Clientes.Delete(AIndexFuncionaro);
end;


function TControllerCadastros.DeleteFuncionario(
  AIndexFuncionaro: integer): ICadastros;
var
 Agendar:TAgendar;
begin
 Agendar:=TAgendar.GetInstance;
 Agendar.Funcionarios.Delete(AIndexFuncionaro);
end;

function TControllerCadastros.DeleteServico(AIndexServico: integer): ICadastros;
var
 Agendar:TAgendar;
begin
 Agendar:=TAgendar.GetInstance;
 Agendar.Servicos.Delete(AIndexServico);
end;

function TControllerCadastros.Execute: Iwork;
begin
Sleep(3000);
end;

function TControllerCadastros.ListarClientes(AListview: TListview;
  AImageList: TImageList): ICadastros;
var
 Cliente:TCliente;
 Agendar:TAgendar;
begin
 Agendar:=TAgendar.GetInstance;
 Alistview.Items.Clear;
 for Cliente in Agendar.Clientes do
 begin
    with AListview.Items.Add do
      begin
       Data['Foto']:=Aimagelist.Source[0].ID;
       Data['Nome']:= Cliente.Nome;
       Data['Telefone']:=Cliente.Telefone.Celular;
      end;
 end;
end;

function TControllerCadastros.ListarFuncionarios(AListview: TListview;
  AImageList: TImageList):ICadastros;
var
Funcionario:TFuncionario;
Agendar:TAgendar;
begin
 Result:=Self;
 Agendar:=TAgendar.GetInstance;
 AListview.Items.Clear;
 for Funcionario in agendar.Funcionarios do
  begin
    with AListview.Items.Add do
    begin
     Data['Foto']:=Aimagelist.Source[0].ID;
     Data['Lixo']:=Aimagelist.Source[2].ID;
     Data['Cord']:= Funcionario.Cordialidade;
     Data['Nome']:= Funcionario.Nome;
     Data['Login']:= Funcionario.Login;
     Data['Senha']:= Funcionario.Senha;
    end;
  end;
end;

function TControllerCadastros.ListarServicos(AListview: TListview;
  AImageList: TImageList):ICadastros;
var
Servico:TServico;
Agendar:TAgendar;
begin
Result:=Self;
Agendar:=TAgendar.GetInstance;
  AListview.Items.Clear;
  for Servico in Agendar.Servicos do
  begin
  with Alistview.Items.Add do
    begin
     Data['Nome']:= Servico.Nome;
     Data['Valor']:= Servico.Valor;
     Data['Foto']:=Aimagelist.Source[1].ID;
     Data['Lixo']:=Aimagelist.Source[2].ID;
    end;
  end;
end;

procedure TControllerCadastros.ShowClients;
begin
 Application.CreateForm(TFrmCadClientes, FrmCadClientes);
 frmCadClientes.show;
end;

procedure TControllerCadastros.ShowFuncionarios;
begin
 Application.CreateForm(TFrmCadFuncionario, FrmCadFuncionario);
 frmCadFuncionario.show;
end;

procedure TControllerCadastros.ShowServicos;
begin
 Application.CreateForm(TFrmCadServico, FrmCadServico);
 FrmCadServico.show;
end;

procedure TControllerCadastros.update;
var
Dao:IDao;
begin
 Dao:=TFirebase.create;
  {$ifdef Android}
  Toast('Aguarde...',LongToast);
 {$endif}
 Dao.Update;
end;

end.
