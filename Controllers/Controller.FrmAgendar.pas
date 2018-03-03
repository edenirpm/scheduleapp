unit Controller.FrmAgendar;

interface
uses
 UWorks,UDao,
 Rest.Json,
 FMX.Forms,
 FMX.ListView,
 FMX.ImgList,
 model.servico,
 model.single,
 mode.agendamento,
 {$ifdef Android}
  UWhatsApp,AndroidApi.Jni.Toast,
 {$endif}
 model.marcacao,
 model.cliente,model.contato.agenda,
 model.agendar, FMX.TabControl, FMX.Objects;

Type
IController = interface
  ['{741A27B1-D95E-442C-B128-9954D58CE453}']
  function EscolherHora(Sender:TObject;AIndexFuncionario:integer;AChangeTabAction:TChangeTabAction):IWork;
  function ConsultarHorarios(Sender:TObject):IWork;
  function IndexFuncionario(AindexFuncionario:integer):integer;
  function GetIndexFuncionario:integer;
  function CreateMacacao:IController;
  function Agendar:IController;
  function CancelMarcacao:IController;
  function ListarClientes(AListview:TListview;AImageList:TImageList):IController;
  function ListarServicos(AListview:TListview;AImageList:TImageList):IController;
  function CancelarTodosAgendamentos(AindexFuncionario:integer):IController;
  function SolicitarTodasConfirmacoes(AindexFuncionario:integer):IController;
  function LiberarHorariosDesmarcados(AIndexFuncionario:integer):IController;
  function EscolherCliente(Nome,Celular:string):IWork;
  function EscolherServico(Nome:string):IController;
  function DetalhesDoAgendamento(Cliente,Telefone,Data,status,Servico:TText;Alistview:Tlistview):IWork;
  function ConfirmarAgendamento():IWork;
  function DesmarcarAgendamento():IWork;
  function ContatosDaAgenda:IController;
  procedure SendWhatsappConfirmation();
  procedure SendWhatsappAll();
  procedure DesmarcarTodos();


end;

TController = class(TInterfacedObject,IController,IWork)
  private
  FIndexFuncionario:integer;
  FMarcacao:TMarcacao;
  FIndexMarcacao:integer;
  public
    SingletonGeral:TSingle;
    function EscolherHora(Sender:TObject;AIndexFuncionario:integer;AChangeTabAction:TChangeTabAction):IWork;
    function ConsultarHorarios(Sender:TObject):IWork;
    constructor create;
    destructor destroy;override;
    function IndexFuncionario(AindexFuncionario:integer):integer;
    function GetIndexFuncionario:integer;
    function Agendar:IController;
    function CreateMacacao:IController;
    function CancelMarcacao:IController;
    function ListarClientes(AListview:TListview;AImageList:TImageList):IController;
    function ListarServicos(AListview:TListview;AImageList:TImageList):IController;
    function CancelarTodosAgendamentos(AindexFuncionario:integer):IController;
    function SolicitarTodasConfirmacoes(AindexFuncionario:integer):IController;
    function LiberarHorariosDesmarcados(AIndexFuncionario:integer):IController;
    function EscolherCliente(Nome,Celular:string):IWork;
    function EscolherServico(Nome:string):IController;
    function DetalhesDoAgendamento(Cliente,Telefone,Data,status,Servico:TText;Alistview:Tlistview):IWork;
    function Execute:IWork;
    function ConfirmarAgendamento():IWork;
    function DesmarcarAgendamento():IWork;
    function ContatosDaAgenda:IController;
     procedure SendWhatsappConfirmation();
     procedure SendWhatsappAll();
     procedure DesmarcarTodos();


end;

implementation

uses
  model.funcionario, UfrmAgendar,
  FMX.StdCtrls, System.UITypes, System.SysUtils, FMX.Dialogs;

{ TController }


function TController.Agendar: IController;
var
 Agendar:TAgendar;
 Dao:IDao;
 begin
 Agendar:=Tagendar.GetInstance;
 Agendar.Funcionarios.Items[GetIndexFuncionario].Agendamentos.Marcacoes.Add(Fmarcacao);
 Dao:=TDao.create;
 Dao.Update;
end;



function TController.CancelarTodosAgendamentos(
  AindexFuncionario: integer): IController;
begin

end;

function TController.CancelMarcacao: IController;
begin
Result:=Self;
FMarcacao.Free;
end;

function TController.ConfirmarAgendamento: IWork;
 var
 Agendar:TAgendar;
 AIndexFuncionario:integer;
 Marcacao:TMarcacao;
 Dao:IDao;
begin
 Result:= Self;

 Agendar:=TAgendar.GetInstance;
 AIndexFuncionario:=Agendar.IndexFuncionario;
 for Marcacao in Agendar.Funcionarios.Items[AIndexFuncionario].Agendamentos.Marcacoes do
 begin
  if marcacao = FMarcacao then
      begin
          try
           Marcacao.Status:='Confirmado';
          finally
           Fmarcacao.Status:='Confirmado';
          end;
      end;
  Dao:=TDao.create;
  Dao.Update;
 end;


end;

function TController.ConsultarHorarios(Sender: TObject):IWork;
var
 Agendar:TAgendar;
 Time:TTime;
 i:integer;
 Marcacao:TMarcacao;
 SelectedDate:TDate;
 AIndexFuncionario:integer;
begin
  Result:=Self;
   try
     Agendar:=TAgendar.GetInstance;
     AIndexFuncionario:=Agendar.IndexFuncionario;
     SelectedDate:=Agendar.DataSelecionada;
     for Marcacao in Agendar.Funcionarios.Items[AIndexFuncionario].Agendamentos.Marcacoes do
     begin
      if Marcacao.Data = SelectedDate then
          begin
           for i := 0 to Marcacao.Horas.Count -1 do
           begin
           // Showmessage(((Sender as Tlabel).Text+':00') + '  '+(timetostr(marcacao.Horas.Last)));
            if (Sender as Tlabel).Text+':00' =(timetostr(Marcacao.Horas.Items[i]) ) then
             begin
                if marcacao.Status = 'Confirmado' then
                 begin
                  ((Sender as TLabel).Parent as TRectangle).Fill.Color:= TAlphaColorRec.Yellowgreen;
                 end;
              if marcacao.Status = 'A Confirmar' then
                 begin
                 ((Sender as TLabel).Parent as TRectangle).Fill.Color:= TAlphaColorRec.Orange;
                 end;
              if marcacao.Status = 'Cancelado' then
                 begin
                  ((Sender as TLabel).Parent as TRectangle).Fill.Color:= TAlphaColorRec.Red;
                 end;
             end;


             {

              if marcacao.Horas.Contains(strtotime((Sender as TLabel).Text)) = true then
            begin
              if marcacao.Status = 'Confirmado' then
                 begin
                  ((Sender as TLabel).Parent as TRectangle).Fill.Color:= TAlphaColorRec.Yellowgreen;
                 end;
              if marcacao.Status = 'A Confirmar' then
                 begin
                 ((Sender as TLabel).Parent as TRectangle).Fill.Color:= TAlphaColorRec.Orange;
                 end;
              if marcacao.Status = 'Cancelado' then
                 begin
                  ((Sender as TLabel).Parent as TRectangle).Fill.Color:= TAlphaColorRec.Red;
                 end;
            end;       }
           end;


           
          end;
     end;

   finally

   end;
end;

function TController.ContatosDaAgenda: IController;
var
 Contato:IContatoAgenda;
begin
 Result:=Self;
 Contato:=TContatoAgenda.Create;
 Contato.CarregarContatos;
end;

constructor TController.create;
begin

end;

function TController.CreateMacacao: IController;
begin
Result:=Self;
FMarcacao:=TMarcacao.create;
end;

function TController.DesmarcarAgendamento: IWork;
 var
 Agendar:TAgendar;
 AIndexFuncionario:integer;
 Marcacao:TMarcacao;
 Dao:IDao;
 msg:string;
begin
 Result:= Self;
 Agendar:=TAgendar.GetInstance;
 AIndexFuncionario:=Agendar.IndexFuncionario;
 for Marcacao in Agendar.Funcionarios.Items[AIndexFuncionario].Agendamentos.Marcacoes do
 begin
  if marcacao = FMarcacao then
      begin
          try
           msg:='Prezado cliente seu agendamento de '+marcacao.Servico.Nome+' ' +FormatDatetime('dddd dd "de" mmmm "de" yyyy',marcacao.Data)+' foi cancelado.';
           Marcacao.Status:='Cancelado';
           {$ifdef Android}
             Twhatsapp.SendWhatsapp(Marcacao.Cliente.Telefone.Celular,msg);
           {$endif}
          finally
           Fmarcacao.Status:='Cancelado';
          end;
      end;
 end;
 Dao:=TDao.create;
 Dao.Update;

end;

procedure TController.DesmarcarTodos;
var
 Agendar:TAgendar;
 Marcacao:TMarcacao;
 msg:string;
begin
   Agendar:=TAgendar.GetInstance;
   for Marcacao in Agendar.Funcionarios.Items[Agendar.IndexFuncionario].Agendamentos.Marcacoes do
   begin
     if marcacao.Data = Agendar.GetInstance.DataSelecionada then
      begin
       if marcacao.Status <> 'Cancelado' then
        begin
           Marcacao.Status:='Cancelado';
           msg:='Prezado cliente seu agendamento de '+marcacao.Servico.Nome+' ' +FormatDatetime('dddd dd "de" mmmm "de" yyyy',marcacao.Data)+' foi cancelado.';
          {$ifdef android}
            TWhatsapp.SendWhatsapp(Marcacao.Cliente.Telefone.Celular,msg);
          {$endif}
        end;
      
      end;

     
   end;
   {$ifdef Android}
    Toast('Desmarcando todos agendamentos deste dia.',LongToast);
   {$endif}
end;

destructor TController.destroy;
begin

  inherited;
end;

function TController.DetalhesDoAgendamento(Cliente, Telefone, Data,
  status,Servico: TText; Alistview: Tlistview): IWork;
var
Hora:TTime;
Agendar:TAgendar;
begin
  Result:=Self;
  AListview.Items.Clear;
  Cliente.Text:=UpperCase(fmarcacao.Cliente.Nome);
  Telefone.Text:=fmarcacao.Cliente.Telefone.Celular;
  Data.Text:=FormatDatetime('dddd dd "de" mmmm "de" yyyy',fmarcacao.Data);
  status.Text:=fmarcacao.Status;
  Servico.text:=fmarcacao.Servico.Nome;
  Agendar:=TAgendar.GetInstance;
 //  showmessage(Agendar.Funcionarios.Items[Agendar.IndexFuncionario].Agendamentos.Marcacoes.IndexOf(Fmarcacao).ToString) ;
  FindexMarcacao:=Agendar.Funcionarios.Items[Agendar.IndexFuncionario].Agendamentos.Marcacoes.IndexOf(FMarcacao);
  for Hora in Fmarcacao.Horas do
  begin
   with Alistview.Items.Add do
   begin
     Data['Hora']:=TimeToStr(Hora);
   end;
  end;

end;

function TController.EscolherCliente(Nome,Celular:string): IWork;
begin
  Result:=Self;
  fmarcacao.Cliente.Nome:=Nome;
  fmarcacao.Cliente.Telefone.Celular:=Celular;
end;

Function TController.EscolherHora(Sender:TObject;AIndexFuncionario:integer;AChangeTabAction:TChangeTabAction):IWork;
var
 Agendar:TAgendar;
 Time:TTime;
 I:integer;
 Marcacao:TMarcacao;
 SelectedDate:TDate;
begin
 Result:=Self;
 Agendar:=TAgendar.GetInstance;
 AIndexFuncionario:=Agendar.IndexFuncionario;
 SelectedDate:=Agendar.DataSelecionada;

   if ((Sender as Tlabel).Parent as TRectangle).Fill.Color = TAlphaColorRec.Lightslategray then
        begin
          Fmarcacao.Data:=Agendar.DataSelecionada;
          Fmarcacao.Status:='A Confirmar';
          FMarcacao.Horas.Add(StrToTime((Sender as TLabel).Text));
          ((Sender as TLabel).Parent as TRectangle).Fill.Color:= TAlphaColorRec.Turquoise;
        exit;
        end;
   if ((Sender as Tlabel).Parent as TRectangle).Fill.Color = TAlphaColorRec.Turquoise then
      begin
       for Time in Fmarcacao.Horas do
          begin
            if Time = Strtotime((Sender as TLabel).Text) then
              begin
               Fmarcacao.Horas.Remove(Time);
               ((Sender as TLabel).Parent as TRectangle).Fill.Color:= TAlphaColorRec.Lightslategray;
              end;
          end;
       exit;
       end;

      if (((Sender as Tlabel).Parent as TRectangle).Fill.Color = TAlphaColorRec.Orange) or (((Sender as Tlabel).Parent as TRectangle).Fill.Color = TAlphaColorRec.Red) or (((Sender as Tlabel).Parent as TRectangle).Fill.Color = TAlphaColorRec.Yellowgreen) then
      begin
       begin

         for Marcacao in Agendar.Funcionarios.Items[AIndexFuncionario].Agendamentos.Marcacoes do
           begin
              if Marcacao.Data = SelectedDate then
                  begin
                   for i := 0 to Marcacao.Horas.Count -1 do
                   begin

                      if (Sender as Tlabel).Text+':00' =(timetostr(Marcacao.Horas.Items[i]) ) then
                       begin
                          if marcacao.Status = 'Confirmado' then
                           begin

                           FMarcacao:=Marcacao;

                           end;
                        if marcacao.Status = 'A Confirmar' then
                           begin
                          FMarcacao:=Marcacao;
                           end;
                        if marcacao.Status = 'Cancelado' then
                           begin
                            FMarcacao:=Marcacao;
                           end;
                       end;
                     end;
                  end;
             end;
       end;
       AChangeTabAction.ExecuteTarget(self);
       exit;
      end;

end;



function TController.EscolherServico(Nome:string): IController;
begin
 Fmarcacao.Servico.nome:=Nome;
end;

function TController.Execute: IWork;
begin

end;

function TController.GetIndexFuncionario: integer;
var
Agendar:TAgendar;
begin
 Agendar:=TAgendar.GetInstance;
 Result:= Agendar.IndexFuncionario;
end;

function TController.IndexFuncionario(AindexFuncionario: integer): integer;
begin
FIndexFuncionario:=AindexFuncionario;
Result:=FIndexFuncionario;
end;

function TController.LiberarHorariosDesmarcados(
  AIndexFuncionario: integer): IController;
begin

end;

function TController.ListarClientes(AListview: TListview;
  AImageList: TImageList): IController;
var
Agendar:TAgendar;
Cliente:TCliente;
begin
Result:=Self;
Agendar:=TAgendar.GetInstance;
 for Cliente in Agendar.GetInstance.Clientes do
 begin

 end;
end;

function TController.ListarServicos(AListview: TListview;
  AImageList: TImageList): IController;
var
Agendar:TAgendar;
Servico:TServico;
begin
 Result:=self;
 Agendar:=TAgendar.GetInstance;
 for Servico in Agendar.Servicos do
 begin

 end;
end;

procedure TController.SendWhatsappAll;
 var
 Agendar:TAgendar;
 msg:string;
 Marcacao:TMarcacao;
begin
 Agendar:=TAgendar.GetInstance;
 for Marcacao in Agendar.Funcionarios.Items[Agendar.IndexFuncionario].Agendamentos.Marcacoes do
 begin
   if marcacao.Data = Agendar.DataSelecionada then
   begin
        if marcacao.Status = 'A Confirmar' then
      begin
      msg:='Prazado cliente, você tem um agendamento '+ FormatDatetime('dddd dd "de" mmmm "de" yyyy',marcacao.Data) + ' às ' + timetostr(marcacao.Horas.First) +' na '+ Agendar.Empresa.Nome +
       ' Clique neste link para confirmar ou cancelar a sua presença ' +'http://zz3.com.br/agendamento/?emp='+ Agendar.Empresa.Nome +'&fun='+ inttostr(Agendar.IndexFuncionario)+'&mar='+inttostr(Agendar.Funcionarios.Items[Agendar.IndexFuncionario].Agendamentos.Marcacoes.IndexOf(Marcacao));
      {$ifdef Android}
       TWhatsApp.SendWhatsapp(marcacao.Cliente.Telefone.Celular,msg);
      {$endif}
      end;
   end;


 end;
 {$ifdef android}
  Toast('Solicitando confirmações',LongToast);
 {$endif}
end;

procedure TController.SendWhatsappConfirmation();
 var
  msg:string;
  Agendar:TAgendar;
begin
 try
   Agendar:=TAgendar.GetInstance;
   msg:='Prazado cliente, você tem um agendamento '+ FormatDatetime('dddd dd "de" mmmm "de" yyyy',fmarcacao.Data) + ' de ' + fmarcacao.Servico.Nome +
   ' Clique neste link para confirmar ou cancelar a sua presença ' +'http://zz3.com.br/agendamento/?emp='+ Agendar.Empresa.Nome +'&fun='+ inttostr(FIndexFuncionario)+'&mar='+inttostr(FIndexMarcacao);
 finally
   {$ifdef Android}
    Twhatsapp.SendWhatsapp(FMarcacao.Cliente.Telefone.Celular,msg);
   {$endif}
 end;
end;

function TController.SolicitarTodasConfirmacoes(
  AindexFuncionario: integer): IController;
begin

end;

end.
