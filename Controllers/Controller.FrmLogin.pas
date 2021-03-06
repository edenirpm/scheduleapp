unit Controller.FrmLogin;

interface
uses
UDao,
System.Inifiles,
model.agendar,
model.ListAgendar,
{$ifdef Android}AndroidApi.Jni.Toast,{$endif}
uworks,
UfrmCalendar,
FMX.Forms, System.SysUtils;
Type
IControllerLogin = interface
 ['{D29855E8-68DC-4B0D-8E9E-7B19BD278BBC}']
 function doLogin(AUser,APassword:string):Boolean;
 function Execute: IWork; overload;
 function Execute(AUser,APassword:string):Iwork; overload;
 function AutoLogin:IControllerLogin;overload;
 function AutoLogin(AKey:string):IControllerLogin;overload;
end;

TControllerLogin = class (TInterfacedObject,IControllerLogin,IWork)
   function doLogin(AUser,APassword:string):Boolean;
   function CreateSingleton:IControllerLogin;
   function ReleaseInstance:IControllerLogin;
   function Execute: IWork; overload;
   function Execute(AUser,APassword:string):Iwork; overload;
   function AutoLogin:IControllerLogin;overload;
   function AutoLogin(AKey:string):IControllerLogin;overload;
end;


implementation

uses
  FMX.Dialogs;

{ TController }

function TControllerLogin.AutoLogin: IControllerLogin;
 var
 ini:TInifile;
 Agendar:TAgendar;
 Dao:IDao;
begin
Result:=Self;
 Agendar:=TAgendar.GetInstance;
 try
   Ini:=TIniFile.Create(GetHomePath + PathDelim +'login.ini');
   Agendar.Key.Name:= ini.ReadString('Login','Key','');
   if Agendar.Key.Name <>'' then
      begin
       Dao:=TFirebase.create;
       Dao.Refresh;
      end;
 finally
  ini.Free;
 end;
end;

function TControllerLogin.AutoLogin(AKey: string): IControllerLogin;
var
Ini:TInifile;
begin
Result:=Self;
 try
   Ini:=TIniFile.Create(GetHomePath + PathDelim +'login.ini');
   ini.WriteString('Login','Key',Akey);
 finally
   Ini.Free;
 end;
end;

function TControllerLogin.CreateSingleton: IControllerLogin;
var
Agendar:TAgendar;
begin
 Agendar.GetInstance;
end;

function TControllerLogin.doLogin(AUser, APassword:string): Boolean;
var
Agendar:TAgendar;
Dao:IDao;
begin
  //Dao:=TDao.create;
  Dao:=TFirebase.create;
  Dao.doLogin(AUSer,Apassword);
  Agendar:=TAgendar.GetInstance;

  try
     if (Auser = Agendar.Empresa.Login) And (APassword = Agendar.Empresa.Senha) And (Agendar.Empresa.Bloqued = false) then
     Result:=true
     else
     result:=false;
  finally
  end;
end;

function TControllerLogin.Execute(AUser, APassword: string): Iwork;
begin
  Result:=Self;
  if (Auser<>'') and (Apassword<>'') then
     begin
      if doLogin(AUser,APassword) = true then
          begin
           {$ifdef Android}
            Toast('Logado com sucesso!',LongToast);
           {$endif}
           {$ifdef Windows or IOS}
             Showmessage('Logado com sucesso!');
           {$endif}
             Application.CreateForm(TFrmCalendar, FrmCalendar);
             FrmCalendar.show;
          end else
               begin
                 {$ifdef Android}
                   Toast('Erro ao efetuar login, verifique seus dados e tente novamente',LongToast);
                 {$endif}
                 {$ifdef Windows or IOS or win32 or win64}
                   Showmessage('Erro ao efetuar login, verifique seus dados e tente novamente');
                 {$endif}

               end;
     end else
           begin
                {$ifdef Android}
                 Toast('Voc� precisa preenxer todos os campos!',LongToast);
                {$endif}
                {$ifdef Windows or IOS}
                 Showmessage('Voc� precisa preenxer todos os campos!');
                {$endif}

           end;

end;

function TControllerLogin.Execute: IWork;
begin

end;

function TControllerLogin.ReleaseInstance: IControllerLogin;
var
 Agendar:TAgendar;
begin
 Agendar.GetInstance.ReleaseInstance;
end;

end.
