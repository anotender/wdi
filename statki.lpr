program project1;

uses wincrt,wingraph,sysutils;

type statek=record
  dlugosc:word;
  orientacja:word;//1-pion;2-poziom
end;

type pole=record
  tmp:word;
  stale:word;
end;

var
  driver,mode:smallint;

const
  szerokosc=25;

  {===============
   0-puste pole
   1-statek nie trafiony
   2-pudlo
   3-statek trafiony
   4-wybierany
   ===============}

procedure rysuj(plansza:array of pole;x,y:smallint); //parametry zaznaczone okreslaja ktore pole jest aktualnie wskazywane przez uzytkownika
var
  i,j:word;
  x1,y1:smallint;
begin
  x1:=szerokosc+szerokosc div 3+x;
  y1:=szerokosc+szerokosc div 2+y;

  settextstyle(0,0,1);

  for i:=1 to 10 do
  begin
    outtextxy(x1+i*szerokosc,y1,inttostr(i));
  end;
  for i:=1 to 10 do
  begin
    outtextxy(x1,y1+i*szerokosc,chr(i+64));
  end;

  x1:=2*szerokosc+x;
  y1:=2*szerokosc+y;

  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      if plansza[j+i*10].tmp=4 then
      begin
        setfillstyle(solidfill,yellow);
        bar(x1+j*szerokosc,y1+i*szerokosc,x1+(j+1)*szerokosc,y1+(i+1)*szerokosc);
        setfillstyle(solidfill,white);
        continue;
      end;
      if plansza[j+i*10].stale=2 then
      begin
        bar(x1+j*szerokosc,y1+i*szerokosc,x1+(j+1)*szerokosc,y1+(i+1)*szerokosc);
        continue;
      end;
      if plansza[j+i*10].stale=3 then
      begin
        setfillstyle(solidfill,red);
        bar(x1+j*szerokosc,y1+i*szerokosc,x1+(j+1)*szerokosc,y1+(i+1)*szerokosc);
        setfillstyle(solidfill,white);
        continue;
      end;
      rectangle(x1+j*szerokosc,y1+i*szerokosc,x1+(j+1)*szerokosc,y1+(i+1)*szerokosc);

    end;
  end;
end;

procedure obrysowanie(var plansza:array of pole;orientacja,dlugosc,i,j:word);
var
  l,k,iterator:word;
begin
  if orientacja=1 then
              begin
                l:=j-1;
                if j=0 then
                begin
                  if i=0 then
                  begin
                    for iterator:=i to dlugosc+i do
                    begin
                      plansza[j+1+iterator*10].stale:=2;
                    end;
                  end
                  else
                  begin
                    for iterator:=i-1 to dlugosc+i do
                    begin
                      plansza[j+1+iterator*10].stale:=2;
                    end;
                  end;
                end
                else if j=9 then
                begin
                  if i=0 then
                  begin
                    for iterator:=i to dlugosc+i do
                    begin
                      plansza[j-1+iterator*10].stale:=2;
                    end;
                  end
                  else
                  begin
                    for iterator:=i-1 to dlugosc+i do
                    begin
                      plansza[j-1+iterator*10].stale:=2;
                    end;
                  end;
                end
                else
                begin
                  if i=0 then
                  begin
                    for k:=i to dlugosc+i do
                    begin
                      plansza[j+1+k*10].stale:=2;
                      plansza[j-1+k*10].stale:=2;
                    end;
                    plansza[j+(dlugosc+i)*10].stale:=2;
                  end
                  else if i+dlugosc-1=9 then
                  begin
                    for k:=i-1 to dlugosc+i-1 do
                    begin
                      plansza[j+1+k*10].stale:=2;
                      plansza[j-1+k*10].stale:=2;
                    end;
                    plansza[j+(i-1)*10].stale:=2;
                  end
                  else
                  begin
                    while l<=j+1 do
                    begin
                      for k:=i-1 to dlugosc+i do
                      begin
                        plansza[l+k*10].stale:=2;
                      end;
                    l:=l+2;
                    end;
                  end;
                end;
                if i>0 then plansza[j+(i-1)*10].stale:=2;
                if i+dlugosc<10 then plansza[j+(dlugosc+i)*10].stale:=2;
                {for iterator:=i to dlugosc-1+i do
                begin
                  plansza[j+iterator*10].stale:=3;
                end;}
              end
              else
              begin
                k:=i-1;
                if i=0 then
                begin
                  if j+dlugosc=10 then
                  begin
                    for l:=j-1 to dlugosc+j-1 do
                    begin
                      plansza[l+(i+1)*10].stale:=2;
                    end;
                  end
                  else if j=0 then
                  begin
                    for l:=j to dlugosc+j do
                    begin
                      plansza[l+(i+1)*10].stale:=2;
                    end;
                  end
                  else
                  begin
                    for l:=j-1 to dlugosc+j do
                    begin
                      plansza[l+(i+1)*10].stale:=2;
                    end;
                  end;
                end
                else if i=9 then
                begin
                  if j=0 then
                  begin
                    for l:=j to dlugosc+j do
                    begin
                      plansza[l+(i-1)*10].stale:=2;
                    end;
                    plansza[j+dlugosc+i*10].stale:=2;
                  end
                  else if j+dlugosc-1=9 then
                  begin
                    for l:=j-1 to dlugosc+j-1 do
                    begin
                      plansza[l+(i-1)*10].stale:=2;
                    end;
                    plansza[j+i*10].stale:=2;
                  end
                  else
                  begin
                    for l:=j-1 to dlugosc+j do
                    begin
                      plansza[l+(i-1)*10].stale:=2;
                    end;
                    plansza[j+dlugosc+i*10].stale:=2;
                    plansza[j-1+i*10].stale:=2;
                  end;
                end
                else
                begin
                  if j+dlugosc=10 then
                  begin
                    while k<=i+1 do
                    begin
                      for l:=j-1 to dlugosc+j-1 do
                      begin
                        plansza[l+k*10].stale:=2;
                      end;
                    k:=k+2;
                    end;
                  end
                  else if j=0 then
                  begin
                    while k<=i+1 do
                    begin
                      for l:=j to dlugosc+j do
                      begin
                        plansza[l+k*10].stale:=2;
                      end;
                    k:=k+2;
                    end;
                  end
                  else
                  begin
                    while k<=i+1 do
                    begin
                      for l:=j-1 to dlugosc+j do
                      begin
                        plansza[l+k*10].stale:=2;
                      end;
                    k:=k+2;
                    end;
                  end;
                end;
                if j>0 then plansza[j-1+i*10].stale:=2;
                if j+dlugosc<10 then plansza[j+dlugosc+i*10].stale:=2;
                {for iterator:=j to dlugosc-1+j do
                begin
                  plansza[iterator+i*10].stale:=3;
                end;}
              end;
end;

function czy_zatopiony(var plansza:array of pole;i,j:word):boolean;
var
  dlugosc1,dlugosc2,orientacja,iterator:word;
  trafiony_zatopiony:boolean;
begin
  orientacja:=0;
  if j=0 then
  begin
    if i=0 then
    begin
      if (plansza[j+(i+1)*10].stale=1) or (plansza[j+(i+1)*10].stale=3) then
      begin
        orientacja:=1;
      end
      else if (plansza[j+1+i*10].stale=1) or (plansza[j+1+i*10].stale=3) then
      begin
        orientacja:=2;
      end
      else
      begin
        settextstyle(defaultfont,horizdir,2);
        outtextxy(0,0,'Trafiony-zatopiony');
        obrysowanie(plansza,1,1,i,j);
        czy_zatopiony:=true;
        delay(750);
        //cleardevice;
        exit;
      end;
    end
    else if i=9 then
    begin
      if (plansza[j+(i-1)*10].stale=1) or (plansza[j+(i-1)*10].stale=3) then
      begin
        orientacja:=1;
      end
      else if (plansza[j+1+i*10].stale=1) or (plansza[j+1+i*10].stale=3) then
      begin
        orientacja:=2;
      end
      else
      begin
        settextstyle(defaultfont,horizdir,2);
        outtextxy(0,0,'Trafiony-zatopiony');
        obrysowanie(plansza,1,1,i,j);
        czy_zatopiony:=true;
        delay(750);
        //cleardevice;
        exit;
      end;
    end
    else
    begin
      if (plansza[j+(i-1)*10].stale=1) or (plansza[j+(i-1)*10].stale=3) or (plansza[j+(i+1)*10].stale=1) or (plansza[j+(i+1)*10].stale=3) then
      begin
        orientacja:=1;
      end
      else if (plansza[j+1+i*10].stale=1) or (plansza[j+1+i*10].stale=3) then
      begin
        orientacja:=2;
      end
      else
      begin
        settextstyle(defaultfont,horizdir,2);
        outtextxy(0,0,'Trafiony-zatopiony');
        obrysowanie(plansza,1,1,i,j);
        czy_zatopiony:=true;
        delay(750);
        //cleardevice;
        exit;
      end;
    end;
  end
  else if j=9 then
  begin
    if i=0 then
    begin
      if (plansza[j+(i+1)*10].stale=1) or (plansza[j+(i+1)*10].stale=3) then
      begin
        orientacja:=1;
      end
      else if (plansza[j-1+i*10].stale=1) or (plansza[j-1+i*10].stale=3) then
      begin
        orientacja:=2;
      end
      else
      begin
        settextstyle(defaultfont,horizdir,2);
        outtextxy(0,0,'Trafiony-zatopiony');
        obrysowanie(plansza,1,1,i,j);
        czy_zatopiony:=true;
        delay(750);
        //cleardevice;
        exit;
      end;
    end
    else if i=9 then
    begin
      if (plansza[j+(i-1)*10].stale=1) or (plansza[j+(i-1)*10].stale=3) then
      begin
        orientacja:=1;
      end
      else if (plansza[j-1+i*10].stale=1) or (plansza[j-1+i*10].stale=3) then
      begin
        orientacja:=2;
      end
      else
      begin
        settextstyle(defaultfont,horizdir,2);
        outtextxy(0,0,'Trafiony-zatopiony');
        obrysowanie(plansza,1,1,i,j);
        czy_zatopiony:=true;
        delay(750);
        //cleardevice;
        exit;
      end;
    end
    else
    begin
      if (plansza[j+(i-1)*10].stale=1) or (plansza[j+(i-1)*10].stale=3) or (plansza[j+(i+1)*10].stale=1) or (plansza[j+(i+1)*10].stale=3) then
      begin
        orientacja:=1;
      end
      else if (plansza[j-1+i*10].stale=1) or (plansza[j-1+i*10].stale=3) then
      begin
        orientacja:=2;
      end
      else
      begin
        settextstyle(defaultfont,horizdir,2);
        outtextxy(0,0,'Trafiony-zatopiony');
        obrysowanie(plansza,1,1,i,j);
        czy_zatopiony:=true;
        delay(750);
        //cleardevice;
        exit;
      end;
    end;
  end
  else
  begin
    if i=0 then
    begin
      if (plansza[j+(i+1)*10].stale=1) or (plansza[j+(i+1)*10].stale=3) then
      begin
        orientacja:=1;
      end
      else if (plansza[j-1+i*10].stale=1) or (plansza[j-1+i*10].stale=3) or (plansza[j+1+i*10].stale=1) or (plansza[j+1+i*10].stale=3) then
      begin
        orientacja:=2;
      end
      else
      begin
        settextstyle(defaultfont,horizdir,2);
        outtextxy(0,0,'Trafiony-zatopiony');
        obrysowanie(plansza,1,1,i,j);
        czy_zatopiony:=true;
        delay(750);
        //cleardevice;
        exit;
      end;
    end
    else if i=9 then
    begin
      if (plansza[j+(i-1)*10].stale=1) or (plansza[j+(i-1)*10].stale=3) then
      begin
        orientacja:=1;
      end
      else if (plansza[j-1+i*10].stale=1) or (plansza[j-1+i*10].stale=3) or (plansza[j+1+i*10].stale=1) or (plansza[j+1+i*10].stale=3) then
      begin
        orientacja:=2;
      end
      else
      begin
        obrysowanie(plansza,1,1,i,j);
        settextstyle(defaultfont,horizdir,2);
        outtextxy(0,0,'Trafiony-zatopiony');
        czy_zatopiony:=true;
        delay(750);
        //cleardevice;
        exit;
      end;
    end
    else
    begin
      if (plansza[j+(i-1)*10].stale=1) or (plansza[j+(i-1)*10].stale=3) or (plansza[j+(i+1)*10].stale=1) or (plansza[j+(i+1)*10].stale=3) then
      begin
        orientacja:=1;
      end
      else if (plansza[j-1+i*10].stale=1) or (plansza[j-1+i*10].stale=3) or (plansza[j+1+i*10].stale=1) or (plansza[j+1+i*10].stale=3) then
      begin
        orientacja:=2;
      end
      else
      begin
        settextstyle(defaultfont,horizdir,2);
        outtextxy(0,0,'Trafiony-zatopiony');
        obrysowanie(plansza,1,1,i,j);
        czy_zatopiony:=true;
        delay(750);
        //cleardevice;
        exit;
      end;
    end;
  end;
  if orientacja=1 then
  begin
    dlugosc1:=0;
    dlugosc2:=0;
    if i=0 then
    begin
      for iterator:=i to 9 do
      begin
        if (plansza[j+iterator*10].stale=1)or(plansza[j+iterator*10].stale=3) then
        begin
          inc(dlugosc1);
        end
        else
        begin
          break;
        end;
      end;
    end
                else if i=9 then
                begin
                for iterator:=i downto 0 do
                begin
                  if (plansza[j+iterator*10].stale=1)or(plansza[j+iterator*10].stale=3) then
                  begin
                    inc(dlugosc2);
                  end
                  else
                  begin
                    break;
                  end;
                end;
                i:=i-dlugosc2+1;
                end
                else
                begin

                for iterator:=i to 9 do
                begin
                  if (plansza[j+iterator*10].stale=1)or(plansza[j+iterator*10].stale=3) then
                  begin
                    inc(dlugosc1);
                  end
                  else
                  begin
                    break;
                  end;
                end;

                for iterator:=i downto 0 do
                begin
                  if (plansza[j+iterator*10].stale=1)or(plansza[j+iterator*10].stale=3) then
                  begin
                    inc(dlugosc2);
                  end
                  else
                  begin
                    break;
                  end;
                end;
                i:=i-dlugosc2+1;
                end;


                trafiony_zatopiony:=true;
                for iterator:=i to i+dlugosc1+dlugosc2-2 do
                begin
                  if plansza[j+iterator*10].stale<>3 then
                  begin
                    trafiony_zatopiony:=false;
                    break;
                  end;
                end;
                if trafiony_zatopiony then
                begin
                  czy_zatopiony:=true;
                  obrysowanie(plansza,orientacja,dlugosc1+dlugosc2-1,i,j);
                  settextstyle(defaultfont,horizdir,2);
                  outtextxy(0,0,'Trafiony-zatopiony');
                  delay(750);
                  //cleardevice;
                end
                else
                begin
                  czy_zatopiony:=false;
                  settextstyle(defaultfont,horizdir,2);
                  outtextxy(0,0,'Trafiony');
                  delay(750);
                  //cleardevice;
                end;
              end
              else
              begin
                dlugosc1:=0;
                dlugosc2:=0;
                if j=0 then
                begin
                for iterator:=j to 9 do
                begin
                  if (plansza[iterator+i*10].stale=1)or(plansza[iterator+i*10].stale=3) then
                  begin
                    inc(dlugosc1);
                  end
                  else
                  begin
                    break;
                  end;
                end;

                end
                else if j=9 then
                begin
                for iterator:=j downto 0 do
                begin
                  if (plansza[iterator+i*10].stale=1)or(plansza[iterator+i*10].stale=3) then
                  begin
                    inc(dlugosc2);
                  end
                  else
                  begin
                    break;
                  end;
                end;
                j:=j-dlugosc2+1;
                end
                else
                begin
                for iterator:=j to 9 do
                begin
                  if (plansza[iterator+i*10].stale=1)or(plansza[iterator+i*10].stale=3) then
                  begin
                    inc(dlugosc1);
                  end
                  else
                  begin
                    break;
                  end;
                end;

                for iterator:=j downto 0 do
                begin
                  if (plansza[iterator+i*10].stale=1)or(plansza[iterator+i*10].stale=3) then
                  begin
                    inc(dlugosc2);
                  end
                  else
                  begin
                    break;
                  end;

                end;
                j:=j-dlugosc2+1;
                end;


                trafiony_zatopiony:=true;
                for iterator:=j to j+dlugosc1+dlugosc2-2 do
                begin
                  if plansza[iterator+i*10].stale<>3 then
                  begin
                    trafiony_zatopiony:=false;
                    break;
                  end;
                end;
                if trafiony_zatopiony then
                begin
                  czy_zatopiony:=true;
                  obrysowanie(plansza,orientacja,dlugosc1+dlugosc2-1,i,j);
                  settextstyle(defaultfont,horizdir,2);
                  outtextxy(0,0,'Trafiony-zatopiony');
                  delay(750);
                  //cleardevice;
                end
                else
                begin
                  czy_zatopiony:=false;
                  settextstyle(defaultfont,horizdir,2);
                  outtextxy(0,0,'Trafiony');
                  delay(750);
                  //cleardevice;
                end;
              end;
end;

procedure rozstaw_statki_komputer(var plansza:array of pole);
var
  statki:array [1..10] of statek;
  i,j,iterator,licznik:word;
  czy_wolne:boolean;//do sprawdzenia czy zmiesci sie statek
begin
  for licznik:=1 to 10 do
  begin
    case licznik of
    1:
    begin
      statki[licznik].dlugosc:=4;
      while true do
      begin
        czy_wolne:=true;
        statki[licznik].orientacja:=random(2)+1;
        if statki[licznik].orientacja=1 then
        begin
          i:=random(10);
          if i+statki[licznik].dlugosc>9 then continue;
          j:=random(10);
          for iterator:=i to i+statki[licznik].dlugosc-1 do
          begin
            if plansza[j+iterator*10].stale<>0 then
            begin
              czy_wolne:=false;
              break;
            end;
          end;
        end
        else
        begin
          j:=random(10);
          if j+statki[licznik].dlugosc>9 then continue;
          i:=random(10);
          for iterator:=j to j+statki[licznik].dlugosc-1 do
          begin
            if plansza[iterator+i*10].stale<>0 then
            begin
              czy_wolne:=false;
              break;
            end;
          end;
        end;
        if czy_wolne then
        begin
          break;
        end;
      end;
      obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
      if statki[licznik].orientacja=1 then
      begin
        for iterator:=i to statki[licznik].dlugosc-1+i do
        begin
          plansza[j+iterator*10].stale:=3;
        end;
      end
      else
      begin
        for iterator:=j to statki[licznik].dlugosc-1+j do
        begin
          plansza[iterator+i*10].stale:=3;
        end;
      end;
    end;
    2..3:
    begin
      statki[licznik].dlugosc:=3;
      while true do
      begin
        czy_wolne:=true;
        statki[licznik].orientacja:=random(2)+1;
        if statki[licznik].orientacja=1 then
        begin
          i:=random(10);
          if i+statki[licznik].dlugosc>9 then continue;
          j:=random(10);
          for iterator:=i to i+statki[licznik].dlugosc-1 do
          begin
            if plansza[j+iterator*10].stale<>0 then
            begin
              czy_wolne:=false;
              break;
            end;
          end;
        end
        else
        begin
          j:=random(10);
          if j+statki[licznik].dlugosc>9 then continue;
          i:=random(10);
          for iterator:=j to j+statki[licznik].dlugosc-1 do
          begin
            if plansza[iterator+i*10].stale<>0 then
            begin
              czy_wolne:=false;
              break;
            end;
          end;
        end;
        if czy_wolne then
        begin
          break;
        end;
      end;
      obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
      if statki[licznik].orientacja=1 then
      begin
        for iterator:=i to statki[licznik].dlugosc-1+i do
        begin
          plansza[j+iterator*10].stale:=3;
        end;
      end
      else
      begin
        for iterator:=j to statki[licznik].dlugosc-1+j do
        begin
          plansza[iterator+i*10].stale:=3;
        end;
      end;
    end;
    4..6:
    begin
      statki[licznik].dlugosc:=2;
      while true do
      begin
        czy_wolne:=true;
        statki[licznik].orientacja:=random(2)+1;
        if statki[licznik].orientacja=1 then
        begin
          i:=random(10);
          if i+statki[licznik].dlugosc>9 then continue;
          j:=random(10);
          for iterator:=i to i+statki[licznik].dlugosc-1 do
          begin
            if plansza[j+iterator*10].stale<>0 then
            begin
              czy_wolne:=false;
              break;
            end;
          end;
        end
        else
        begin
          j:=random(10);
          if j+statki[licznik].dlugosc>9 then continue;
          i:=random(10);
          for iterator:=j to j+statki[licznik].dlugosc-1 do
          begin
            if plansza[iterator+i*10].stale<>0 then
            begin
              czy_wolne:=false;
              break;
            end;
          end;
        end;
        if czy_wolne then
        begin
          break;
        end;
      end;
      obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
      if statki[licznik].orientacja=1 then
      begin
        for iterator:=i to statki[licznik].dlugosc-1+i do
        begin
          plansza[j+iterator*10].stale:=3;
        end;
      end
      else
      begin
        for iterator:=j to statki[licznik].dlugosc-1+j do
        begin
          plansza[iterator+i*10].stale:=3;
        end;
      end;
    end;
    7..10:
    begin
      statki[licznik].dlugosc:=1;
      while true do
      begin
        czy_wolne:=true;
        statki[licznik].orientacja:=random(2)+1;
        i:=random(10);
        j:=random(10);
        if statki[licznik].orientacja=1 then
        begin
          i:=random(10);
          if i+statki[licznik].dlugosc>9 then continue;
          j:=random(10);
          for iterator:=i to i+statki[licznik].dlugosc-1 do
          begin
            if plansza[j+iterator*10].stale<>0 then
            begin
              czy_wolne:=false;
              break;
            end;
          end;
        end
        else
        begin
          j:=random(10);
          if j+statki[licznik].dlugosc>9 then continue;
          i:=random(10);
          for iterator:=j to j+statki[licznik].dlugosc-1 do
          begin
            if plansza[iterator+i*10].stale<>0 then
            begin
              czy_wolne:=false;
              break;
            end;
          end;
        end;
        if czy_wolne then
        begin
          break;
        end;
      end;
      obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
      if statki[licznik].orientacja=1 then
      begin
        for iterator:=i to statki[licznik].dlugosc-1+i do
        begin
          plansza[j+iterator*10].stale:=3;
        end;
      end
      else
      begin
        for iterator:=j to statki[licznik].dlugosc-1+j do
        begin
          plansza[iterator+i*10].stale:=3;
        end;
      end;
    end;
    end;
  end;
end;

procedure rozstaw_statki_gracz(var plansza:array of pole);
var
  statki:array [1..10] of statek;
  i,j,k,l,licznik,iterator:word;
  klawisz:char;
  czy_enter:boolean;
begin
  for licznik:=1 to 10 do
  begin
    case licznik of
    1:
    begin
      statki[licznik].orientacja:=1;
      statki[licznik].dlugosc:=4;
      i:=0;
      j:=0;
      for iterator:=i to statki[licznik].dlugosc-1 do
      begin
        plansza[iterator*10].tmp:=4;
      end;
      cleardevice;
      rysuj(plansza,0,0);
      while true do
      begin
        if keypressed then
        begin
          klawisz:=readkey;
          czy_enter:=true;
          if statki[licznik].orientacja=1 then
          begin
            for iterator:=i to i+statki[licznik].dlugosc-1 do
            begin
              if plansza[j+iterator*10].stale<>0 then czy_enter:=false;
            end;
          end
          else
          begin
            for iterator:=j to j+statki[licznik].dlugosc-1 do
            begin
              if plansza[iterator+i*10].stale<>0 then czy_enter:=false;
            end;
          end;
          if czy_enter then
          begin
          case klawisz of
          #13:
          begin
            if statki[licznik].orientacja=1 then
            begin
              obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
              for iterator:=i to statki[licznik].dlugosc-1+i do
              begin
                plansza[j+iterator*10].stale:=3;
              end;
            end
            else
            begin
              obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
              for iterator:=j to statki[licznik].dlugosc-1+j do
              begin
                plansza[iterator+i*10].stale:=3;
              end;
            end;
            for l:=0 to 9 do
            begin
              for k:=0 to 9 do
              begin
                plansza[k+l*10].tmp:=0;
              end;
            end;
            break;
          end;
          end;
          end;
          case klawisz of
          #32:
          begin
            if (statki[licznik].orientacja=1)and(j+statki[licznik].dlugosc<11) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              if j+statki[licznik].dlugosc<11 then statki[licznik].orientacja:=2;
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(i+statki[licznik].dlugosc<11) then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              if i+statki[licznik].dlugosc<11 then statki[licznik].orientacja:=1;
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end;
          end;
          #75:
          begin
            if j>0 then
            begin
              if statki[licznik].orientacja=1 then
              begin
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=0;
                end;
                dec(j);
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=4;
                end;
              end
              else
              begin
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=0;
                end;
                dec(j);
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=4;
                end;
              end;
            end;
          end;
          #77:
          begin
            if (statki[licznik].orientacja=1)and(j<9) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              inc(j);
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(j+statki[licznik].dlugosc<10)then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              inc(j);
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end;
          end;
          #72:
          begin
            if i>0 then
            begin
              if statki[licznik].orientacja=1 then
              begin
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=0;
                end;
                dec(i);
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=4;
                end;
              end
              else
              begin
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=0;
                end;
                dec(i);
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=4;
                end;
              end;
            end;
          end;
          #80:
          begin
            if (statki[licznik].orientacja=1)and(i+statki[licznik].dlugosc<10) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              inc(i);
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(i<9)then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              inc(i);
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end;
          end;
          end;
        cleardevice;
        rysuj(plansza,0,0);
        end;
    end;
    end;
    2..3:
    begin
      statki[licznik].orientacja:=1;
      statki[licznik].dlugosc:=3;
      i:=0;
      j:=0;
      for iterator:=i to statki[licznik].dlugosc-1 do
      begin
        plansza[iterator*10].tmp:=4;
      end;
      cleardevice;
      rysuj(plansza,0,0);
      while true do
      begin
        if keypressed then
        begin
          klawisz:=readkey;
          czy_enter:=true;
          if statki[licznik].orientacja=1 then
          begin
            for iterator:=i to i+statki[licznik].dlugosc-1 do
            begin
              if plansza[j+iterator*10].stale<>0 then czy_enter:=false;
            end;
          end
          else
          begin
            for iterator:=j to j+statki[licznik].dlugosc-1 do
            begin
              if plansza[iterator+i*10].stale<>0 then czy_enter:=false;
            end;
          end;
          if czy_enter then
          begin
          case klawisz of
          #13:
          begin
            if statki[licznik].orientacja=1 then
            begin
              obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
              for iterator:=i to statki[licznik].dlugosc-1+i do
              begin
                plansza[j+iterator*10].stale:=3;
              end;
            end
            else
            begin
              obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
              for iterator:=j to statki[licznik].dlugosc-1+j do
              begin
                plansza[iterator+i*10].stale:=3;
              end;
            end;
            for l:=0 to 9 do
            begin
              for k:=0 to 9 do
              begin
                plansza[k+l*10].tmp:=0;
              end;
            end;
            break;
          end;
          end;
          end;
          case klawisz of
          #32:
          begin
            if (statki[licznik].orientacja=1)and(j+statki[licznik].dlugosc<11) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              if j+statki[licznik].dlugosc<11 then statki[licznik].orientacja:=2;
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(i+statki[licznik].dlugosc<11) then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              if i+statki[licznik].dlugosc<11 then statki[licznik].orientacja:=1;
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end;
          end;
          #75:
          begin
            if j>0 then
            begin
              if statki[licznik].orientacja=1 then
              begin
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=0;
                end;
                dec(j);
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=4;
                end;
              end
              else
              begin
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=0;
                end;
                dec(j);
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=4;
                end;
              end;
            end;
          end;
          #77:
          begin
            if (statki[licznik].orientacja=1)and(j<9) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              inc(j);
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(j+statki[licznik].dlugosc<10)then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              inc(j);
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end;
          end;
          #72:
          begin
            if i>0 then
            begin
              if statki[licznik].orientacja=1 then
              begin
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=0;
                end;
                dec(i);
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=4;
                end;
              end
              else
              begin
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=0;
                end;
                dec(i);
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=4;
                end;
              end;
            end;
          end;
          #80:
          begin
            if (statki[licznik].orientacja=1)and(i+statki[licznik].dlugosc<10) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              inc(i);
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(i<9)then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              inc(i);
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end;
          end;
          end;
        cleardevice;
        rysuj(plansza,0,0);
        end;
    end;
    end;
    4..6:
    begin
      statki[licznik].orientacja:=1;
      statki[licznik].dlugosc:=2;
      i:=0;
      j:=0;
      for iterator:=i to statki[licznik].dlugosc-1 do
      begin
        plansza[iterator*10].tmp:=4;
      end;
      cleardevice;
      rysuj(plansza,0,0);
      while true do
      begin
        if keypressed then
        begin
          klawisz:=readkey;
          czy_enter:=true;
          if statki[licznik].orientacja=1 then
          begin
            for iterator:=i to i+statki[licznik].dlugosc-1 do
            begin
              if plansza[j+iterator*10].stale<>0 then czy_enter:=false;
            end;
          end
          else
          begin
            for iterator:=j to j+statki[licznik].dlugosc-1 do
            begin
              if plansza[iterator+i*10].stale<>0 then czy_enter:=false;
            end;
          end;
          if czy_enter then
          begin
          case klawisz of
          #13:
          begin
            if statki[licznik].orientacja=1 then
            begin
              obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
              for iterator:=i to statki[licznik].dlugosc-1+i do
              begin
                plansza[j+iterator*10].stale:=3;
              end;
            end
            else
            begin
              obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
              for iterator:=j to statki[licznik].dlugosc-1+j do
              begin
                plansza[iterator+i*10].stale:=3;
              end;
            end;
            for l:=0 to 9 do
            begin
              for k:=0 to 9 do
              begin
                plansza[k+l*10].tmp:=0;
              end;
            end;
            break;
          end;
          end;
          end;
          case klawisz of
          #32:
          begin
            if (statki[licznik].orientacja=1)and(j+statki[licznik].dlugosc<11) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              if j+statki[licznik].dlugosc<11 then statki[licznik].orientacja:=2;
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(i+statki[licznik].dlugosc<11) then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              if i+statki[licznik].dlugosc<11 then statki[licznik].orientacja:=1;
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end;
          end;
          #75:
          begin
            if j>0 then
            begin
              if statki[licznik].orientacja=1 then
              begin
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=0;
                end;
                dec(j);
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=4;
                end;
              end
              else
              begin
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=0;
                end;
                dec(j);
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=4;
                end;
              end;
            end;
          end;
          #77:
          begin
            if (statki[licznik].orientacja=1)and(j<9) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              inc(j);
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(j+statki[licznik].dlugosc<10)then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              inc(j);
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end;
          end;
          #72:
          begin
            if i>0 then
            begin
              if statki[licznik].orientacja=1 then
              begin
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=0;
                end;
                dec(i);
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=4;
                end;
              end
              else
              begin
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=0;
                end;
                dec(i);
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=4;
                end;
              end;
            end;
          end;
          #80:
          begin
            if (statki[licznik].orientacja=1)and(i+statki[licznik].dlugosc<10) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              inc(i);
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(i<9)then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              inc(i);
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end;
          end;
          end;
        cleardevice;
        rysuj(plansza,0,0);
        end;
    end;
    end;
    7..10:
    begin
      statki[licznik].orientacja:=1;
      statki[licznik].dlugosc:=1;
      i:=0;
      j:=0;
      for iterator:=i to statki[licznik].dlugosc-1 do
      begin
        plansza[iterator*10].tmp:=4;
      end;
      cleardevice;
      rysuj(plansza,0,0);
      while true do
      begin
        if keypressed then
        begin
          klawisz:=readkey;
          czy_enter:=true;
          if statki[licznik].orientacja=1 then
          begin
            for iterator:=i to i+statki[licznik].dlugosc-1 do
            begin
              if plansza[j+iterator*10].stale<>0 then czy_enter:=false;
            end;
          end
          else
          begin
            for iterator:=j to j+statki[licznik].dlugosc-1 do
            begin
              if plansza[iterator+i*10].stale<>0 then czy_enter:=false;
            end;
          end;
          if czy_enter then
          begin
          case klawisz of
          #13:
          begin
            if statki[licznik].orientacja=1 then
            begin
              obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
              for iterator:=i to statki[licznik].dlugosc-1+i do
              begin
                plansza[j+iterator*10].stale:=3;
              end;
            end
            else
            begin
              obrysowanie(plansza,statki[licznik].orientacja,statki[licznik].dlugosc,i,j);
              for iterator:=j to statki[licznik].dlugosc-1+j do
              begin
                plansza[iterator+i*10].stale:=3;
              end;
            end;
            for l:=0 to 9 do
            begin
              for k:=0 to 9 do
              begin
                plansza[k+l*10].tmp:=0;
              end;
            end;
            break;
          end;
          end;
          end;
          case klawisz of
          #32:
          begin
            if (statki[licznik].orientacja=1)and(j+statki[licznik].dlugosc<11) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              if j+statki[licznik].dlugosc<11 then statki[licznik].orientacja:=2;
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(i+statki[licznik].dlugosc<11) then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              if i+statki[licznik].dlugosc<11 then statki[licznik].orientacja:=1;
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end;
          end;
          #75:
          begin
            if j>0 then
            begin
              if statki[licznik].orientacja=1 then
              begin
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=0;
                end;
                dec(j);
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=4;
                end;
              end
              else
              begin
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=0;
                end;
                dec(j);
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=4;
                end;
              end;
            end;
          end;
          #77:
          begin
            if (statki[licznik].orientacja=1)and(j<9) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              inc(j);
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(j+statki[licznik].dlugosc<10)then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              inc(j);
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end;
          end;
          #72:
          begin
            if i>0 then
            begin
              if statki[licznik].orientacja=1 then
              begin
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=0;
                end;
                dec(i);
                for iterator:=i to i+statki[licznik].dlugosc-1 do
                begin
                  plansza[j+iterator*10].tmp:=4;
                end;
              end
              else
              begin
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=0;
                end;
                dec(i);
                for iterator:=j to j+statki[licznik].dlugosc-1 do
                begin
                  plansza[iterator+i*10].tmp:=4;
                end;
              end;
            end;
          end;
          #80:
          begin
            if (statki[licznik].orientacja=1)and(i+statki[licznik].dlugosc<10) then
            begin
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=0;
              end;
              inc(i);
              for iterator:=i to i+statki[licznik].dlugosc-1 do
              begin
                plansza[j+iterator*10].tmp:=4;
              end;
            end
            else if (statki[licznik].orientacja=2)and(i<9)then
            begin
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=0;
              end;
              inc(i);
              for iterator:=j to j+statki[licznik].dlugosc-1 do
              begin
                plansza[iterator+i*10].tmp:=4;
              end;
            end;
          end;
          end;
        cleardevice;
        rysuj(plansza,0,0);
        end;
    end;
    end;
    end;
  end;
  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      if plansza[j+10*i].stale=2 then plansza[j+10*i].stale:=0;
      if plansza[j+10*i].stale=3 then plansza[j+10*i].stale:=1;
    end;
  end;
end;

procedure intro;
var
  powitanie:string;
begin
  setcolor(red);
  settextstyle(0,0,3);
  powitanie:='Witaj w grze Statki!';
  outtextxy(100,getmaxy div 2 - 40,powitanie);
  delay(2000);
  cleardevice;
end;

function koniec:boolean;
var
  klawisz:char;
  licznik:word;
begin
  licznik:=1;
  while true do
  begin
    if keypressed then
    begin
      klawisz:=readkey;
      case klawisz of
      #80:if licznik<2 then inc(licznik);
      #72:if licznik>1 then dec(licznik);
      #13:
      begin
        case licznik of
        1:
        begin
          koniec:=true;
          exit;
        end;
        2:
        begin
          koniec:=false;
          cleardevice;
          exit;
        end;
        end;
      end;
      end;
    end;
    setcolor(white);
    outtextxy((getmaxx-textwidth('WYJSC?'))div 2,getmaxy div 2 - 2*textheight('TAK'),'WYJSC?');
    case licznik of
    1:
    begin
      setcolor(red);
      outtextxy((getmaxx-textwidth('TAK'))div 2,getmaxy div 2,'TAK');
      setcolor(white);
      outtextxy((getmaxx-textwidth('NIE'))div 2,getmaxy div 2 + 2*textheight('TAK'),'NIE');
    end;
    2:
    begin
      setcolor(white);
      outtextxy((getmaxx-textwidth('TAK'))div 2,getmaxy div 2,'TAK');
      setcolor(red);
      outtextxy((getmaxx-textwidth('NIE'))div 2,getmaxy div 2 + 2*textheight('TAK'),'NIE');
    end;
    end;
  end;
end;

procedure pvp;
var
  plansza_gracz1:array [0..99] of pole;
  plansza_gracz2:array [0..99] of pole;
  licznik,i,j,k,l:word;
  klawisz:char;
  czy_wygral:boolean;//do sprawdzenia, ktory gracz wygral
begin
  settextstyle(0,0,3);
  repeat
    outtextxy((getmaxx-textwidth('GRACZ I ROZSTAWIA STATKI')) div 2,getmaxy div 2,'GRACZ I ROZSTAWIA STATKI');
  until keypressed;
  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      plansza_gracz1[j+i*10].stale:=0;
      plansza_gracz1[j+i*10].tmp:=0;
    end;
  end;
  klawisz:=readkey;
  rozstaw_statki_gracz(plansza_gracz1);
  cleardevice;
  settextstyle(0,0,3);
  repeat
    outtextxy((getmaxx-textwidth('GRACZ II ROZSTAWIA STATKI')) div 2,getmaxy div 2,'GRACZ II ROZSTAWIA STATKI');
  until keypressed;
  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      plansza_gracz2[j+i*10].stale:=0;
      plansza_gracz2[j+i*10].tmp:=0;
    end;
  end;
  klawisz:=readkey;
  rozstaw_statki_gracz(plansza_gracz2);
  cleardevice;
  settextstyle(0,0,3);
  outtextxy((getmaxx-textwidth('ROZPOCZYNA GRACZ NR 1')) div 2,getmaxy div 2,'ROZPOCZYNA GRACZ NR 1');
  repeat until keypressed;
  klawisz:=readkey;
  licznik:=1;
  while true do
  begin
    if licznik mod 2 <> 0 then
    begin
      i:=0;
      j:=0;
      cleardevice;
      plansza_gracz2[0].tmp:=4;
      settextstyle(defaultfont,horizdir,2);
      outtext('GRACZ I');
      rysuj(plansza_gracz2,0,0);
      plansza_gracz2[0].tmp:=0;
      while true do
      begin
        if keypressed then
        begin
          klawisz:=readkey;
          case klawisz of
          #75:if j>0 then dec(j);            //strzalka w lewo
          #77:if j<9 then inc(j);            //strzalka w prawo
          #72:if i>0 then dec(i);            //strzalka w gore
          #80:if i<9 then inc(i);            //strzalka w dol
          #112:
          begin
            cleardevice;
            for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_gracz1[l+k*10].stale=1 then plansza_gracz1[l+k*10].tmp:=4;
              end;
            end;
            rysuj(plansza_gracz1,0,0);
            for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_gracz1[l+k*10].stale=1 then plansza_gracz1[l+k*10].tmp:=0;
              end;
            end;
            settextstyle(defaultfont,horizdir,2);
            outtext('GRACZ I');
            moveto(15,12*30);
            settextstyle(defaultfont,horizdir,1);
            outtext('Nacisinij dowolny klawisz, zeby powrocic...');
            repeat until keypressed;
            klawisz:=readkey;
          end;
          #13:
          begin
            case plansza_gracz2[j+i*10].stale of
              0:
              begin
                plansza_gracz2[j+i*10].stale:=2;
                cleardevice;
                settextstyle(defaultfont,horizdir,2);
                outtext('GRACZ I');
                rysuj(plansza_gracz2,0,0);
                moveto(15,12*30);
                settextstyle(defaultfont,horizdir,1);
                outtext('Nacisnij dowolny klawisz...');
                repeat until keypressed;
                klawisz:=readkey;
                break;
              end;
              1:
              begin
                cleardevice;
                plansza_gracz2[j+i*10].stale:=3;
                rysuj(plansza_gracz2,0,0);
                czy_zatopiony(plansza_gracz2,i,j);
                czy_wygral:=true;
                for k:=0 to 9 do
                begin
                  for l:=0 to 9 do
                  begin
                    if plansza_gracz2[l+k*10].stale=1 then
                    begin
                      czy_wygral:=false;
                      break;
                    end;
                  end;
                end;
                if czy_wygral then
                begin
                  cleardevice;
                  settextstyle(defaultfont,horizdir,2);
                  outtextxy((getmaxx-textwidth('WYGRAL GRACZ NR 1')) div 2,getmaxy div 2,'WYGRAL GRACZ NR 1');
                  settextstyle(defaultfont,horizdir,1);
                  outtextxy((getmaxx-textwidth('Nacisnij dowolny klawisz, zeby kontynuowac...')) div 2,getmaxy div 2 + 4*textheight('WYGRAL GRACZ NR 1'),'Nacisnij dowolny klawisz, zeby kontynuowac...');
                  repeat until keypressed;
                  klawisz:=readkey;
                  cleardevice;
                  settextstyle(0,0,3);
                  exit;
                end;
              end;
            end;
          end;
          end;
          plansza_gracz2[j+10*i].tmp:=4;
          cleardevice;
          settextstyle(defaultfont,horizdir,2);
          outtext('GRACZ I');
          rysuj(plansza_gracz2,0,0);
          moveto(15,12*30);
          settextstyle(defaultfont,horizdir,1);
          outtext('Nacisnsij p by podejrzec swoja plansze.');
          plansza_gracz2[j+10*i].tmp:=0;
        end;
      end;
    end
    else
    begin
      i:=0;
      j:=0;
      cleardevice;
      plansza_gracz1[0].tmp:=4;
      settextstyle(defaultfont,horizdir,2);
      outtext('GRACZ II');
      rysuj(plansza_gracz1,0,0);
      plansza_gracz1[0].tmp:=0;
      while true do
      begin
        if keypressed then
        begin
          klawisz:=readkey;
          case klawisz of
          #75:if j>0 then dec(j);            //strzalka w lewo
          #77:if j<9 then inc(j);            //strzalka w prawo
          #72:if i>0 then dec(i);            //strzalka w gore
          #80:if i<9 then inc(i);            //strzalka w dol
          #112:
          begin
            cleardevice;
            settextstyle(defaultfont,horizdir,2);
            outtext('GRACZ II');
            for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_gracz2[l+k*10].stale=1 then plansza_gracz2[l+k*10].tmp:=4;
              end;
            end;
            rysuj(plansza_gracz2,0,0);
            for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_gracz2[l+k*10].stale=1 then plansza_gracz2[l+k*10].tmp:=0;
              end;
            end;
            moveto(15,12*30);
            settextstyle(defaultfont,horizdir,1);
            outtext('Nacisinij dowolny klawisz, zeby powrocic...');
            repeat until keypressed;
            klawisz:=readkey;
          end;
          #13:
          begin
            case plansza_gracz1[j+i*10].stale of
              0:
              begin
                plansza_gracz1[j+i*10].stale:=2;
                cleardevice;
                settextstyle(defaultfont,horizdir,2);
                outtext('GRACZ II');
                rysuj(plansza_gracz1,0,0);
                moveto(15,12*30);
                settextstyle(defaultfont,horizdir,1);
                outtext('Nacisnij dowolny klawisz...');
                repeat until keypressed;
                klawisz:=readkey;
                break;
              end;
              1:
              begin
                cleardevice;
                plansza_gracz1[j+i*10].stale:=3;
                rysuj(plansza_gracz1,0,0);
                czy_zatopiony(plansza_gracz1,i,j);
                czy_wygral:=true;
                for k:=0 to 9 do
                begin
                  for l:=0 to 9 do
                  begin
                    if plansza_gracz2[l+k*10].stale=1 then
                    begin
                      czy_wygral:=false;
                      break;
                    end;
                  end;
                end;
                if czy_wygral then
                begin
                  cleardevice;
                  settextstyle(defaultfont,horizdir,2);
                  outtextxy((getmaxx-textwidth('WYGRAL GRACZ NR 2')) div 2,getmaxy div 2,'WYGRAL GRACZ NR 2');
                  settextstyle(defaultfont,horizdir,1);
                  outtextxy((getmaxx-textwidth('Nacisnij dowolny klawisz, zeby kontynuowac...')) div 2,getmaxy div 2 + 4*textheight('WYGRAL GRACZ NR 2'),'Nacisnij dowolny klawisz, zeby kontynuowac...');
                  repeat until keypressed;
                  klawisz:=readkey;
                  cleardevice;
                  settextstyle(0,0,3);
                  exit;
                end;
              end;
            end;
          end;
          end;
          plansza_gracz1[j+10*i].tmp:=4;
          cleardevice;
          settextstyle(defaultfont,horizdir,2);
          outtext('GRACZ II');
          rysuj(plansza_gracz1,0,0);
          moveto(15,12*30);
          settextstyle(defaultfont,horizdir,1);
          outtext('Nacisnsij p by podejrzec swoja plansze.');
          plansza_gracz1[j+10*i].tmp:=0;
        end;
      end;
    end;
    inc(licznik);
  end;

  delay(3000);
  cleardevice;

end;

procedure pve;
var
  plansza_gracz1:array [0..99] of pole;
  plansza_komputer:array [0..99] of pole;
  zapamietane_i,zapamietane_j,orientacja,i,j,k,l,iterator:word;
  licznik:integer;
  klawisz:char;
  czy_wygral,statek_napoczety,przerwanie:boolean;
begin
  statek_napoczety:=false;
  randomize;
  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      plansza_gracz1[j+i*10].stale:=0;
      plansza_gracz1[j+i*10].tmp:=0;
    end;
  end;
  rozstaw_statki_gracz(plansza_gracz1);
  cleardevice;
  rysuj(plansza_gracz1,0,0);
  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      plansza_komputer[j+i*10].stale:=0;
      plansza_komputer[j+i*10].tmp:=0;
    end;
  end;
  rozstaw_statki_komputer(plansza_komputer);
  cleardevice;
  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      if plansza_komputer[j+i*10].stale=3 then plansza_komputer[j+i*10].stale:=1;
      if plansza_komputer[j+i*10].stale=2 then plansza_komputer[j+i*10].stale:=0;
      if plansza_gracz1[j+i*10].stale=3 then plansza_gracz1[j+i*10].stale:=1;
      if plansza_gracz1[j+i*10].stale=2 then plansza_gracz1[j+i*10].stale:=0;
    end;
  end;
  licznik:=1;
  while true do
  begin
    if licznik mod 2 <> 0 then
    begin
      i:=0;
      j:=0;
      plansza_komputer[0].tmp:=4;
      rysuj(plansza_komputer,0,0);
      plansza_komputer[0].tmp:=0;

      for k:=0 to 9 do
      begin
        for l:=0 to 9 do
        begin
          if plansza_gracz1[l+k*10].stale=1 then plansza_gracz1[l+k*10].tmp:=4;
        end;
      end;
      rysuj(plansza_gracz1,12*szerokosc,0);
      for k:=0 to 9 do
      begin
        for l:=0 to 9 do
        begin
          if plansza_gracz1[l+k*10].stale=1 then plansza_gracz1[l+k*10].tmp:=0;
        end;
      end;
      while true do
      begin
        if keypressed then
        begin
          klawisz:=readkey;
          case klawisz of
          #75:if j>0 then dec(j);            //strzalka w lewo
          #77:if j<9 then inc(j);            //strzalka w prawo
          #72:if i>0 then dec(i);            //strzalka w gore
          #80:if i<9 then inc(i);            //strzalka w dol
          #112:
          begin
            cleardevice;
            for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_gracz1[l+k*10].stale=1 then plansza_gracz1[l+k*10].tmp:=4;
              end;
            end;
            rysuj(plansza_gracz1,0,0);
            for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_gracz1[l+k*10].stale=1 then plansza_gracz1[l+k*10].tmp:=0;
              end;
            end;
            {for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_komputer[l+k*10].stale=1 then plansza_komputer[l+k*10].tmp:=4;
              end;
            end;
            rysuj(plansza_komputer);
            for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_komputer[l+k*10].stale=1 then plansza_komputer[l+k*10].tmp:=0;
              end;
            end;}
            moveto(15,12*30);
            settextstyle(defaultfont,horizdir,1);
            outtext('Nacisinij dowolny klawisz, zeby powrocic...');
            repeat until keypressed;
          end;
          #13:
          begin
            case plansza_komputer[j+i*10].stale of
            0:
            begin
              plansza_komputer[j+i*10].stale:=2;
              break;
            end;
            1:
            begin
              plansza_komputer[j+i*10].stale:=3;
              czy_zatopiony(plansza_komputer,i,j);
              czy_wygral:=true;
              for k:=0 to 9 do
              begin
                for l:=0 to 9 do
                begin
                  if plansza_komputer[l+k*10].stale=1 then
                  begin
                    czy_wygral:=false;
                    break;
                  end;
                end;
              end;
              if czy_wygral then
              begin
                cleardevice;
                settextstyle(defaultfont,horizdir,2);
                outtextxy((getmaxx-textwidth('WYGRAL GRACZ')) div 2,getmaxy div 2,'WYGRAL GRACZ');
                settextstyle(defaultfont,horizdir,1);
                outtextxy((getmaxx-textwidth('Nacisnij dowolny klawisz, zeby kontynuowac...')) div 2,getmaxy div 2 + 4*textheight('WYGRAL GRACZ'),'Nacisnij dowolny klawisz, zeby kontynuowac...');
                repeat until keypressed;
                klawisz:=readkey;
                cleardevice;
                settextstyle(0,0,3);
                exit;
              end;
            end;
            end;
          end;
          end;
          cleardevice;
          plansza_komputer[j+i*10].tmp:=4;
          rysuj(plansza_komputer,0,0);
          for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_gracz1[l+k*10].stale=1 then plansza_gracz1[l+k*10].tmp:=4;
              end;
            end;
            rysuj(plansza_gracz1,12*szerokosc,0);
            for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_gracz1[l+k*10].stale=1 then plansza_gracz1[l+k*10].tmp:=0;
              end;
            end;
          plansza_komputer[j+i*10].tmp:=0;
        end;
      end;
    end
    else
    begin
      while true do
      begin
        if statek_napoczety then
        begin
          if czy_zatopiony(plansza_gracz1,zapamietane_i,zapamietane_j) then
          begin
            statek_napoczety:=false;
            continue;
          end;
          orientacja:=0;
          if (plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=3) or (plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=3) then orientacja:=1;
          if (plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=3) or (plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=3) then orientacja:=2;
          if orientacja=0 then
          begin
            if zapamietane_i=0 then
            begin
              if zapamietane_j=0 then
              begin
                if (plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end;
              end
              else if zapamietane_j=9 then
              begin
                if (plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end;
              end
              else
              begin
                if (plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end;
              end;
            end
            else if zapamietane_i=9 then
            begin
              if zapamietane_j=0 then
              begin
                if (plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end;
              end
              else if zapamietane_j=9 then
              begin
                if (plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end;
              end
              else
              begin
                if (plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end;
              end;
            end
            else
            begin
              if zapamietane_j=0 then
              begin
                if (plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end;
              end
              else if zapamietane_j=9 then
              begin
                if (plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end;
              end
              else
              begin
                if (plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i-1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>3)and(plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+(zapamietane_i+1)*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j+1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end
                else if (plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>3)and(plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale<>2) then
                begin
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=1 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=3;
                    continue;
                  end;
                  if plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale=0 then
                  begin
                    plansza_gracz1[zapamietane_j-1+zapamietane_i*10].stale:=2;
                    break;
                  end;
                end;
              end;
            end;

          end
          else if orientacja=1 then
          begin
            przerwanie:=false;
            for iterator:=zapamietane_i to 9 do
            begin
              if plansza_gracz1[zapamietane_j+iterator*10].stale=2 then
              begin
                break;
              end
              else if plansza_gracz1[zapamietane_j+iterator*10].stale=0 then
              begin
                plansza_gracz1[zapamietane_j+iterator*10].stale:=2;
                przerwanie:=true;
                break;
              end
              else if plansza_gracz1[zapamietane_j+iterator*10].stale=1 then
              begin
                plansza_gracz1[zapamietane_j+iterator*10].stale:=3;
                if czy_zatopiony(plansza_gracz1,zapamietane_i,zapamietane_j) then
                begin
                  statek_napoczety:=false;
                  continue;
                end;
              end;
            end;
            if przerwanie then break;
            for iterator:=zapamietane_i downto 0 do
            begin
              if plansza_gracz1[zapamietane_j+iterator*10].stale=2 then
              begin
                break;
              end
              else if plansza_gracz1[zapamietane_j+iterator*10].stale=0 then
              begin
                plansza_gracz1[zapamietane_j+iterator*10].stale:=2;
                przerwanie:=true;
                break;
              end
              else if plansza_gracz1[zapamietane_j+iterator*10].stale=1 then
              begin
                plansza_gracz1[zapamietane_j+iterator*10].stale:=3;
                if czy_zatopiony(plansza_gracz1,zapamietane_i,zapamietane_j) then
                begin
                  statek_napoczety:=false;
                  continue;
                end;
              end;
            end;
            if przerwanie then break;
          end
          else if orientacja=2 then
          begin
            przerwanie:=false;
            for iterator:=zapamietane_j to 9 do
            begin
              if plansza_gracz1[iterator+zapamietane_i*10].stale=2 then
              begin
                break;
              end
              else if plansza_gracz1[iterator+zapamietane_i*10].stale=0 then
              begin
                plansza_gracz1[iterator+zapamietane_i*10].stale:=2;
                przerwanie:=true;
                break;
              end
              else if plansza_gracz1[iterator+zapamietane_i*10].stale=1 then
              begin
                plansza_gracz1[iterator+zapamietane_i*10].stale:=3;
                if czy_zatopiony(plansza_gracz1,zapamietane_i,zapamietane_j) then
                begin
                  statek_napoczety:=false;
                  continue;
                end;
              end;
            end;
            if przerwanie then break;
            for iterator:=zapamietane_j downto 0 do
            begin
              if plansza_gracz1[iterator+zapamietane_i*10].stale=2 then
              begin
                break;
              end
              else if plansza_gracz1[iterator+zapamietane_i*10].stale=0 then
              begin
                plansza_gracz1[iterator+zapamietane_i*10].stale:=2;
                przerwanie:=true;
                break;
              end
              else if plansza_gracz1[iterator+zapamietane_i*10].stale=1 then
              begin
                plansza_gracz1[iterator+zapamietane_i*10].stale:=3;
                if czy_zatopiony(plansza_gracz1,zapamietane_i,zapamietane_j) then
                begin
                  statek_napoczety:=false;
                  continue;
                end;
              end;
            end;
            if przerwanie then break;
          end;
        end
        else
        begin
          i:=random(10);
          j:=random(10);
          if plansza_gracz1[j+i*10].stale=0 then
          begin
            plansza_gracz1[j+i*10].stale:=2;
            break;
          end
          else if plansza_gracz1[j+i*10].stale=1 then
          begin
            statek_napoczety:=true;
            zapamietane_i:=i;
            zapamietane_j:=j;
            plansza_gracz1[j+i*10].stale:=3;
            czy_zatopiony(plansza_gracz1,i,j);
            czy_wygral:=true;
            for k:=0 to 9 do
            begin
              for l:=0 to 9 do
              begin
                if plansza_gracz1[l+k*10].stale=1 then
                begin
                  czy_wygral:=false;
                  break;
                end;
              end;
            end;
            if czy_wygral then
            begin
              cleardevice;
              settextstyle(defaultfont,horizdir,2);
              outtextxy((getmaxx-textwidth('WYGRAL KOMPUTER')) div 2,getmaxy div 2,'WYGRAL KOMPUTER');
              settextstyle(defaultfont,horizdir,1);
              outtextxy((getmaxx-textwidth('Nacisnij dowolny klawisz, zeby kontynuowac...')) div 2,getmaxy div 2 + 4*textheight('WYGRAL KOMPUTER'),'Nacisnij dowolny klawisz, zeby kontynuowac...');
              repeat until keypressed;
              klawisz:=readkey;
              cleardevice;
              settextstyle(0,0,3);
              exit;
            end;
          end;
        end;
      end;
    end;
    inc(licznik);
  end;
end;

procedure menu;
var
  licznik:word;
  klawisz:char;
begin
  settextstyle(0,0,3);
  licznik:=1;
  while true do
  begin
    if keypressed then
    begin
      klawisz:=readkey;
      case klawisz of
      #80:if licznik<3 then inc(licznik);                        //strzalka w dol
      #72:if licznik>1 then dec(licznik);                        //strzalka w gore
      #13:
      begin
        cleardevice;
        case licznik of
        1:pvp;
        2:pve;
        3:
        begin
          if koniec=true then exit;
        end;
        end;
      end;
      end;
    end;

    case licznik of               //ustalnie koloru podswietlenia
    1:
    begin
      setcolor(red);
      outtextxy((getmaxx-textwidth('GRACZ VS GRACZ'))div 2,getmaxy div 2 - 2*textheight('GRACZ VS KOMPUTER'),'GRACZ VS GRACZ');
      setcolor(white);
      outtextxy((getmaxx-textwidth('GRACZ VS KOMPUTER'))div 2,getmaxy div 2,'GRACZ VS KOMPUTER');
      outtextxy((getmaxx-textwidth('WYJSCIE'))div 2,getmaxy div 2 + 2*textheight('GRACZ VS KOMPUTER'),'WYJSCIE');
    end;
    2:
    begin
      setcolor(white);
      outtextxy((getmaxx-textwidth('GRACZ VS GRACZ'))div 2,getmaxy div 2 - 2*textheight('GRACZ VS KOMPUTER'),'GRACZ VS GRACZ');
      setcolor(red);
      outtextxy((getmaxx-textwidth('GRACZ VS KOMPUTER'))div 2,getmaxy div 2,'GRACZ VS KOMPUTER');
      setcolor(white);
      outtextxy((getmaxx-textwidth('WYJSCIE'))div 2,getmaxy div 2 + 2*textheight('GRACZ VS KOMPUTER'),'WYJSCIE');
    end;
    3:
    begin
      setcolor(white);
      outtextxy((getmaxx-textwidth('GRACZ VS GRACZ'))div 2,getmaxy div 2 - 2*textheight('GRACZ VS KOMPUTER'),'GRACZ VS GRACZ');
      outtextxy((getmaxx-textwidth('GRACZ VS KOMPUTER'))div 2,getmaxy div 2,'GRACZ VS KOMPUTER');
      setcolor(red);
      outtextxy((getmaxx-textwidth('WYJSCIE'))div 2,getmaxy div 2 + 2*textheight('GRACZ VS KOMPUTER'),'WYJSCIE');
    end;
    end;
end;
end;

begin
  driver:=VGA;
  mode:=VGAHi;
  initgraph(driver,mode,'');
  intro;
  menu;
end.