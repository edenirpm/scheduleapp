unit UfrmControleCadastros;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UfrmBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, System.ImageList, FMX.ImgList, FMX.ListView,
  FMX.Objects, FMX.TabControl, FMX.Ani, FMX.ListBox, FMX.Layouts, FMX.MultiView,
  FMX.Controls.Presentation,UControllerCadastros;

type
  TFrmControleCadastros = class(TFrmBase)
    Layout1: TLayout;
    Layout2: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Layout3: TLayout;
    Layout4: TLayout;
    Circle1: TCircle;
    Text2: TText;
    Rectangle1: TRectangle;
    Text3: TText;
    ListView1: TListView;
    ListView2: TListView;
    Layout5: TLayout;
    Layout6: TLayout;
    Circle2: TCircle;
    Text4: TText;
    ListView3: TListView;
    Layout7: TLayout;
    Layout8: TLayout;
    Circle3: TCircle;
    Text5: TText;
    Rectangle2: TRectangle;
    ImageList1: TImageList;
    procedure ListView2ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure ListView3ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure Text2Click(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
   procedure CarregarCadastros;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmControleCadastros: TFrmControleCadastros;

implementation

{$R *.fmx}

{ TFrmControleCadastros }

procedure TFrmControleCadastros.CarregarCadastros;
var
 Cadastro:ICadastros;
begin
 Cadastro:=TControllerCadastros.Create;
 Cadastro.ListarClientes(Listview1,Imagelist1);
 Cadastro.ListarFuncionarios(Listview2,imagelist1);
 Cadastro.ListarServicos(Listview3,imagelist1);
 //Cadastro.update;
end;

procedure TFrmControleCadastros.FormActivate(Sender: TObject);
begin
  inherited;
CarregarCadastros;
end;

procedure TFrmControleCadastros.FormClose(Sender: TObject;
  var Action: TCloseAction);
 var
 Cadastro:ICadastros;
begin
 Cadastro:=TControllerCadastros.Create;
 Cadastro.update;
 action:=TCloseAction.caFree;
end;

procedure TFrmControleCadastros.ListView1ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
Ctrl:ICadastros;
begin
inherited;
Ctrl:=TControllerCadastros.Create;
   if LocalClickPos.X>270   then
  begin
  Ctrl.DeletarCliente(ItemIndex);
  CarregarCadastros;
  end;
end;

procedure TFrmControleCadastros.ListView2ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
Ctrl:ICadastros;
begin
  inherited;
 Ctrl:=TControllerCadastros.Create;
  //  showmessage(LocalClickPos.X.ToString);
 if LocalClickPos.X>270   then
  begin
  ctrl.DeleteFuncionario(ItemIndex);
  CarregarCadastros;
  end;

end;

procedure TFrmControleCadastros.ListView3ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
Ctrl:ICadastros;
begin
inherited;
Ctrl:=TControllerCadastros.Create;
   if LocalClickPos.X>270   then
  begin
  Ctrl.DeleteServico(ItemIndex);
  CarregarCadastros;
  end;
end;

procedure TFrmControleCadastros.Text2Click(Sender: TObject);
var
 Ctrl:ICadastros;
begin
  inherited;
  Ctrl:=TControllerCadastros.create;
  Ctrl.showClients;
end;

procedure TFrmControleCadastros.Text4Click(Sender: TObject);
var
 Ctrl:ICadastros;
begin
  inherited;
  Ctrl:=TControllerCadastros.create;
  Ctrl.showfuncionarios;
end;

procedure TFrmControleCadastros.Text5Click(Sender: TObject);
var
 Ctrl:ICadastros;
begin
  inherited;
  Ctrl:=TControllerCadastros.create;
  Ctrl.showservicos;
end;

end.
