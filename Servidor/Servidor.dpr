program Servidor;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UfrmStartServer in 'view\UfrmStartServer.pas' {FrmStartServer},
  usm in 'ServerMethods\usm.pas' {sm: TDSServerModule},
  usc in 'ServerContainer\usc.pas' {ServerContainer1: TDataModule},
  uwm in 'WebModule\uwm.pas' {WebModule1: TWebModule},
  mode.agendamento in '..\model\mode.agendamento.pas',
  model.agendamentos in '..\model\model.agendamentos.pas',
  model.agendar in '..\model\model.agendar.pas',
  model.cliente in '..\model\model.cliente.pas',
  model.contato.agenda in '..\model\model.contato.agenda.pas',
  model.empresa in '..\model\model.empresa.pas',
  model.endereco in '..\model\model.endereco.pas',
  model.funcionario in '..\model\model.funcionario.pas',
  model.marcacao in '..\model\model.marcacao.pas',
  model.servico in '..\model\model.servico.pas',
  model.telefone in '..\model\model.telefone.pas',
  UnitIefects in '..\Interfaces\UnitIefects.pas',
  UWorks in '..\Interfaces\UWorks.pas',
  model.agendados in '..\model\model.agendados.pas',
  model.orcamento in '..\model\model.orcamento.pas',
  model.tratamento in '..\model\model.tratamento.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFrmStartServer, FrmStartServer);
  Application.Run;
end.
