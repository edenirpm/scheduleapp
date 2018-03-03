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
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure Text2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHistorico: TFrmHistorico;
  NameClient:string;
implementation
 uses
  Controller.FrmHistorico;

{$R *.fmx}

procedure TFrmHistorico.FormActivate(Sender: TObject);
var
Ctrl:IController;
begin
  inherited;
 Ctrl:=TController.Create;
 Ctrl.ListarClientes(Listview1,imagelist1);
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
    if TabControl1.ActiveTab = TabItem2 then
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

procedure TFrmHistorico.ListView1ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
   NameClient:= Listview1.Items[ItemIndex].Data['Nome'].AsString;
   Text6.Text:=NameClient;
   LayQuestion.Visible:=true;
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

end.