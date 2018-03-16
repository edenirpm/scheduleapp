unit UfrmCadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UfrmBase, FMX.MultiView, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  FMX.Edit, FMX.TabControl, FMX.ListBox, FMX.Ani, System.Actions, FMX.ActnList,
  FMX.Gestures, FMX.ListView.Types, FMX.ListView.Appearances,UWorks,
  FMX.ListView.Adapters.Base, FMX.ListView,model.contato.agenda,{$ifdef Android}Androidapi.JNI.Toast,{$endif}
  UControllers, System.ImageList, FMX.ImgList,UControllerCadastros;

type
  TFrmCadastro = class(TFrmBase)
    LayTabControl: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Layout1: TLayout;
    Layout3: TLayout;
    Edit1: TEdit;
    Layout4: TLayout;
    Layout6: TLayout;
    GridPanelLayout2: TGridPanelLayout;
    Layout10: TLayout;
    Layout12: TLayout;
    GridPanelLayout4: TGridPanelLayout;
    Layout2: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    Layout5: TLayout;
    GridPanelLayout3: TGridPanelLayout;
    RoundRect1: TRoundRect;
    Text2: TText;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    StyleBook1: TStyleBook;
    Text3: TText;
    Layout7: TLayout;
    Edit2: TEdit;
    Text4: TText;
    Layout8: TLayout;
    Edit3: TEdit;
    Text5: TText;
    Layout9: TLayout;
    Edit5: TEdit;
    Text6: TText;
    Layout11: TLayout;
    Edit6: TEdit;
    Text7: TText;
    Layout13: TLayout;
    Edit4: TEdit;
    Text8: TText;
    Layout14: TLayout;
    Edit7: TEdit;
    Text9: TText;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    PreviousTabAction1: TPreviousTabAction;
    GestureManager1: TGestureManager;
    NextTabAction1: TNextTabAction;
    ListView1: TListView;
    Layout15: TLayout;
    Layout16: TLayout;
    Text10: TText;
    Circle1: TCircle;
    Text11: TText;
    FloatAnimation1: TFloatAnimation;
    Layout17: TLayout;
    Rectangle1: TRectangle;
    Text12: TText;
    Layout18: TLayout;
    Layout19: TLayout;
    Circle2: TCircle;
    Text13: TText;
    Text14: TText;
    Layout20: TLayout;
    ListView2: TListView;
    Layout21: TLayout;
    Layout22: TLayout;
    Circle3: TCircle;
    Text15: TText;
    FloatAnimation2: TFloatAnimation;
    Text16: TText;
    Rectangle2: TRectangle;
    Text17: TText;
    Layout23: TLayout;
    Layout24: TLayout;
    Circle4: TCircle;
    Text18: TText;
    Text19: TText;
    Layout25: TLayout;
    Layout26: TLayout;
    Layout27: TLayout;
    Layout28: TLayout;
    Edit8: TEdit;
    Text20: TText;
    Layout29: TLayout;
    Layout30: TLayout;
    Edit9: TEdit;
    Text21: TText;
    RoundRect2: TRoundRect;
    Text22: TText;
    Text23: TText;
    Rectangle3: TRectangle;
    ImageList1: TImageList;
    VertScrollBox1: TVertScrollBox;
    Rectangle4: TRectangle;
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure Text3Click(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure Text13Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Text11Click(Sender: TObject);
    procedure Text15Click(Sender: TObject);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure ListView2ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure Text22Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    procedure CarregarListviews;
    procedure ConfigurarTela;
    procedure CadastrarFuncionario;
    procedure CadastrarServico;
    procedure Cadastrar;

    { Private declarations }
  public

    { Public declarations }
  end;

var
  FrmCadastro: TFrmCadastro;

implementation

uses
  UfrmCadFuncionario, UfrmCadServico;

{$R *.fmx}

{ TFrmCadastro }

procedure TFrmCadastro.Cadastrar;
var
 Ctrl:ICadastros;
begin

  Try
    Ctrl:=TControllerCadastros.Create;
    Ctrl.CadastrarEmpresa(edit1.text,edit2.Text,edit3.Text,edit5.Text,edit6.Text,combobox1.Selected.Text,combobox2.Selected.Text,edit7.Text,edit4.Text,edit9.Text,edit8.Text);

  Finally
    {$ifdef Android}
     Toast('Cadastro efetuado com sucesso!',LongToast);
    {$endif}
    {$ifdef Windows or win32 or win64}
    Showmessage('Cadastro efetuado com sucesso!');
    {$endif}
    {$ifdef IOS}
    {$endif}
    close;
  End;
 
end;

procedure TFrmCadastro.CadastrarFuncionario;
begin
Application.CreateForm(TFrmCadFuncionario, FrmCadFuncionario);
frmCadFuncionario.show;
end;

procedure TFrmCadastro.CadastrarServico;
begin
Application.CreateForm(TFrmCadServico, FrmCadServico);
FrmCadServico.show;
end;

procedure TFrmCadastro.CarregarListviews;
var
ctrl:ICadastros;
begin
// Listview1.Items.Clear;
// Listview2.Items.Clear;
Ctrl:=TControllerCadastros.Create;
Ctrl.ListarServicos(Listview2,Imagelist1).ListarFuncionarios(Listview1,Imagelist1);
 { for Servico in Single.GetInstance.Servicos do
  begin
      with Listview2.Items.Add do
    begin
     Data['Nome']:= Servico.Nome;
     Data['Valor']:= Servico.Valor;
     Data['Foto']:=imagelist1.Source[1].ID;
     Data['Lixo']:=imagelist1.Source[2].ID;
    end;
  end;
  for Funcionario in Single.GetInstance.Funcionarios do
  begin
    with Listview1.Items.Add do
    begin
     Data['Foto']:=imagelist1.Source[0].ID;
     Data['Lixo']:=imagelist1.Source[2].ID;
     Data['Cord']:= Funcionario.Cordialidade;
     Data['Nome']:= Funcionario.Nome;
     Data['Login']:= Funcionario.Login;
     Data['Senha']:= Funcionario.Senha;
    end;
  end; }
end;

procedure TFrmCadastro.ConfigurarTela;
var
Ctrl:ICadastros;
begin
 Ctrl:=TControllerCadastros.Create;

 if ctrl.CountFuncionarios > 0 then
 begin
   FloatAnimation1.Enabled:=false;
   Layout18.Visible:=True;
  // Text10.Visible:=false;
 end else
        begin
         Layout18.Visible:=False;
         FloatAnimation1.Enabled:=True;
         Text10.Visible:=true;
        end;
 if Ctrl.CountServicos > 0 then
 begin
   FloatAnimation1.Enabled:=false;
   Layout23.Visible:=true;
  // Text16.Visible:=false;
 end else
        begin
         Layout23.Visible:=False;
         FloatAnimation2.Enabled:=True;
         Text16.Visible:=True;
        end;
end;


procedure TFrmCadastro.FloatAnimation1Finish(Sender: TObject);
begin
  inherited;

edit1.SetFocus;
end;

procedure TFrmCadastro.FormActivate(Sender: TObject);
begin
  inherited;
ConfigurarTela;
CarregarListviews;
end;

procedure TFrmCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
Action:=TCloseAction.caFree;
end;

procedure TFrmCadastro.ListView1ItemClickEx(const Sender: TObject;
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
  CarregarListviews;
  ConfigurarTela;
  end;

end;

procedure TFrmCadastro.ListView2ItemClickEx(const Sender: TObject;
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
  CarregarListviews;
  ConfigurarTela;
  end;
end;



procedure TFrmCadastro.Text11Click(Sender: TObject);
begin
  inherited;
CadastrarFuncionario;
end;

procedure TFrmCadastro.Text13Click(Sender: TObject);
begin
  inherited;
NextTabAction1.ExecuteTarget(self);
end;

procedure TFrmCadastro.Text15Click(Sender: TObject);
begin
  inherited;
CadastrarServico;
end;

procedure TFrmCadastro.Text22Click(Sender: TObject);
begin
  inherited;

Cadastrar;
end;

procedure TFrmCadastro.Text2Click(Sender: TObject);
var
 ImportarAgenda:IContatoAgenda;
 begin
  inherited;
 try
  ImportarAgenda:=TContatoAgenda.Create;
  {$ifdef Android or IOS}
   ExecuteWork(ImportarAgenda.Execute);
  {$endif}
 finally
  NextTabAction1.ExecuteTarget(self);
 end;

end;

procedure TFrmCadastro.Text3Click(Sender: TObject);
var
 Efect:IController;
begin
  inherited;
   try
    Efect:=TController.Create;
    Efect.EfectTextToUp(Sender);
   Except

   end;

end;



end.

