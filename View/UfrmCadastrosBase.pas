unit UfrmCadastrosBase;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UfrmBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, System.ImageList, FMX.ImgList, FMX.Objects,
  FMX.ListView, FMX.TabControl, FMX.Ani, FMX.MultiView,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox;

type
  TFrmCadastrosBase = class(TFrmBase)
    LayoTop: TLayout;
    TTabControl1: TTabControl;
    TabLista: TTabItem;
    TabEditar: TTabItem;
    TabVisualizar: TTabItem;
    AListview1: TListView;
    LayBtnPlus: TLayout;
    LayPlus: TLayout;
    CirclePlus: TCircle;
    TextPlus: TText;
    AImageList1: TImageList;
    BgSubtitle1: TRectangle;
    TextSubTitle: TText;
    LayFooter: TLayout;
    BgFooter: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastrosBase: TFrmCadastrosBase;

implementation

{$R *.fmx}

end.
