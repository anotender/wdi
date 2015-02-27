program project1;

uses crt;

type
  wsk_pracownik=^pracownik;
  pracownik=record
    nazwisko:string;
    stanowisko:string;
    zarobki:integer;
    wsk:wsk_pracownik;
  end;

var
  klawisz:char;
  poczatek:wsk_pracownik;

procedure push(var poczatek:wsk_pracownik);
var
  nowy:wsk_pracownik;
begin
  new(nowy);
  nowy^.wsk:=poczatek;
  poczatek:=nowy;
  write('Podaj nazwisko: ');
  readln(nowy^.nazwisko);
  write('Podaj stanowisko: ');
  readln(nowy^.stanowisko);
  write('Podaj zarobki: ');
  readln(nowy^.zarobki);
end;

procedure pop(var poczatek:wsk_pracownik);
var
  usuwany:wsk_pracownik;
begin
  if poczatek<>nil then
  begin
    usuwany:=poczatek;
    poczatek:=poczatek^.wsk;
    writeln('Nazwisko: ',usuwany^.nazwisko,' Stanowisko: ',usuwany^.stanowisko,' Zarobki: ',usuwany^.zarobki);
    dispose(usuwany);
  end
  else writeln('Stos jest pusty');
  readln;
end;

procedure wypisz(poczatek:wsk_pracownik);
var
  iterator:wsk_pracownik;
begin
  if poczatek<>nil then
  begin
    iterator:=poczatek;
    while iterator<>nil do
    begin
      writeln('Nazwisko: ',iterator^.nazwisko,' Stanowisko: ',iterator^.stanowisko,' Zarobki: ',iterator^.zarobki);
      iterator:=iterator^.wsk;
    end;
  end
  else writeln('Stos jest pusty');
  readln;
end;

begin
  poczatek:=nil;
  while true do
  begin
    writeln('1 - push');
    writeln('2 - pop');
    writeln('3 - wypisz');
    writeln('4 - koniec');
    readln(klawisz);
    clrscr;
    case klawisz of
    '1':push(poczatek);
    '2':pop(poczatek);
    '3':wypisz(poczatek);
    '4':exit;
    end;
    clrscr;
  end;


end.
