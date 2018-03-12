unit UDao;

interface
uses
  IPPeerClient,System.Threading,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,Rest.Json,model.agendar;

Type
IDao = interface
 ['{C97A66A8-E9F5-44F3-B534-A5F8193E60D3}']
 function Save():Idao;
 function Update():Idao;
 function Delete(AidObject:string):Idao;
 function GetDocument(AidObject:string):Idao;
 function doLogin(auser,apassword:string):IDAO;
 function Refresh:IDao;
end;

TDao = class(TInterfacedObject,IDao)
 private
    FRequest:TRestRequest;
    FResponse:TRestResponse;
    FRestClient:TRestClient;
 public
   constructor create;
   destructor destroy;override;
   function Save():Idao;
   function Update():Idao;
   function Delete(AidObject:string):Idao;
   function GetDocument(AidObject:string):Idao;
   function doLogin(auser,apassword:string):IDAO;
   function Refresh:IDao;

end;

implementation

uses
  REST.Types, FMX.Dialogs,model.listagendar,model.agendados;

{ TDao }

constructor TDao.create;
begin
  FRequest:=TRESTRequest.Create(nil);
  FResponse:=TRESTResponse.Create(nil);
  FRestClient:=TRESTClient.Create(nil);
  FRequest.Client:=FRestClient;
  FRestClient.BaseURL:='192.168.15.24:211/datasnap/rest/Tsm';
  FRequest.Response:=FResponse;
end;

function TDao.Delete(AidObject: string): Idao;
begin

end;

destructor TDao.destroy;
begin
FRequest.Free;
FResponse.Free;
FRestClient.free;
  inherited;
end;

function TDao.doLogin(auser, apassword: string): IDAO;
var
 Agendar:TAgendar;
 Agendados:TAgendados;
begin
   Result:=Self;
   Agendar:=TAgendar.GetInstance;
   FRequest.Resource:='/doLogin/'+auser+'/'+apassword;
   FRequest.Method:=TRESTRequestMethod.rmGet;
   FRequest.Execute;
   try
     Agendados:=(TJson.JsonToObject<TAgendados>(FResponse.JSONText));
     Agendar.Requisicoes.Clear;
     Agendar.Requisicoes.Add(Agendados);
     Agendar.Empresa := Agendar.Requisicoes.Last.Empresa;
     Agendar.Funcionarios:=Agendar.Requisicoes.Last.Funcionarios;
     Agendar.Clientes:=Agendar.Requisicoes.Last.Clientes;
     Agendar.Servicos:=Agendar.Requisicoes.Last.Servicos;
   finally

    // Agendados.Free;
   end;


end;

function TDao.GetDocument(AidObject: string): Idao;
begin

end;

function TDao.Refresh: IDao;
var
 Agendar:TAgendar;
 Agendados:TAgendados;
begin
   Result:=Self;
   Agendar:=TAgendar.GetInstance;
   FRequest.Resource:='/doLogin/'+Agendar.Empresa.Login+'/'+Agendar.Empresa.Senha;
   FRequest.Method:=TRESTRequestMethod.rmGet;
   FRequest.Execute;
   try
     Agendados:=(TJson.JsonToObject<TAgendados>(FResponse.JSONText));
     Agendar.Requisicoes.Clear;
     Agendar.Requisicoes.Add(Agendados);
     Agendar.Empresa := Agendar.Requisicoes.Last.Empresa;
     Agendar.Funcionarios:=Agendar.Requisicoes.Last.Funcionarios;
     Agendar.Clientes:=Agendar.Requisicoes.Last.Clientes;
     Agendar.Servicos:=Agendar.Requisicoes.Last.Servicos;
   finally
     //Agendados.Free;
   end;


end;

function TDao.Save: Idao;
 var
 Documento:TAgendados;
 Agendar:TAgendar;
  Task:ITask;
begin
 Task:=Ttask.Create(procedure
    begin
        try
       Agendar:=TAgendar.GetInstance;

       Documento:=TAgendados.Create;
       Documento.Funcionarios:=Agendar.Funcionarios;
       Documento.Clientes:=Agendar.Clientes;
       Documento.Servicos:=Agendar.Servicos;
       Documento.Empresa:=Agendar.Empresa;

       FRequest.Resource:='/Documentos';
       FRequest.Method:=TRESTRequestMethod.rmPOST;
       FRequest.AddBody(TJson.ObjectToJsonString(Documento),ContentTypeFromString('application/json'));
       FRequest.Execute;
     finally
       Documento.Free;
     end;

    end);

task.Start;
end;

function TDao.Update: Idao;
var
 DocumentUpdate:TAgendar;
 Task:ITask;
begin
 Task:=Ttask.Create(procedure
 begin
  DocumentUpdate:=TAgendar.GetInstance;
 FRequest.Resource:='/Documentos}';
 FRequest.Method:=TRESTRequestMethod.rmPut;
 FRequest.AddBody(TJson.ObjectToJsonString(DocumentUpdate),ContentTypeFromString('application/json'));
 FRequest.Execute;
 end);
 Task.Start;
 //Showmessage(FResponse.Content);
end;

end.
