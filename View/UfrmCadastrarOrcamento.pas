unit UfrmCadastrarOrcamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UfrmCadastrosBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, System.ImageList, FMX.ImgList, FMX.Ani,
  FMX.Objects, FMX.ListBox, FMX.Layouts, FMX.MultiView, FMX.ListView,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Effects, FMX.Edit,Ucontrollers,Controller.FrmOrcamentos;

type
  TFrmCadastrarOrcamento = class(TFrmCadastrosBase)
    LayouConteudo: TLayout;
    RecData: TRectangle;
    RectTotal: TRectangle;
    Text2: TText;
    TextData: TText;
    RecTitleProcedimentos: TRectangle;
    LayListview: TLayout;
    ListView1: TListView;
    Layout1: TLayout;
    Layout2: TLayout;
    Circle1: TCircle;
    Text3: TText;
    TextDica: TText;
    Text4: TText;
    LaySalvar: TLayout;
    ImageSalvar: TImage;
    LayCancelar: TLayout;
    ImageCancelar: TImage;
    Text5: TText;
    LayServicos: TLayout;
    BgServicos: TRectangle;
    LayCenterServicos: TLayout;
    BGCadServico: TRectangle;
    Layout3: TLayout;
    Image1: TImage;
    Image2: TImage;
    Text6: TText;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Edit1: TEdit;
    Edit2: TEdit;
    Text7: TText;
    Text8: TText;
    GlowEffect1: TGlowEffect;
    ImageList1: TImageList;
    procedure CadastrarServico(Sender:TObject);
    procedure CancelarServico(Sender:TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Text7Click(Sender: TObject);
    procedure Efeito(Sender:TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AddServicos(Sender:TObject);
    procedure ResetControls;
    procedure ListarServicos;
    procedure FormActivate(Sender: TObject);
    procedure ImageSalvarClick(Sender: TObject);
    procedure ImageCancelarClick(Sender: TObject);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
  private
    { Private declarations }
  public
  var
  Ctrl:TControllerOrcamento;
  Destruir:Boolean;
    { Public declarations }
  end;

var
  FrmCadastrarOrcamento: TFrmCadastrarOrcamento;

implementation

{$R *.fmx}

{ TFrmCadastrarOrcamento }

procedure TFrmCadastrarOrcamento.AddServicos(Sender: TObject);
begin
 Ctrl.AddServicosOrcamento(Edit1.Text,StrToCurr(edit2.Text));
 ResetControls;
 ListarServicos;
end;

procedure TFrmCadastrarOrcamento.CadastrarServico(Sender:TObject);
begin
LayServicos.Visible:=true;
end;

procedure TFrmCadastrarOrcamento.CancelarServico(Sender:TObject);
begin
 ResetControls;
end;

procedure TFrmCadastrarOrcamento.Efeito(Sender: TObject);
var
Controller:IController;
begin
  inherited;
   Controller:=TController.Create;
   Controller.EfectTextToUp(Sender);
end;

procedure TFrmCadastrarOrcamento.FormActivate(Sender: TObject);
begin
  inherited;
ListarServicos;

end;

procedure TFrmCadastrarOrcamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 try
  Action:=TCloseAction.caFree;
 Except

 end;

end;

procedure TFrmCadastrarOrcamento.FormCreate(Sender: TObject);
begin
  inherited;
Ctrl:= TControllerOrcamento.Create;
Destruir:=true;
end;

procedure TFrmCadastrarOrcamento.FormDestroy(Sender: TObject);
begin
 try
    if Destruir = true then
      begin
        Ctrl.Free;
        end else
              begin
               inherited;
              end;
 Except

 end;

end;

procedure TFrmCadastrarOrcamento.ImageCancelarClick(Sender: TObject);
begin
  inherited;
Destruir:=true;
close;
end;

procedure TFrmCadastrarOrcamento.ImageSalvarClick(Sender: TObject);
begin
  inherited;
Destruir:=False;
ctrl.AddOrcamento;
close;
end;

procedure TFrmCadastrarOrcamento.ListarServicos;
begin
Text5.Text:=Ctrl.ClienteName;
Ctrl.ListarProcedimentos(Self.Listview1,Self.imageList1);
text2.Text:= FormatCurr('R$ ###,##0.00', Ctrl.Forcamento.valor);
end;

procedure TFrmCadastrarOrcamento.ListView1ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  inherited;
 if LocalClickPos.X>270   then
  begin
  Ctrl.RemoveServicosOrcamento(ItemIndex);
  ListarServicos;
  end;
end;

procedure TFrmCadastrarOrcamento.ResetControls;
begin
 edit1.Text:='';
 edit2.Text:='';
 LayServicos.Visible:=false;
end;

procedure TFrmCadastrarOrcamento.Text7Click(Sender: TObject);
var
Controller:IController;
begin
  inherited;
   Controller:=TController.Create;
   Controller.EfectTextToUp(Sender);
end;

end.
