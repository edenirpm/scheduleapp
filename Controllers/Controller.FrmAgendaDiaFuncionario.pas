unit Controller.FrmAgendaDiaFuncionario;

interface
uses
 model.agendar,model.funcionario,System.threading, {$ifdef Android}Androidapi.JNi.Toast,{$endif}FMX.ListView,FMX.ImgList,udao;
Type
IController = interface
['{86ADA9C9-B7C3-4554-B361-A22ECEE0275B}']
procedure ShowForm;
function ListarFuncionarios(AListView:TListview;AImageList:TImageList):IController;
function EscolherFuncionario(AIndex:integer):TFuncionario;
function DataSelecionada:Tdate;
end;

TController = class(TInterfacedObject,IController)
procedure ShowForm;
function ListarFuncionarios(AListView:TListview;AImageList:TImageList):IController;
function EscolherFuncionario(AIndex:integer):TFuncionario;
function DataSelecionada:Tdate;
end;

implementation
uses
 UfrmAgendar, FMX.Forms;
{ TController }

function TController.DataSelecionada:Tdate;
var
 Agendar:Tagendar;
begin
 Agendar:=TAgendar.GetInstance;
 Result:= Agendar.DataSelecionada;
end;

function TController.EscolherFuncionario(AIndex:integer): TFuncionario;
var
 Agendar:TAgendar;
 Task:ITask;
begin
  {$ifdef Android}
    Toast('Carregando horários...', LongToast);
  {$endif}
  try
     agendar:=TAgendar.GetInstance;
     agendar.IndexFuncionario:=Aindex;
     Task:=TTask.create(procedure
      var
       Dao:IDao;
     begin
        Dao:=TFirebase.create;
        //Dao:=TDao.create;
        Dao.Refresh;
      end);
     Task.start;

  finally
      Result:=Agendar.Funcionarios[Aindex];
  end;

end;

function TController.ListarFuncionarios(AListView: TListview;AImageList:TImageList): IController;
begin
 TTask.Run(procedure
 var
 Agendar:TAgendar;
 Funcionario:TFuncionario;
 begin
  Agendar:=TAgendar.GetInstance;
  AListview.Items.Clear;
   for Funcionario  in Agendar.Funcionarios do
        begin
         with AListview.Items.Add do
          begin
           Data['Nome']:=Funcionario.Cordialidade +' '+ Funcionario.Nome;
           if (Funcionario.Cordialidade ='Sra.') or (Funcionario.Cordialidade='Dra.') then
              begin
               Data['Foto']:= AImagelist.Source[1].ID;
              end else
                   begin
                   Data['Foto']:= AImagelist.Source[0].ID;
                   end;
          end;
        end;

    end);

end;

procedure TController.ShowForm;
begin
  Application.CreateForm(TFrmAgendar, FrmAgendar);
  FrmAgendar.show;
end;

end.
