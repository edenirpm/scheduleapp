unit UControllers;

interface
uses
 Fmx.StdCtrls,
 System.Generics.collections,
 UnitIefects,
 mode.agendamento,
 model.single,
 model.servico,
 Udao.Single,
 model.funcionario, FMX.Objects, System.UITypes, System.SysUtils;

Type
IController = interface
  ['{66851E17-C07D-42DB-AE0C-90DED2B3BCDB}']
    procedure EfectTextToUp(AObject:TObject); //tem que ser um ttext
    function CadastrarFuncionario(Cordialidade,Nome,Login,Senha:string):boolean;
    function CadastrarServico(NomeServico:string;Valor:Currency):boolean;
    function Cadastrar(ASingle:TSingle):string;
    procedure MostrarMarcacoes(ADate:TDate;Sender:TObject);
end;

TController = class(TInterfacedObject,IController)
  private

  public
  procedure CadastrarEmpresa;
  function CadastrarFuncionario(Cordialidade,Nome,Login,Senha:string):boolean;
  function CadastrarServico(NomeServico:string;Valor:Currency):boolean;
  procedure EfectTextToUp(AObject:TObject); //tem que ser um ttext
  function Cadastrar(ASingle:TSingle):string;
  procedure MostrarMarcacoes(ADate:TDate;Sender:TObject);
end;

implementation

uses
   UControllerCadastros,FMX.Dialogs;

{ TController }

function TController.Cadastrar(ASingle: TSingle):string;
var
 Dao:Ipersist;
begin

  Dao:=TPersist.create;
  Result:=Dao.save(ASingle);

end;

procedure TController.CadastrarEmpresa;
var
 Empresa:ICadastros;
begin
   try
   Empresa:=TControllerCadastros.Create;
   Empresa.CadastrarEmpresa('webrz','Jacuipe','147','Concordia','Belo Horizonte','MG','BR','031','991770674','edenirpm','ddlcaddlca');
   Except

   end;
end;

function TController.CadastrarFuncionario(Cordialidade,Nome,Login,Senha:string):boolean;
var
Funcionario:TFuncionario;
Funcionarios:TObjectList<TFuncionario>;
begin
  if( Nome<>'') and (login<>'') and (senha<>'') then
     begin
       try
        Funcionario:=TFuncionario.Create;
        Funcionario.Cordialidade:=Cordialidade;
        Funcionario.Nome:=Nome;
        Funcionario.Login:=Login;
        Funcionario.Senha:=Senha;
        Funcionarios:=TSingle.GetInstance.Funcionarios;
        Funcionarios.Add(Funcionario);
        Result:=true;
       finally
       //  Showmessage('Funcionario Cadastrado com Sucesso!');
       end;
     end else
          begin
           Result:=false;
          end;
end;

function TController.CadastrarServico(NomeServico:string;Valor:Currency):boolean;
var
Servico:Tservico;
Servicos:TObjectList<TServico>;
begin
   if NomeServico<>'' then
   begin
    try
     Servico:=TServico.create;
     Servico.Nome:=NomeServico;
     Servico.Valor:=Valor;

     Servicos:=TSingle.GetInstance.Servicos;
     Servicos.add(Servico);
    finally
    Result:=true;
    end;
   end else
        begin
          Result:=False;
        end;
end;






procedure TController.EfectTextToUp(AObject: TObject);
var
 Efeito:TEfectLabelsTextUP;
begin
  try
   Efeito:=TEfectLabelsTextUP.Create;
   Efeito.EfectTextEdit(AObject);
  finally
   Efeito.DisposeOf;
  end;
end;



procedure TController.MostrarMarcacoes(ADate:TDate;Sender: TObject);
var
Single:Tsingle;
agendamento:Tagendamento;
begin
 Single:=TSingle.GetInstance;
 for agendamento in Single.Agendamentos do
 begin
    if (agendamento.Data = Adate) and (Agendamento.Hora = strtotime((Sender as Tlabel).Text) ) then
    begin
       ((Sender as TLabel).Parent as TRectangle).Fill.Color:= TAlphaColorRec.Tomato;
    end;

 end;

end;

end.
