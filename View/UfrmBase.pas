unit UfrmBase;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.MultiView,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.TabControl,System.threading,UWorks, FMX.Ani, FMX.ListBox;

type
  TProcedure = procedure;
  TFrmBase = class(TForm)
    LayTudo: TLayout;
    LayTop: TLayout;
    LayBtnMenu: TLayout;
    LayBack: TLayout;
    LayLogo: TLayout;
    BGTopo: TRectangle;
    BntMenu: TButton;
    LayContent: TLayout;
    MenuMultiview: TMultiView;
    BGMenu: TRectangle;
    BtnBack: TButton;
    ImgLogo: TImage;
    LaySubMenu: TLayout;
    BGSubTitle: TRectangle;
    TextSubitle: TText;
    Text1: TText;
    LayLoad: TLayout;
    BGLoad: TRectangle;
    Arc1: TArc;
    FloatLoad: TFloatAnimation;
    TextLoad: TText;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ImageFoto1: TImage;
    Textmenu1: TText;
    ListBoxItem2: TListBoxItem;
    ImageFoto2: TImage;
    Text7Menu: TText;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExecuteWork(AWork:IWork);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure Textmenu1Click(Sender: TObject);
    procedure Text7MenuClick(Sender: TObject);
  private
   procedure CadastrarCliente;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBase: TFrmBase;

implementation
uses
 UfrmControleCadastros,UfrmHistorico;
{$R *.fmx}


procedure TFrmBase.CadastrarCliente;
begin

end;

procedure TFrmBase.ExecuteWork(Awork:IWork);
 var
 Task:TThread;
begin
self.LayLoad.Visible:=true;
self.FloatLoad.Enabled:=true;
Task:=TThread.CreateAnonymousThread(procedure
                                      begin

                                       AWork.execute;
                                       Task.Synchronize(Task,procedure
                                                              begin
                                                              self.LayLoad.Visible:=False;
                                                              Self.FloatLoad.Enabled:=False;
                                                              end);
                                      end);
 Task.Start;


end;

procedure TFrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//Action:=TCloseAction.caFree;
end;

procedure TFrmBase.ListBoxItem1Click(Sender: TObject);
begin
CadastrarCliente;
end;

procedure TFrmBase.Text7MenuClick(Sender: TObject);
begin
 Application.CreateForm(TFrmHistorico, FrmHistorico);
 FrmHistorico.show;
end;

procedure TFrmBase.Textmenu1Click(Sender: TObject);
begin
Application.CreateForm(TFrmControleCadastros, FrmControleCadastros);
FrmControleCadastros.show;
end;

end.
