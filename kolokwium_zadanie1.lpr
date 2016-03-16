program zadanie1;

uses crt;

var
  liczba:integer;
  wynik:string;
  reszta:integer;
  i:integer;

begin
  write('Podaj liczbe: ');
  readln(liczba);
  wynik:='';
  while liczba>0 do
  begin
    reszta:=liczba mod 5;
    liczba:=liczba div 5;
    wynik:=wynik+chr(reszta+48);
  end;
  for i:=length(wynik) downto 1 do write(wynik[i]);
  writeln;
  readln;
end.
