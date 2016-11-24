


%macro straaling(datasett =);

data &datasett;
set &datasett;
drop straale oppholdsnr_Straale num_beh Antall_Straale pal_straal kur_straal num;
run;

data &datasett;
set &datasett;

array prosedyre {*} NC:;
  do i=1 to dim(prosedyre);
    if substr(prosedyre{i},1,6) = 'WEOA00' then Straale =1;
    if substr(prosedyre{i},1,6) = 'WEOB05' then Bracky =1;
  end;
run;

data &datasett;
set &datasett;
array diagnose {*} Hdiag: Bdiag: Tdiag:;
do i=1 to dim(diagnose);
	if substr(diagnose{i},1,3) in ('C20','C19') then RectumKreft=1;
	if substr(diagnose{i},1,3) in ('C50') then BrystKreft=1;
end;
run;

proc sort Data=&datasett;
by Straale pid inndato utdato;
run;

data &datasett;
set &datasett;
  by Straale pid inndato utdato;
  if Straale = 1 then do;
    if first.pid=1 then do;
      oppholdsnr_Straale=0;
      num_beh = 1;
    end;
    if first.pid ne 1 and (inndato - lag(utdato)) ge 14 then do;
      oppholdsnr_Straale=0;
      num_beh + 1;
    end;
    oppholdsnr_Straale+1;
  end;
run;

proc sort Data=&datasett;
by descending Straale pid num_beh descending oppholdsnr_Straale;
run;

data &datasett;
set &datasett;
  by descending Straale PID num_beh;
    if straale = 1 then do;
      if first.PID=1 then do;
        Antall_Straale=oppholdsnr_Straale;
        unik_beh = 1;
      end;
      if first.PID ne 1 and num_beh ne lag(num_beh) then do; 
        Antall_Straale=oppholdsnr_Straale;
        unik_beh = 1;
      end;
      Antall_Straale+0;
    end;
run;

/*data tmp;*/
/*set &datasett;*/
/*where unik_pasient = 1;*/
/*run;*/
/**/
/*data skde_arn.straale;*/
/*set tmp;*/
/*run;*/

data &datasett;
set &datasett;
  if Straale = 1 and unik_beh = 1 then do;
    if RectumKreft=1 and Antall_Straale=5 then kur_straal = 1;
    else if BrystKreft=1 and Antall_Straale=15 then kur_straal = 1;
    else if Bracky=1 and Antall_Straale <15 then kur_straal = 1;
    else if antall_Straale le 15 then pal_straal = 1;
    else if antall_Straale gt 15 then kur_straal = 1;
    drop num_beh;
  end;

Drop lag: opph: ant: unik: straale bracky rectum: bryst:;
run;



%mend straaling;