unit Controller.FrmOrcamentos;

interface
uses
FMX.ListView,
FMX.ImgList,
model.cliente,
model.agendar,
model.orcamento;
Type
IControllerOrcamento = interface
  ['{7567403D-576F-4BC5-BF27-1B8952B7C14C}']
  procedure ListarOrcamentos(AListview:TListview;AImageList:TImageList;AclientName:string);
  procedure AddOrcamento(AClienteName:string);
  procedure RemoveOrcamento;
end;

TControllerOrcamento = class(TInterfacedObject,IControllerOrcamento)
  procedure ListarOrcamentos(AListview:TListview;AImageList:TImageList;AclientName:string);
  procedure AddOrcamento(AClienteName:string);
  procedure RemoveOrcamento;
end;

implementation

{ TControllerOrcamento }

procedure TControllerOrcamento.AddOrcamento(AClienteName:string);
var
 Agendar:TAgendar;
 cliente:TCliente;
 Orcamento:TOrcamento;
begin

end;

procedure TControllerOrcamento.ListarOrcamentos(AListview: TListview;
  AImageList: TImageList; AclientName: string);
begin

end;

procedure TControllerOrcamento.RemoveOrcamento;
begin

end;



end.