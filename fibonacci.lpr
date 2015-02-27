program fib;

uses crt;

var
  liczba:integer;

function fib(liczba:integer):integer;
begin
  if (liczba=1)or(liczba=2) then fib:=1
  else fib:=fib(liczba-1)+fib(liczba-2);
end;

begin
  write('Podaj, ktory wyraz ciagu chcesz policzyc: ');
  readln(liczba);
  writeln('Wynik: ',fib(liczba));
  readln;
end.
