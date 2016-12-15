


%macro straaling(datasett = );

data &datasett;
set &datasett;


array prosedyre {*} NC:;
  do i=1 to dim(prosedyre);
    if substr(prosedyre{i},1,6) = 'WEOA00' then Straale =1;
    if substr(prosedyre{i},1,6) = 'WEOB05' then Bracky =1;
  end;
  if Straale =1 or Bracky =1 then Straale_Beh=1;
run;

data  &datasett;
set  &datasett;

array diagnose {*} Hdiag: Bdiag: Tdiag:;
do i=1 to dim(diagnose);
	if substr(diagnose{i},1,3) in ('C20','C19') then RectumKreft=1;
	if substr(diagnose{i},1,3) in ('C50') then BrystKreft=1;
	if substr(diagnose{i},1,3) in ('C83','C84','C85') then Lymfom=1;
	if substr(diagnose{i},1,3) in ('C34') then Lungekreft=1;
end;
run;

proc sort Data= &datasett;
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
    if first.pid ne 1 and (PID = lag(PID)) and (inndato - lag(utdato)) ge 14 then do;

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


data &datasett;
set &datasett;

if Straale = 1 and unik_beh = 1 then do;
    if RectumKreft=1 and Antall_Straale=5 then kur_behserie = 1;
    else if BrystKreft=1 and Antall_Straale=15 then kur_behserie = 1;
	else if Lungekreft=1 and Antall_Straale=15 then kur_behserie = 1;
	else if Lymfom=1 and Antall_Straale >11 then kur_behserie = 1;
    else if Bracky=1 and Antall_Straale <15 then kur_behserie = 1;
    else if antall_Straale le 15 then pal_behserie = 1;
    else if antall_Straale gt 15 then kur_behserie = 1;
  end;

  if Straale_beh = 1 then do;
    if RectumKreft=1 and Antall_Straale=5 then kur_beh = 1;
    else if BrystKreft=1 and Antall_Straale=15 then kur_beh = 1;
	else if Lungekreft=1 and Antall_Straale=15 then kur_beh = 1;
	else if Lymfom=1 and Antall_Straale >11 then kur_beh = 1;
    else if Bracky=1 and Antall_Straale <15 then kur_beh = 1;
    else if antall_Straale le 15 then pal_beh = 1;
    else if antall_Straale gt 15 then kur_beh = 1;

    drop num_beh;
end;

if pal_behserie = 1 or kur_behserie = 1 then tot_behserie = 1;

run;

proc sort data=&datasett;
	by PID  descending tot_behserie pid inndato utdato;
run;

data &datasett;
set &datasett;

    by pid descending tot_behserie inndato utdato;
	if first.pid and tot_behserie=1 then tot_behs_unik=1;

run;
/**/
/*data &datasett;*/
/*set &datasett;*/
/**/
/**/
/*	if tot_behs_unik = 1 and kur_behserie = 1 then kur_unik = 1;*/
/*	if tot_behs_unik = 1 and pal_behserie = 1 then pal_unik = 1;*/
/**/
/*run;*/

%mend straaling;


/*Cellegift*/

%macro cellegft (datasett = );

data &datasett;
set &datasett;

     array diagnose {*} Hdiag: Bdiag: Tdiag:;
       do i = 1 to dim(diagnose); 
          if substr(diagnose{i},1,1) in ('C') then Kreft=1;
          if substr(diagnose{i},1,2) in ('D0') then Kreft=1;
          if substr(diagnose{i},1,3) in ('B21') then Kreft=1;
     end;

	array takst {*} Normaltariff:;
          do k = 1 to dim(takst);
          if substr (takst {k}, 1,3) in ('126') then Takst_kjemo = 1;
     end;

	if Cyto_1 ne ' ' then NewCyto=1;
	if Cyto_1 = ' ' then NewCyto=0;

	if kreft = 1 and (NewCyto = 1 or Takst_kjemo = 1) then cellegft = 1;

run;

/**/
/*	proc sort data=&datasett;*/
/*		by PID  descending cellegft pid inndato utdato;*/
/*	run;*/
/**/
/*	data &datasett;*/
/*	set &datasett;*/
/*    	by pid descending cellegft inndato utdato;*/
/*		if first.pid and cellegft=1 then cellegft_unik=1;*/
/*		drop takst_kjemo newcyto kreft;*/
/*	run;*/




%mend cellegft;