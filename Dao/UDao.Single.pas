unit UDao.Single;

interface
uses
Rest.json,model.single;

Type
IPersist = interface
  ['{819ED967-0675-4B8B-AEFD-6EEE212D8AE2}']
  function save(ASingle:TSingle):string;
   function update(ASingle:TSingle):string;
   function delete(ASingle:TSingle):string;
end;


 TPersist= class(TinterfacedObject,IPersist)
   function save(ASingle:TSingle):string;
   function update(ASingle:TSingle):string;
   function delete(ASingle:TSingle):string;
 end;

implementation

{ TPersist }

function TPersist.delete(ASingle: TSingle): string;
begin
Result:=TJson.ObjectToJsonString(ASingle);
end;

function TPersist.save(ASingle: TSingle): string;
begin
 Result:=TJson.ObjectToJsonString(ASingle);
end;

function TPersist.update(ASingle: TSingle): string;
begin
 Result:=TJson.ObjectToJsonString(ASingle);
end;

end.
