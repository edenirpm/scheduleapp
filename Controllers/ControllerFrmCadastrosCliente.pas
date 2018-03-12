unit ControllerFrmCadastrosCliente;

interface
uses
Fmx.Listview,
System.Imagelist,
Fmx.ImgList,
Udao,
UfrmCadClientes,
Fmx.Forms,
model.agendar,
model.cliente;
Type
IControllerClientes = interface
 function NewClient():IControllerClientes;
 function Listar(AListview:TListview;AImageList:TImageList):IControllerClientes;
 function Update():IControllerClientes;
 function Remove():IControllerClientes;
end;
TControllerClientes = class(TInterfacedObject,IControllerClientes)
  public
    function Listar(AListview: TListView;
      AImageList: TImageList): IControllerClientes;
    function NewClient: IControllerClientes;
    function Remove: IControllerClientes;
    function Update: IControllerClientes;
end;

implementation

{ TControllerClientes }

function TControllerClientes.Listar(AListview: TListView;
  AImageList: TImageList): IControllerClientes;
 var
 Agendar:TAgendar;
 Cliente:TCliente;
begin
 Agendar:=TAgendar.GetInstance;
 AListview.Items.Clear;
 for Cliente in Agendar.Clientes do
 begin
   With AListview.Items.Add do
    begin
    Data['Title']:= Cliente.Nome;
    Data['SubTitle']:=Cliente.Telefone;
    Data['Foto']:=AImageList.Source[0].ID;
    Data['ImgDeletar']:=AImageList.Source[2].ID;
    Data['ImgAgendamentos']:=AImageList.Source[3].ID;
    end;
 end;


end;

function TControllerClientes.NewClient: IControllerClientes;
begin
 Application.CreateForm(TFrmCadClientes, FrmCadClientes);
 FrmCadClientes.Show;
end;

function TControllerClientes.Remove: IControllerClientes;
begin

end;

function TControllerClientes.Update: IControllerClientes;
begin

end;

end.
