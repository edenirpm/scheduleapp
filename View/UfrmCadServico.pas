unit UfrmCadServico;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UfrmBase, FMX.Objects, FMX.Edit, FMX.MultiView, FMX.Controls.Presentation,
  FMX.Layouts,UControllers,Controller.FrmCadServico;

type
  TFrmCadServico = class(TFrmBase)
    Layout1: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    Edit3: TEdit;
    Text5: TText;
    RoundRect1: TRoundRect;
    Text2: TText;
    procedure Text2Click(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  procedure CadastrarServico;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadServico: TFrmCadServico;

implementation

{$R *.fmx}

procedure TFrmCadServico.CadastrarServico;
var
Servico:IControllerServico;
begin
   try
   Servico:=TControllerServico.Create;
   if Servico.CadastrarServico(Edit3.Text,0) = true then
      begin
        close;
      end else
           begin
             Showmessage('Você precisa digitar um nome para o serviço');
           end;
   Except

   end;

end;

procedure TFrmCadServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
Action:=TCloseAction.caFree;
end;

procedure TFrmCadServico.Text2Click(Sender: TObject);
begin
  inherited;
CadastrarServico;
end;

procedure TFrmCadServico.Text5Click(Sender: TObject);
var
Controller:IController;
begin
  inherited;
   Controller:=TController.Create;
   Controller.EfectTextToUp(Sender);
end;

end.
