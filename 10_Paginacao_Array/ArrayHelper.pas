unit ArrayHelper;

interface
type
   TMyIntArray = array of integer;
   function IndexOfInteger(const List: TMyIntArray; const Value: Integer): Integer;
implementation

function IndexOfInteger(const List: TMyIntArray; const Value: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(List) to High(List) do
  begin
    if List[I] = Value then
    begin
      Result := I;
      Break;
    end;
  end;
end;


end.
