program kwadrat;

uses crt;

const
  szerokosc=31;
  wysokosc=23;

type
  tab=array [0..wysokosc-1,0..szerokosc-1] of char;

var
  tablica:tab;
  i,j,krok:integer;
  rosnie,maleje:boolean;

procedure przepisz(var tablica:tab;krok:integer);
begin
  for i:=0 to wysokosc-1 do
  begin
    for j:=0 to szerokosc-1 do
    begin
      if ((szerokosc div 2 +krok=j)and(i<=wysokosc div 2 +krok)and(i>=wysokosc div 2 -krok))or
         ((wysokosc div 2 +krok=i)and(j<=szerokosc div 2 +krok)and(j>=szerokosc div 2 -krok))or
         ((szerokosc div 2 -krok=j)and(i>=wysokosc div 2 -krok)and(i<=wysokosc div 2 +krok))or
         ((wysokosc div 2 -krok=i)and(j<=szerokosc div 2 +krok)and(j>=szerokosc div 2 -krok))then tablica[i][j]:='O'
      else tablica[i][j]:='*';
    end;
  end;
end;

procedure wypisz(tablica:tab);
begin
  for i:=0 to wysokosc-1 do
  begin
    for j:=0 to szerokosc-1 do
    begin
      write(tablica[i][j],' ');
    end;
    writeln;
  end;
end;

begin
  for i:=0 to wysokosc-1 do
  begin
    for j:=0 to szerokosc-1 do
    begin
      tablica[i][j]:='*';
    end;
  end;
  krok:=0;
  rosnie:=true;
  maleje:=false;
  while true do
  begin
    if rosnie then
    begin
      if (krok<(szerokosc div 2 ))and(krok<(wysokosc div 2 )) then inc(krok)
      else
      begin
        rosnie:=false;
        maleje:=true;
      end;
    end
    else if maleje then
    begin
      if (krok>0) then dec(krok)
      else
      begin
        rosnie:=true;
        maleje:=false;
      end;
    end;

    przepisz(tablica,krok);
    wypisz(tablica);
    delay(300);
    clrscr;
  end;
end.
