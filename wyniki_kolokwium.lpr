program kolos;

uses crt;

type
  wsk_student=^student;
  student=record
    nazwisko:string;
    pkt:integer;
    wsk:wsk_student;
  end;

var
  poczatek:wsk_student;
  klawisz:char;

procedure push(var poczatek:wsk_student);
var
  nowy:wsk_student;
begin
  new(nowy);
  nowy^.wsk:=poczatek;
  poczatek:=nowy;
  write('Podaj nazwisko: ');
  readln(nowy^.nazwisko);
  write('Podaj liczbe pkt: ');
  readln(nowy^.pkt);
end;

procedure pop(var poczatek:wsk_student);
var
  tmp:wsk_student;
begin
  if poczatek<>nil then
  begin
    writeln(poczatek^.nazwisko,': ',poczatek^.pkt);
    tmp:=poczatek^.wsk;
    dispose(poczatek);
    poczatek:=tmp;
  end
  else writeln('Stos jest pusty.');
  readln;
end;

procedure wypisz(poczatek:wsk_student);
var
  iterator:wsk_student;
begin
  iterator:=poczatek;
  while iterator<>nil do
  begin
    writeln(iterator^.nazwisko,': ',iterator^.pkt);
    iterator:=iterator^.wsk;
  end;
  readln;
end;

procedure max(poczatek:wsk_student);
var
  max:integer;
  iterator:wsk_student;
begin
  if poczatek<>nil then
  begin
    max:=poczatek^.pkt;
    iterator:=poczatek;
    while iterator<>nil do
    begin
      if iterator^.pkt>max then
      begin
        max:=iterator^.pkt;
      end;
      iterator:=iterator^.wsk;
    end;
    iterator:=poczatek;
    while iterator<>nil do
    begin
      if iterator^.pkt=max then writeln(iterator^.nazwisko,': ',iterator^.pkt);
      iterator:=iterator^.wsk;
    end;
  end
  else writeln('Stos jest pusty.');
  readln;
end;

begin
  poczatek:=nil;
  while true do
  begin
    writeln('d - push');
    writeln('u - pop');
    writeln('o - wyswietl');
    writeln('m - max');
    writeln('q - koniec');
    klawisz:=readkey;
    clrscr;
    case klawisz of
      'd':push(poczatek);
      'u':pop(poczatek);
      'o':wypisz(poczatek);
      'm':max(poczatek);
      'q':exit;
    end;
    clrscr;
  end;
end.
