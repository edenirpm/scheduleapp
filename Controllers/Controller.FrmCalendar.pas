unit Controller.FrmCalendar;

interface

uses
 model.agendar,model.funcionario,{$ifdef Android}Androidapi.jni.toast,{$endif}model.marcacao,uworks, 
  FMX.TMSCalendar;

Type
IController = interface
  ['{B028A05A-F069-44FB-9281-75B3264B24E5}']
  procedure ShowForm;
  function Agendar(ADate:TDate):IWork;
  function CreateAgendar:IController;
  function CriarFuncionariosFicticios:IController;
  function UpdateCalendar(ATmsCalendar:TTMSFMXCalendar):IController;
end;

TController = class (TInterfacedObject,IController,IWork)
 FAgenda:TAgendar;
 procedure ShowForm;
 function Agendar(ADate:TDate):IWork;
 function CreateAgendar:IController;
 function CriarFuncionariosFicticios:IController;
 function Execute:IWork;
 function UpdateCalendar(ATmsCalendar:TTMSFMXCalendar):IController;
end;

implementation

uses
  FMX.Forms,UfrmAgendaDiaFuncionario, System.SysUtils, FMX.Dialogs,Udao;

{ TController }

function TController.Agendar(ADate: TDate):IWork;
var
 Agendar:TAgendar;
begin
 Result:=Self;
 {$ifdef Android}
  Toast('Aguardando o carregamento....');
 {$endif}
 Agendar:=TAgendar.GetInstance;
 Agendar.DataSelecionada:=ADate;
 end;

function TController.CreateAgendar: IController;
begin
Result:=self;
FAgenda:=TAgendar.GetInstance;
end;


function TController.CriarFuncionariosFicticios: IController;
var
 Funcionario1,Funcionario2:TFuncionario;

begin
  CreateAgendar;
 if FAgenda.Funcionarios.Count <=0 then
 begin
    try
     Funcionario1:=TFuncionario.create;
     Funcionario1.Cordialidade:='Sr.';
     Funcionario1.Nome:='Edenir P. Martins';
     Funcionario2:=TFuncionario.create;
     Funcionario2.Cordialidade:='Sra.';
     Funcionario2.Nome:='Carmen C. Balbino';
    finally
    FAgenda.Funcionarios.Add(Funcionario1);
    FAgenda.Funcionarios.Add(Funcionario2);
    end;
 end;

    //Fagenda.Funcionarios.Items[0].Agendamentos.Marcacoes.items[0].Servico.Nome:='Consulta';
   //FAgenda.Funcionarios.Items[0].Agendamentos.Marcacoes.items[0].Status:='Confirmado';
  //Fagenda.Funcionarios.Items[0].Agendamentos.Marcacoes.items[0].Cliente.Nome;
 //Fagenda.Funcionarios.Items[0].Agendamentos.Marcacoes.Items[0].Data:=now;
// Fagenda.Funcionarios.Items[0].Agendamentos.Marcacoes.Items[0].Horas.Add(ATtime);
end;

function TController.Execute: IWork;
begin

end;

procedure TController.ShowForm;
begin
  Application.CreateForm(TFrmAgendaDiaFuncionario, FrmAgendaDiaFuncionario);
  FrmAgendaDiaFuncionario.show;
end;


function TController.UpdateCalendar(ATmsCalendar:TTMSFMXCalendar): IController;
var
 Marcacao:TMarcacao;
 Agendar:TAgendar;
 Funcionario:TFuncionario;
 eventCalendar:TTMSFMXCalendarEvent;
 Data:TDate;
begin

 Agendar:=TAgendar.GetInstance;
  try
    for Funcionario in Agendar.Funcionarios do
   begin
    for Marcacao in funcionario.Agendamentos.Marcacoes do
    begin
     if Agendar.Datas.Contains(Marcacao.Data) = false then
          begin 
           Agendar.Datas.Add(Marcacao.Data);
          end;
    end;
   end;
  finally
    for Data in Agendar.Datas do
    begin
      eventCalendar:=ATmsCalendar.Events.Add;
      eventCalendar.Date:=Data;
      eventCalendar.Text:='Possui agendamento';
      eventCalendar.Kind:=ekEllipse;
    end;
  end;
  
end;

end.
