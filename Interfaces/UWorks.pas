unit UWorks;

interface

uses
  System.SysUtils;
Type
IWork = interface
['{13160CF6-8635-4EEC-971F-B431DA5AAAE4}']
 function Execute:IWork;
end;

TWork = class(TInterfacedObject,IWork)
 function Execute:IWork;
end;

implementation

{ TWork }

function TWork.Execute:Iwork;
begin
Result:=Self;
Sleep(3000);
end;

end.
