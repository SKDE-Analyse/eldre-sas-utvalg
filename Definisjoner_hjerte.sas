
%macro hjertesvikt(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Tdiag:;
  do i=1 to dim(diagnose);
    if substr(diagnose{i},1,3) in ('I50') then hjertesvikt=1;
    if substr(diagnose{i},1,4) in ('I110','I130','I132') then hjertesvikt=1;
	 
  end;

  if hjertesvikt = 1 and innlegg = 1 then hjertesv_inn = 1;

run;


%mend hjertesvikt;




%macro hjerteinfarkt(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag: Tdiag:;
	do i=1 to dim(diagnose);
		if Substr(diagnose{i},1,3)='I21' then AkuttInfarkt=1;
		if Substr(diagnose{i},1,3)='I22' then ReInfarkt=1;
	end;
	if AkuttInfarkt=1 or ReInfarkt=1 then hjerteinfarkt=1;

	drop akuttinfarkt reinfarkt;

run;

%mend hjerteinfarkt;




%macro pacemaker(datasett = );

data &datasett;
set &datasett;
	
	array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		if substr (prosedyre {i}, 1, 5) in ('FPE00','FPE10','FPE20','FPG30','FPG33') then pacem_u_crt = 1;
		if substr (prosedyre {i}, 1, 5) in ('FPE26','FPG36') then pacem_crt = 1; /*ingen over 74 år har koden FPE36 (ICD  m/ biventriculær pacer) i NPR*/
		
	end;
		if pacem_u_crt = 1 or pacem_crt = 1 then pacemaker = 1;  /*Her er det den opprinnelige versjonen av pacem_hjertesv som defineres som pacemaker*/
run;
 
%mend pacemaker;

%macro revask(datasett =);

data &datasett;
set &datasett;

array prosedyre {*} NC:;
     do i=1 to dim(prosedyre);
		  if substr(prosedyre{i},1,5)='FYDB1' then Angio=1;   /*Legger til Angio for abstract-prosjektet*/
          if substr(prosedyre{i},1,3) = 'FNG' then PCI=1;
          if substr(prosedyre{i},1,3) in ('FNA', 'FNB', 'FNC', 'FND', 'FNE') then Bypass=1;
     end;

If PCI=1 or Bypass=1 then Revask=1;
if PCI=1 then Angio=1;

Run;

%mend revask;


