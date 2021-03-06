unit UfrmHistorico;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UfrmBase, FMX.ListView.Types, FMX.ListView.Appearances, {$ifdef Android}AndroidApi.Jni.Toast,{$endif}
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.ListView, FMX.TabControl,
  FMX.Ani, FMX.ListBox, FMX.Layouts, FMX.MultiView, FMX.Controls.Presentation,
  System.ImageList, FMX.ImgList, System.Actions, FMX.ActnList;

type
  TFrmHistorico = class(TFrmBase)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Text3: TText;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    ListView1: TListView;
    TabItem2: TTabItem;
    ListView2: TListView;
    TabItem3: TTabItem;
    ListView3: TListView;
    Layout7: TLayout;
    Layout8: TLayout;
    Circle3: TCircle;
    Text5: TText;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    LayQuestion: TLayout;
    BgQuestion: TRectangle;
    LayCenterQuestion: TLayout;
    BgCenterQuestion: TRectangle;
    Layout3: TLayout;
    Layout4: TLayout;
    Image1: TImage;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Text2: TText;
    Text4: TText;
    Text6: TText;
    Rectangle5: TRectangle;
    Text7: TText;
    ChangeTabAction3: TChangeTabAction;
    SpeedButton1: TSpeedButton;
    ImageList2: TImageList;
    TabItem4: TTabItem;
    ListView4: TListView;
    Rectangle6: TRectangle;
    Text8: TText;
    ChangeTabAction4: TChangeTabAction;
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListarORcamentos;
    procedure ListView3ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHistorico: TFrmHistorico;
  NameClient:string;
  IndexClient:integer;
implementation
 uses
  Controller.FrmHistorico,UfrmCadastrarOrcamento;

{$R *.fmx}

procedure TFrmHistorico.FormActivate(Sender: TObject);
var
Ctrl:IController;
begin
  inherited;
 if TabControl1.ActiveTab = TabItem1 then
 begin
   Ctrl:=TController.Create;
   Ctrl.ListarClientes(Listview1,imagelist1);
 end;
 if TabControl1.ActiveTab = TabItem3 then
 begin
  ListarORcamentos;
 end;

end;

procedure TFrmHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
Action:=TCloseAction.caFree;
end;

procedure TFrmHistorico.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
if key=vkHardwareBack then
  begin
   Key:=0;
    if (TabControl1.ActiveTab = TabItem2) or (TabControl1.ActiveTab = TabItem3) or (TabControl1.ActiveTab = TabItem4) then
    begin
      Key:=0;
      ChangeTabAction2.ExecuteTarget(self);
    end else
          begin
           {$ifdef Android}Toast('Aguarde...',LongToast);{$endif}
           close;
          end;
  end;
end;

procedure TFrmHistorico.Image1Click(Sender: TObject);
begin
  inherited;
LayQuestion.Visible:=False;
end;

procedure TFrmHistorico.ListarORcamentos;
var
 Ctrl:IController;
begin
  inherited;
 try
   Ctrl:=TController.create;
   Ctrl.Listarorcamentos(Listview3,Imagelist1,NameClient);
 finally
  LayQuestion.Visible:=False;
  ChangeTabAction3.ExecuteTarget(self);
 end;

end;

procedure TFrmHistorico.ListView1ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
Ctrl:IController;
begin
   try
    Ctrl:=TController.Create;
    NameClient:= Listview1.Items[ItemIndex].Data['Nome'].AsString;
    IndexClient:=Itemindex;
    Ctrl.ClienteNome(NameClient);
    Text6.Text:=NameClient;
    LayQuestion.Visible:=true;

   finally

   end;

end;


procedure TFrmHistorico.ListView3ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
Ctrl:IController;
begin
  inherited;
  Ctrl:=TController.Create;
  Ctrl.ListarServicos(Listview4,ImageList2,IndexClient,ItemIndex);
  ChangeTabAction4.ExecuteTarget(self);
 if LocalClickPos.X>270   then
  begin
  Ctrl.DeletarOrcamento(Itemindex,IndexClient);
  ListarORcamentos;
  end;
end;

procedure TFrmHistorico.SpeedButton1Click(Sender: TObject);
begin
  ListarORcamentos;
end;

procedure TFrmHistorico.Text2Click(Sender: TObject);
var
 Ctrl:IController;
begin
  inherited;
 try
   Ctrl:=TController.create;
   Ctrl.ListarAgendamentos(Listview2,Imagelist1,NameClient);
 finally
  LayQuestion.Visible:=False;
  ChangeTabAction1.ExecuteTarget(self);
 end;

end;

procedure TFrmHistorico.Text4Click(Sender: TObject);
begin
ListarORcamentos;
end;

procedure TFrmHistorico.Text5Click(Sender: TObject);
begin
  inherited;
Application.CreateForm(TFrmCadastrarOrcamento, FrmCadastrarOrcamento);
FrmCadastrarOrcamento.show;
end;

end.
