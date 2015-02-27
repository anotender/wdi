program project1;

uses crt, math, sysutils;

var
  wybor: byte;
  liczba: string;
  wynik_dziesietny: extended;
  wynik1: string;
  wynik2: int64;
  wynik_koncowy: string;
  licznik: int64;
  dlugosc: int64;
  zamiana: integer;
  reszta: integer;
  cyfra: string;


begin
  while(true)do
  begin

  {--------------------------------------------
   Wczytanie z jakiego systemu przeliczyc liczbe
   --------------------------------------------}

  while(true)do
  begin
       writeln('==================');
       writeln('Obslugiwane sa systemy od dwojkowego do szesnastkowego.');
       write('Zamiana z systemu (2-dwojkowego, 3-trojkowego itd. az do 16): ');
       readln(wybor);
       if(wybor>16)or(wybor<2)then
       begin
            writeln('System nieobsługiwany.');
            continue;
       end;

  {-------------------------------
   Wczytanie liczby do przeliczenia
   -------------------------------}

       wynik_dziesietny:=0;
       writeln('==================');
       write('Podaj liczbe: ');
       readln(liczba);
       dlugosc:=length(liczba);
       licznik:=1;

       while (licznik<=dlugosc)do
       begin
       if(ord(liczba[licznik])>47)and(ord(liczba[licznik])<58) then
       begin
            zamiana:= ord(liczba[licznik])-48;
       end
       else if(ord(liczba[licznik])>64)and(ord(liczba[licznik])<71) then
       begin
            zamiana:= ord(liczba[licznik])-55;
       end
       else if(ord(liczba[licznik])>96)and(ord(liczba[licznik])<103) then
       begin
            zamiana:= ord(liczba[licznik])-87;
       end;

       if(zamiana>=wybor)then
       begin
            writeln('Ta liczba jest niepoprawna w systemie, ktory wybrales. Sprobuj jeszcze raz!');
            wynik_dziesietny:=0;
            break;
       end;
       wynik_dziesietny:=wynik_dziesietny+zamiana*power(wybor,dlugosc-licznik);
       licznik:=licznik+1;
       end;

       if(zamiana>=wybor)then
       begin
            continue;
       end;
       if(wynik_dziesietny=0)then
       begin
            writeln('Zero jest zerem we szystkich systemach.');
            continue;
       end;
       wynik1:=floattostr(wynik_dziesietny);
       if trystrtoint64(wynik1, wynik2) then
       begin
            break;
       end
       else
       begin
            writeln('Liczba zbyt duża!');
            wynik_dziesietny:=0;
            continue;
       end;
  end;

  {-----------------------------------------
   Wczytanie na jaki system przeliczyc liczbe
   -----------------------------------------}

  while(true)do
  begin
       writeln('==================');
       writeln('Obslugiwane sa systemy od dwojkowego do szesnastkowego.');
       write('Zamiana na system (2-dwojkowy, 3-trojkowy itd. az do 16): ');
       readln(wybor);
       if(wybor>16)or(wybor<2)then
       begin
           writeln('System nieobsługiwany.');
       end
       else
       begin
           break;
       end;
  end;

  writeln('==================');


  wynik_koncowy:='';
  while(wynik2>=1) do
  begin
       reszta:=wynik2 mod wybor;
       if(reszta>=10)then
       begin
            cyfra:= chr(reszta+55);
       end
       else
       begin
            cyfra:= inttostr(reszta);
       end;
       wynik2:=wynik2 div wybor;
       wynik_koncowy:=wynik_koncowy+cyfra;
  end;
  dlugosc:=length(wynik_koncowy);

  {----------------
   Wypisanie wyniku
   ----------------}

  write('Wynik: ');
  while (dlugosc>0) do
  begin
       write(wynik_koncowy[dlugosc]);
       dlugosc:=dlugosc-1;
  end;
  wynik_koncowy:='';
  writeln;

  writeln('==================');
  write('Nacisnij ENTER, zeby kontynuowac...');
  readln;
  clrscr;
  end;
end.



{---------------------------------------------------------------
 Program wczytuje do zmiennej wybor numer systemu z jakiego
 będziemy zamieniać liczbę. Następnie wczytywana jest liczba
 do stringa. Liczbę tę zamieniamy na system dziesiętny.
 W pętli na podstawie kodów ASCII i odpowiedniego odjecia
 poszczególne cyfry liczby są uzyskiwane i mnozone przez
 odpowiednią potęgę numeru systemu i dodawane do zmiennej
 wynik_dziesietny. Jednocześnie sprawdzana jest poprawność liczby
 jeśli chodzi o system i zakres typów zmiennych. Następnie jest
 wczytywany system na jaki zamieniona ma być liczba. Wykorzystując
 resztę z dzielenia i dzielenie całkowite liczba zamieniana jest
 na tę liczbę ale w zadanym systemie i zapisywana do zmiennej
 wynik_koncowy. Na końcu wyświetlany jest wynik.
 ---------------------------------------------------------------}
