unit Controller.FrmOrcamentos;

interface
uses
FMX.ListView,
FMX.ImgList,
model.cliente,
model.Servico,
model.agendar,
model.orcamento, System.SysUtils;
Type
IControllerOrcamento = interface
  ['{7567403D-576F-4BC5-BF27-1B8952B7C14C}']
  procedure ListarOrcamentos(AListview:TListview;AImageList:TImageList);
end;

TControllerOrcamento = class(TInterfacedObject,IControllerOrcamento)
  Forcamento:TOrcamento;
  FValor:Currency;
  procedure ListarOrcamentos(AListview:TListview;AImageList:TImageList);
  procedure AddOrcamento();
  procedure RemoveOrcamento(AIndex:Integer;AOcamento:TOrcamento;ANAmeCliente:string);
  procedure AddServicosOrcamento(NomeServico:string;Valor:Currency);
  procedure RemoveServicosOrcamento(AIndexServico:integer);
  procedure ListarProcedimentos(AListview:TListview;AImageList:TImageList);
  function ClienteName:string;
  constructor create;
  destructor destroy;override;
end;

implementation

uses
  FMX.Dialogs;

{ TControllerOrcamento }

procedure TControllerOrcamento.AddOrcamento();
var
 Agendar:TAgendar;
 cliente:TCliente;
 Orcamento:TOrcamento;
 Procedimento:TServico;
begin
 Agendar:=TAgendar.GetInstance;
 for Cliente in Agendar.Clientes do
 begin
   if Cliente.Nome = Agendar.ClienteName then
   begin
     FOrcamento.Data:=Now;
     Cliente.Orcamentos.Add(FOrcamento);
   end;
 end;
end;

procedure TControllerOrcamento.AddServicosOrcamento(
  NomeServico: string; Valor: Currency);
 var
 Servico:TServico;
begin
 try
  Servico:=TServico.Create;
  Servico.Nome:=NomeServico;
  Servico.Valor:=Valor;
 finally
  Forcamento.Procedimentos.Add(Servico);
 end;
end;

function TControllerOrcamento.ClienteName: string;
var
 Agendar:Tagendar;
begin
 Agendar:=TAgendar.GetInstance;
 Result:=Agendar.ClienteName;
end;

constructor TControllerOrcamento.create;
begin
Forcamento:=TOrcamento.create;
end;

destructor TControllerOrcamento.destroy;
begin
 Forcamento.Free;
  inherited;
end;

procedure TControllerOrcamento.ListarOrcamentos(AListview: TListview;
  AImageList: TImageList);
var
 Cliente:TCliente;
 Agendar:TAgendar;
 Orcamento:TOrcamento;
begin
Agendar:=TAgendar.GetInstance;
AListview.Items.Clear;
 for Cliente in Agendar.Clientes do
 begin
  if Cliente.Nome = Agendar.ClienteName then
      begin
       for Orcamento in Cliente.Orcamentos do
       begin
         with AListview.Items.Add do
          begin
           Data['Title']:=Orcamento.Data;
           Data['SubTitle']:=FormatCurr('R$ ###,##0.00', Orcamento.valor);
           Data['Foto']:=AimageList.Source[0].ID;
           Data['ImgDeletar']:=AimageList.Source[2].ID;
          end;
       end;

      end;
 end;
end;

procedure TControllerOrcamento.ListarProcedimentos(AListview: TListview;
  AImageList: TImageList);
 var
 Procedimento:TServico;
 Total:Currency;
begin
 Total:=0;
 AListview.Items.Clear;
   try
    for Procedimento in FOrcamento.Procedimentos do
    begin
      Total:=Total + Procedimento.Valor;
      With AListview.Items.Add do
           begin
             Data['Title']:= Procedimento.Nome;
             Data['SubTitle']:= FormatCurr('R$ ###,##0.00', Procedimento.Valor);
             Data['Foto']:= AImageList.Source[4].ID;
             Data['ImgDeletar']:=AImageList.Source[2].ID;
           end;
     end;
   finally
    FOrcamento.valor:=Total;
   end;
end;





procedure TControllerOrcamento.RemoveOrcamento(AIndex: Integer;
  AOcamento: TOrcamento;ANAmeCliente:string);
var
Cliente:TCliente;
Agendar:TAgendar;
begin
Agendar:=TAgendar.GetInstance;
 for Cliente in Agendar.Clientes do
 begin
   if Cliente.Nome = ANAmeCliente then
   begin
     Cliente.Orcamentos.Delete(AIndex);
   end;
 end;
end;

procedure TControllerOrcamento.RemoveServicosOrcamento(AIndexServico: integer);
var
 Serv:TServico;
begin
  Serv:= Forcamento.Procedimentos.Items[AindexServico];
  Forcamento.procedimentos.Remove(Serv);
 //FOrcamento.Procedimentos.Delete(AIndexServico);
 //Showmessage(Forcamento.Procedimentos[AindexServico].Nome);
  //Forcamento.Procedimentos.Remove()
 //Forcamento.Procedimentos.Delete(AindexServico);
  //showmessage(Serv.Nome);
 end;

end.
