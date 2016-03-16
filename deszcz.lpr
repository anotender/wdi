program project1;

uses crt;

const
  szerokosc=29;
  wysokosc=27;

type
  tab=array [0..wysokosc,0..szerokosc] of char;

var
  tablica:tab;
  i,j:integer;

procedure przepisz(var tablica:tab);
var
  kolumna:integer;
begin
  for i:=wysokosc downto 0 do
  begin
    for j:=0 to szerokosc do
    begin
      tablica[i][j]:=tablica[i-1][j];
    end;
  end;
  kolumna:=random(szerokosc);
  for j:=0 to szerokosc do
  begin
    if j=kolumna then tablica[0][j]:='O'
    else tablica[0][j]:='*';
  end;
end;

procedure wypisz(tablica:tab);
begin
  for i:=0 to wysokosc do
  begin
    for j:=0 to szerokosc do
    begin
      write(tablica[i][j],' ');
    end;
    writeln;
  end;
end;

begin
  randomize;
  for i:=0 to wysokosc do
  begin
    for j:=0 to szerokosc do
    begin
      tablica[i][j]:='*';
    end;
  end;
  while true do
  begin
    przepisz(tablica);
    wypisz(tablica);
    delay(150);
    clrscr;
  end;
end.

