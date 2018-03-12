unit UfrmCadastrosCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UfrmCadastrosBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, System.ImageList, FMX.ImgList, FMX.Ani,
  FMX.Objects, FMX.MultiView, FMX.ListView, FMX.TabControl,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox;

type
  TFrmCadastrosCliente = class(TFrmCadastrosBase)
    procedure TextPlusClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
  procedure CadastrarCliente;
  procedure ListarClientes;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastrosCliente: TFrmCadastrosCliente;

implementation
 uses
  ControllerFrmCadastrosCliente;
{$R *.fmx}

procedure TFrmCadastrosCliente.CadastrarCliente;
var
 Ctrl:IControllerClientes;
begin
 Ctrl:=TControllerClientes.Create;
 Ctrl.NewClient;
end;

procedure TFrmCadastrosCliente.FormActivate(Sender: TObject);
begin
  inherited;
ListarClientes;
end;

procedure TFrmCadastrosCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
Action:=TCloseAction.caFree;
end;

procedure TFrmCadastrosCliente.ListarClientes;
var
 Ctrl:IControllerClientes;
begin
 Ctrl:=TcontrollerClientes.Create;
 Ctrl.Listar(Listview1,Imagelist1);
end;

procedure TFrmCadastrosCliente.TextPlusClick(Sender: TObject);
begin
  inherited;
CadastrarCliente;
end;

end.
