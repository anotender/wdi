program project1;

uses crt;

type
  wskaznik=^lista;
  lista=record
  nazwisko:string;
  pkt:integer;
  wsk:wskaznik;
  end;

var
  poczatek:wskaznik;
  numer:integer;

procedure push_front(var poczatek:wskaznik);
var
  nowy:wskaznik;
begin
  new(nowy);
  write('Podaj nazwisko: ');
  readln(nowy^.nazwisko);
  write('Podaj liczbe punktow: ');
  readln(nowy^.pkt);
  nowy^.wsk:=poczatek;
  poczatek:=nowy;
end;
procedure pop_front(var poczatek:wskaznik);
begin
  poczatek:=poczatek^.wsk;
end;
procedure push_back(var poczatek:wskaznik);
var
  nowy,iterator:wskaznik;
begin
  new(nowy);
  write('Podaj nazwisko: ');
  readln(nowy^.nazwisko);
  write('Podaj liczbe punktow: ');
  readln(nowy^.pkt);
  iterator:=poczatek;
  while iterator^.wsk<>nil do
  begin
    iterator:=iterator^.wsk;
  end;
  iterator^.wsk:=nowy;
  nowy^.wsk:=nil;
end;
procedure pop_back(var poczatek:wskaznik);
var
  iterator:wskaznik;
begin
  iterator:=poczatek;
  while iterator^.wsk^.wsk<>nil do
  begin
    iterator:=iterator^.wsk;
  end;
  iterator^.wsk:=nil;
end;
procedure max(poczatek:wskaznik);
var
  max:integer;
  nazwisko:string;
  iterator:wskaznik;
begin
  iterator:=poczatek;
  max:=iterator^.pkt;
  nazwisko:=iterator^.nazwisko;
  while iterator<>nil do
  begin
    if iterator^.pkt>max then
    begin
      max:=iterator^.pkt;
      nazwisko:=iterator^.nazwisko;
    end;
    iterator:=iterator^.wsk;
    end;
    clrscr;
    writeln('Najwiecej pkt uzyskal ',nazwisko,': ',max);
    readln;
end;
procedure min(poczatek:wskaznik);
var
  min:integer;
  nazwisko:string;
  iterator:wskaznik;
begin
  iterator:=poczatek;
  min:=iterator^.pkt;
  nazwisko:=iterator^.nazwisko;
  while iterator<>nil do
  begin
    if iterator^.pkt<min then
    begin
      min:=iterator^.pkt;
      nazwisko:=iterator^.nazwisko;
    end;
    iterator:=iterator^.wsk;
    end;
    clrscr;
    writeln('Najmniej pkt uzyskal ',nazwisko,': ',min);
    readln;
end;

procedure wypisz(poczatek:wskaznik);
var
  iterator:wskaznik;
begin
  iterator:=poczatek;
  while iterator<>nil do
  begin
    writeln(iterator^.nazwisko,': ',iterator^.pkt);
    iterator:=iterator^.wsk;
  end;
end;

begin
  while true do
  begin
    writeln('LISTA');
    wypisz(poczatek);
    writeln('======================');
    writeln('1. push_front');
    writeln('2. push_back');
    writeln('3. pop_front');
    writeln('4. pop_back');
    writeln('5. max');
    writeln('6. min');
    writeln('7. koniec');
    write('Numer: ');
    readln(numer);
    case numer of
    1:push_front(poczatek);
    2:push_back(poczatek);
    3:pop_front(poczatek);
    4:pop_back(poczatek);
    5:max(poczatek);
    6:min(poczatek);
    7:break;
    end;
    delay(100);
    clrscr;
  end;
end.
