unit UfrmAgendaDiaFuncionario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UfrmBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, Data.Bind.GenData, Fmx.Bind.GenData, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope, FMX.ListView,
  FMX.MultiView, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  System.ImageList, FMX.ImgList,{$ifdef android}AndroidApi.Jni.Toast,{$endif} FMX.Ani,
  FMX.ListBox;

type
  TFrmAgendaDiaFuncionario = class(TFrmBase)
    LayGeral: TLayout;
    Image1: TImage;
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    StyleBook1: TStyleBook;
    LayInformationTop: TLayout;
    LayInformationBottom: TLayout;
    Text2: TText;
    Text3: TText;
    RecBottomInfo: TRectangle;
    LayLegenda: TLayout;
    Text4: TText;
    Layout1: TLayout;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    ImageList1: TImageList;
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAgendaDiaFuncionario: TFrmAgendaDiaFuncionario;

implementation

{$R *.fmx}

uses
Controller.FrmAgendaDiaFuncionario;

procedure TFrmAgendaDiaFuncionario.FormActivate(Sender: TObject);
var
 Controller:IController;
begin
  inherited;
  Controller:=TController.Create;
  Controller.ListarFuncionarios(Listview1,ImageList1);
  Text3.Text:= FormatDatetime('dddd dd "de" mmmm "de" yyyy',Controller.DataSelecionada);
end;

procedure TFrmAgendaDiaFuncionario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
Action:=TCloseAction.caFree;
end;

procedure TFrmAgendaDiaFuncionario.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
if key=vkHardwareBack then
    begin
    {$ifdef Android}
    Toast('Aguarde...',LongToast);
    {$endif}
    end;
end;

procedure TFrmAgendaDiaFuncionario.ListView1ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
Controller:IController;
begin
  inherited;
  Controller:= TController.create;
  Controller.EscolherFuncionario(ItemIndex);
  Controller.ShowForm;
//Showmessage (Controller.EscolherFuncionario(ItemIndex).Nome);
end;

end.