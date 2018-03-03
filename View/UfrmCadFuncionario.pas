unit UfrmCadFuncionario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UfrmBase, FMX.Edit, FMX.Objects, FMX.MultiView, FMX.Controls.Presentation,
  FMX.Layouts,UControllers,Controller.FrmCadFuncionario, FMX.ListBox;

type
  TFrmCadFuncionario = class(TFrmBase)
    Layout1: TLayout;
    RoundRect1: TRoundRect;
    Text2: TText;
    Layout2: TLayout;
    Layout3: TLayout;
    Edit1: TEdit;
    Text3: TText;
    Layout4: TLayout;
    Layout5: TLayout;
    Edit2: TEdit;
    Text4: TText;
    Layout6: TLayout;
    Layout7: TLayout;
    Edit3: TEdit;
    Text5: TText;
    Layout8: TLayout;
    ComboBox1: TComboBox;
    procedure Text5Click(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure CadastrarFuncionario;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadFuncionario: TFrmCadFuncionario;

implementation

{$R *.fmx}

procedure TFrmCadFuncionario.CadastrarFuncionario;
var
cord:string;
ctrl:IControllerFuncionario;
begin
  case ComboBox1.ItemIndex of
   0:cord:='Sr.';
   1:cord:='Sra.';
   2:cord:='Dr.';
   3:cord:='Dra.';
  end;

  try
    ctrl:=TControllerFuncionario.Create;
   if ctrl.CadastrarFuncionario(cord,edit3.Text,edit2.Text,edit1.Text) = true then
    begin
     Close;
    end else
         begin
          Showmessage('Você deve preenxer todos os campos!');
         end;
  Except

  end;

end;

procedure TFrmCadFuncionario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 Action:=TCloseAction.caFree;
end;

procedure TFrmCadFuncionario.Text2Click(Sender: TObject);
begin
CadastrarFuncionario;

end;

procedure TFrmCadFuncionario.Text5Click(Sender: TObject);
var
 Efect:IController;
begin
  inherited;
   try
    Efect:=TController.Create;
    Efect.EfectTextToUp(Sender);
   finally

   end;

end;

end.
