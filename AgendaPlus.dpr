program AgendaPlus;

uses
  System.StartUpCopy,
  FMX.Forms,
  UfrmLogin in 'View\UfrmLogin.pas' {FrmLogin},
  UfrmBase in 'View\UfrmBase.pas' {FrmBase},
  UfrmCadastro in 'View\UfrmCadastro.pas' {FrmCadastro},
  UfrmCadFuncionario in 'View\UfrmCadFuncionario.pas' {FrmCadFuncionario},
  UnitIefects in 'Interfaces\UnitIefects.pas',
  UControllerCadastros in 'Controllers\UControllerCadastros.pas',
  model.funcionario in 'model\model.funcionario.pas',
  model.servico in 'model\model.servico.pas',
  UControllers in 'Controllers\UControllers.pas',
  model.empresa in 'model\model.empresa.pas',
  model.endereco in 'model\model.endereco.pas',
  model.telefone in 'model\model.telefone.pas',
  UfrmCadServico in 'View\UfrmCadServico.pas' {FrmCadServico},
  model.single in 'model\model.single.pas',
  mode.agendamento in 'model\mode.agendamento.pas',
  UDao.Single in 'Dao\UDao.Single.pas',
  UfrmCalendar in 'View\UfrmCalendar.pas' {FrmCalendar},
  UfrmAgendaDiaFuncionario in 'View\UfrmAgendaDiaFuncionario.pas' {FrmAgendaDiaFuncionario},
  UfrmAgendar in 'View\UfrmAgendar.pas' {FrmAgendar},
  Controller.FrmCalendar in 'Controllers\Controller.FrmCalendar.pas',
  Controller.FrmAgendaDiaFuncionario in 'Controllers\Controller.FrmAgendaDiaFuncionario.pas',
  Controller.FrmAgendar in 'Controllers\Controller.FrmAgendar.pas',
  model.cliente in 'model\model.cliente.pas',
  model.agendar in 'model\model.agendar.pas',
  model.marcacao in 'model\model.marcacao.pas',
  model.agendamentos in 'model\model.agendamentos.pas',
  Controller.FrmCadFuncionario in 'Controllers\Controller.FrmCadFuncionario.pas',
  Controller.FrmCadServico in 'Controllers\Controller.FrmCadServico.pas',
  model.contato.agenda in 'model\model.contato.agenda.pas',
  Androidapi.JNI.Toast in 'components\Androidapi.JNI.Toast.pas',
  UWhatsApp in 'components\UWhatsApp.pas',
  UWorks in 'Interfaces\UWorks.pas',
  UDao in 'Dao\UDao.pas',
  Controller.FrmLogin in 'Controllers\Controller.FrmLogin.pas',
  model.listAgendar in 'model\model.listAgendar.pas',
  UfrmCadClientes in 'View\UfrmCadClientes.pas' {FrmCadClientes},
  Controller.FrmCadClientes in 'Controllers\Controller.FrmCadClientes.pas',
  model.agendados in 'model\model.agendados.pas',
  UfrmCadastrosBase in 'View\UfrmCadastrosBase.pas' {FrmCadastrosBase},
  UfrmControleCadastros in 'View\UfrmControleCadastros.pas' {FrmControleCadastros},
  UfrmHistorico in 'View\UfrmHistorico.pas' {FrmHistorico},
  Controller.frmHistorico in 'Controllers\Controller.frmHistorico.pas',
  model.tratamento in 'model\model.tratamento.pas',
  model.orcamento in 'model\model.orcamento.pas',
  Controller.FrmOrcamentos in 'Controllers\Controller.FrmOrcamentos.pas',
  UfrmCadastrarOrcamento in 'View\UfrmCadastrarOrcamento.pas' {FrmCadastrarOrcamento},
  model.key in 'model\model.key.pas',
  model.agendar1 in 'model\model.agendar1.pas',
  model.requisicoes in 'model\model.requisicoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmBase, FrmBase);
  Application.Run;
end.
