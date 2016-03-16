program zadanie3;

uses crt;

var
  kod1,kod1_przepisany:string;
  kod2,kod2_przepisany:string;

procedure przepisz(kod:string;var kod_przepisany:string);
var
  i,j:integer;
  dzielnia:char;
begin
  i:=1;
  while i<=length(kod) do
  begin
    dzielnia:=kod[i];
    for j:=1 to ord(kod[i+1])-48 do
    begin
      kod_przepisany:=kod_przepisany+dzielnia;
    end;
    i:=i+2;
  end;
end;

procedure porownaj(kod1,kod2:string);
var
  centrum:boolean;
  i,czas:integer;
begin
  i:=1;
  centrum:=true;
  while (i<=length(kod1))and(i<=length(kod2)) do
  begin
    if kod1[i]=kod2[i] then
    begin
      centrum:=false;
      break;
    end;
    inc(i);
  end;
  if centrum then writeln('Spotkaja sie w centrum. Czas: ',length(kod1)+length(kod2))
  else writeln('Spotkaja sie w dzielnicy ',kod1[i],'. Czas: ',2*i-2);
end;

begin
  write('Podaj pierwszy kod: ');
  readln(kod1);
  write('Podaj drugi kod: ');
  readln(kod2);
  kod1_przepisany:='';
  kod2_przepisany:='';
  przepisz(kod1,kod1_przepisany);
  przepisz(kod2,kod2_przepisany);
  porownaj(kod1_przepisany,kod2_przepisany);
  readln;
end.