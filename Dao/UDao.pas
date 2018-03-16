unit UDao;

interface
uses
  IPPeerClient,System.Threading,System.sysUtils,System.Inifiles,System.classes,
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

Tfirebase = class(TInterfacedObject,IDAO)
 private
    FRequest:TRestRequest;
    FResponse:TRestResponse;
    FRestClient:TRestClient;
    FKey:string;
 public
   constructor create;
   destructor destroy;override;
   function Save():Idao;
   function Update():Idao;
   function Delete(AidObject:string):Idao;
   function GetDocument(AidObject:string):Idao;
   function doLogin(auser,apassword:string):IDAO;
   function Refresh:IDao;
   procedure SaveLogin(AKey:string);
   procedure LoadKey();

end;

implementation

uses
  REST.Types, FMX.Dialogs,model.listagendar,model.agendados,model.key,model.agendar1;

{ TDao }

constructor TDao.create;
begin
  FRequest:=TRESTRequest.Create(nil);
  FResponse:=TRESTResponse.Create(nil);
  FRestClient:=TRESTClient.Create(nil);
  FRequest.Client:=FRestClient;
  //FRestClient.BaseURL:='localhost:211/datasnap/rest/Tsm';
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
   //  Agendar.Requisicoes.Add(Agendados);
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
    // Agendar.Requisicoes.Add(Agendados);
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

    end;



{$ifdef android}
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
 {$endif}
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

{ Tfirebase }

constructor Tfirebase.create;
begin
  FRequest:=TRESTRequest.Create(nil);
  FResponse:=TRESTResponse.Create(nil);
  FRestClient:=TRESTClient.Create(nil);
  FRequest.Client:=FRestClient;
  //FRestClient.BaseURL:='localhost:211/datasnap/rest/Tsm';
  FRestClient.BaseURL:='https://ageon-77a4a.firebaseio.com/Documentos';
  FRequest.Response:=FResponse;
end;

function Tfirebase.Delete(AidObject: string): Idao;
begin

end;

destructor Tfirebase.destroy;
begin
FRequest.Free;
FResponse.Free;
FRestClient.free;
  inherited;
end;

function Tfirebase.doLogin(auser, apassword: string): IDAO;
var
 Agendar:TAgendar;
 Agendados:TAgendar1;
begin
   Result:=Self;
   Agendar:=TAgendar.GetInstance;
   FRestClient.BaseURL:= 'https://ageon-77a4a.firebaseio.com/Documentos/'+Agendar.Key.Name+'.json';
   FRequest.Method:=TRESTRequestMethod.rmGet;
   FRequest.Execute;
   try
     Agendados:=(TJson.JsonToObject<TAgendar1>(FResponse.JSONText));
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

function Tfirebase.GetDocument(AidObject: string): Idao;
begin

end;

procedure Tfirebase.LoadKey;
var
Ini:TInifile;
Agendar:TAgendar;
begin
 Agendar:=TAgendar.GetInstance;

 try
  Ini:=TIniFile.Create(GetHomePath + PathDelim +'login.ini');
  Agendar.Key.Name:= ini.ReadString('Login','Key','');
 finally
  Ini.Free;
 end;
end;

function Tfirebase.Refresh: IDao;
var
 Agendar:TAgendar;
 Agendados:TAgendar1;
 Task:ITask;
begin
   Result:=Self;
  //  Task:=Ttask.Create(procedure
 //  begin
       Agendar:=TAgendar.GetInstance;
       FRestClient.BaseURL:= 'https://ageon-77a4a.firebaseio.com/Documentos/'+Agendar.Key.Name+'.json';
       FRequest.Method:=TRESTRequestMethod.rmGet;
       FRequest.Execute;
       try
         Agendados:=(TJson.JsonToObject<TAgendar1>(FResponse.JSONText));
         Agendar.Requisicoes.Clear;
         Agendar.Requisicoes.Add(Agendados);
         Agendar.Empresa := Agendar.Requisicoes.Last.Empresa;
         Agendar.Funcionarios:=Agendar.Requisicoes.Last.Funcionarios;
         Agendar.Clientes:=Agendar.Requisicoes.Last.Clientes;
         Agendar.Servicos:=Agendar.Requisicoes.Last.Servicos;
       finally

        // Agendados.Free;
       end;


 //   end);
 //   Task.Start;
end;

function Tfirebase.Save: Idao;
 var
 Agendar:TAgendar;
  Task:ITask;
  Url:string;
begin

 begin
     Agendar:=TAgendar.GetInstance;
     try
      Url:='https://ageon-77a4a.firebaseio.com/Documentos.json';
       FRestClient.BaseURL:=Url;
       FRequest.Method:=TRESTRequestMethod.rmPOST;
       FRequest.AddBody(TJson.ObjectToJsonString(Agendar),ContentTypeFromString('application/json'));
       FRequest.Execute;
       Agendar.Key:=TJson.JsonToObject<TKey>(FResponse.Content);
       FKey:=Agendar.Key.Name;
       SaveLogin(Fkey);
     finally
       Update;
     end;

  end;

{ Task:=Ttask.Create(procedure
   begin
       Agendar:=TAgendar.GetInstance;
     try
      Url:='https://ageon-77a4a.firebaseio.com/Documentos.json';
       FRestClient.BaseURL:=Url;
       FRequest.Method:=TRESTRequestMethod.rmPOST;
       FRequest.AddBody(TJson.ObjectToJsonString(Agendar),ContentTypeFromString('application/json'));
       FRequest.Execute;
       Agendar.Key:=TJson.JsonToObject<TKey>(FResponse.Content);
       FKey:=Agendar.Key.Name;
       SaveLogin(Fkey);
       Update;
     finally
     end;

    end);
task.Start; }

end;
procedure Tfirebase.SaveLogin(AKey: string);
var
Ini:TInifile;
begin
 try
   Ini:=TIniFile.Create(GetHomePath + PathDelim +'login.ini');
   ini.WriteString('Login','Key',Akey);
 finally
   Ini.Free;
 end;
end;

function Tfirebase.Update: Idao;
var
Agendar:TAgendar;
Task:ITask;
url:string;
  begin
 //  Task:=Ttask.Create(procedure
  // begin
     Agendar:=TAgendar.GetInstance;
     try
       FRestClient.BaseURL:='';
       FRequest.ClearBody;
       Url:='https://ageon-77a4a.firebaseio.com/Documentos/'+Agendar.Key.Name+'.json';
       FRestClient.BaseURL:=url;
       FRequest.Method:=TRESTRequestMethod.rmPUT;
       FRequest.AddBody(TJson.ObjectToJsonString(Agendar),ContentTypeFromString('application/json'));
       FRequest.Execute;
     finally
     end;

//  end);
//  Task.Start;
  end;

end.
