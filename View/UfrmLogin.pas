unit UfrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts,UFrmCadastro,
  model.agendar,ufrmCalendar, {$ifdef Android}Androidapi.JNI.Toast,{$endif}
  UControllers,Controller.FrmLogin, FMX.Ani,uworks,System.Threading;

type
  TFrmLogin = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    Layout2: TLayout;
    Layout3: TLayout;
    Text1: TText;
    Layout9: TLayout;
    Rectangle1: TRectangle;
    Layout10: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    Edit1: TEdit;
    Layout8: TLayout;
    Edit2: TEdit;
    Layout11: TLayout;
    Text2: TText;
    Text3: TText;
    Rectangle2: TRectangle;
    Text4: TText;
    StyleBook1: TStyleBook;
    Image2: TImage;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    Text5: TText;
    Text6: TText;
    LayLoad: TLayout;
    BGLoad: TRectangle;
    Arc1: TArc;
    FloatLoad: TFloatAnimation;
    TextLoad: TText;
    procedure Text2Click(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    function doLogin:boolean;
    procedure Text4Click(Sender: TObject);
    procedure ExecuteWork(AWork:IWork);
  private

    { Private declarations }
  public

    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;
implementation

{$R *.fmx}

function TFrmLogin.doLogin:boolean;
var
 ctrl:IControllerLogin;
begin
  try
   Ctrl:=TControllerLogin.Create;
   Result:=Ctrl.doLogin(LowerCase(edit1.Text),lowercase(edit2.Text));
  Except
  end;
end;

procedure TFrmLogin.ExecuteWork(AWork: IWork);
 var
 Task:TThread;
begin
{$ifdef Android or IOS}

Task:=TThread.CreateAnonymousThread(procedure
                                      begin

                                       AWork.execute;
                                       Task.Synchronize(Task,procedure
                                                              begin
                                                              self.LayLoad.Visible:=False;
                                                              Self.FloatLoad.Enabled:=False;
                                                              end);
                                      end);
 Task.Start;

 {$endif}
  {$ifdef Win32 or Win or Win64 or Windows64 or Windows32}
   AWork.Execute;
   self.LayLoad.Visible:=False;
   Self.FloatLoad.Enabled:=False;
  {$endif}
end;

procedure TFrmLogin.Text2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastro, FrmCadastro);
  FrmCadastro.show;
end;

procedure TFrmLogin.Text4Click(Sender: TObject);
var
 Ctrl:IControllerLogin;
 Task:ITask;
begin
{$ifdef Android}
Toast('Verificando Login',LongToast);
{$endif}
   Ctrl:=TControllerlogin.Create;
   Self.ExecuteWork(Ctrl.Execute(LowerCase(edit1.Text),LowerCase(edit2.Text)));
end;

procedure TFrmLogin.Text5Click(Sender: TObject);
var
Controller:IController;
begin
 Controller:=TController.Create;
 Controller.EfectTextToUp(Sender);
end;
//initialization
//ReportMemoryLeaksOnShutdown:=true;
end.
