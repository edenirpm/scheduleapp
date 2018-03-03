unit model.contato.agenda;

interface
uses
model.cliente,FMX.AddressBook,model.agendar,UWorks,
system.generics.collections;

Type
IContatoAgenda =interface
  ['{AB97CD03-4C31-4091-B770-0F5E95DD1A3F}']
  function CarregarContatos:IContatoAgenda;
  function Execute: IWork;
end;

TContatoAgenda = class(TInterfacedObject,IContatoAgenda,IWork)
  public
    function CarregarContatos:IContatoAgenda;
    function Execute: IWork;
end;

implementation

{ TContatoAgenda }

function TContatoAgenda.CarregarContatos: IContatoAgenda;
 var
  I: Integer;
  Contacts: TAddressBookContacts;
  Cliente:TCliente;
  Addresbook1:TAddressBook;
  Agendar:TAgendar;
begin
  Contacts:= TAddressBookContacts.create;
  Addresbook1:=TAddressBook.create(nil);
  Agendar:=TAgendar.GetInstance;
  if Addresbook1.Supported then
  begin
     Addresbook1.RequestPermission;
  end;

  try
   Addresbook1.AllContacts(Addresbook1.DefaultSource, Contacts);
        for I := 0 to Contacts.Count - 1 do
          begin
           begin
            Cliente:=TCliente.create;
            Cliente.Nome:=Contacts.Items[i].DisplayName;
            Cliente.Telefone.Celular:=Contacts.Items[i].Phones[0].Number;
            if agendar.Clientes.Contains(Cliente) = true then
               begin
                 cliente.Free;
               end else
                    begin
                      Agendar.Clientes.Add(Cliente);
                    end;
           end;
          end;

  finally
   Contacts.Free;
   Addresbook1.Free;
  end;

end;

function TContatoAgenda.Execute:Iwork;
begin
Result:=Self;
CarregarContatos;
end;

end.
