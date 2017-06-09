
%macro demens(datasett = );


data &datasett;
set &datasett;

array diagnose {*} Hdiag: Tdiag: ;
	do i=1 to dim(diagnose);
     	if substr(diagnose{i},1,3)in ('G30') then Demens=1;
		if substr(diagnose{i},1,4) in ('G310') then Demens=1;
		if substr(diagnose{i},1,4) in ('G318') then Demens=1;
		if substr(diagnose{i},1,3) in ('F00', 'F01', 'F02', 'F03') then Demens=1;
		if substr(diagnose{i},1,2) in ('T4', 'T5') then Andresykdommer_Hdiag=1;
		if substr(diagnose{i},1,3) in ('G10', 'G20', 'E75', 'G40', 'E01', 'E03', 'T60', 'T61', 'T62', 'T63', 'T64', 'T65', 'M32', 'G35', 'E52', 'B56', 'B57') then Andresykdommer_Hdiag=1;
		if substr(diagnose{i},1,4) in ('G310', 'A810', 'B220', 'E830', 'E835', 'A521', 'M300', 'E538', 'E830', 'N185', 'G318') then Andresykdommer_Hdiag=1;
		if substr(diagnose{i},1,4) in ('F067', 'F078') then Kogn_svikt=1;
     end;
	 
array bdiagnose {*}  Bdiag: ;
    do i=1 to dim(bdiagnose);
		if substr(bdiagnose{i},1,3) in ('F02')  then F02_Bdiag=1;
	end;

if Andresykdommer_Hdiag=1 and F02_Bdiag=1 then Demens=1;
drop  Andresykdommer_Hdiag: F02_Bdiag: ;

if Kogn_svikt = 1 or demens = 1 then demens_KognSv = 1;

run;

%mend demens;



%macro akutthjerneslag(datasett = );

data &datasett;
set &datasett;
array diagnose {*} Hdiag: Tdiag:;
       do i = 1 to dim(diagnose);
			if SUBSTR(diagnose{i},1,3) in ('I61','I63','I64') then Hjerneslag=1;
		end;
run;

proc sort Data=&datasett;
by descending hjerneslag pid inndato utdato;
run;

data &datasett;
set &datasett;
	by descending Hjerneslag pid inndato utdato;
	Lag_inndato=Lag(inndato);
	Hjerneslag28Inn=Hjerneslag;
		If PID=Lag(PID) and Hjerneslag=1 then do;
    		DagerMellomHjerneslag=Inndato-Lag_Inndato;
		end;
	If DagerMellomHjerneslag ne . and DagerMellomHjerneslag LT 28 then Hjerneslag28Inn=.;
	if Hjerneslag28Inn=1 and ohjelp=1 and innlegg = 1 then AkuttHjerneslag28Inn=1;
	AkuttHjerneslag=AkuttHjerneslag28Inn;

	if AkuttHjerneslag28Inn=1 and Substr(HDIAG,1,3) in 
	('I60','I62','I65','I66','I67','I68','I69','Z50') then AkuttHjerneslag=.;

drop lag: hjerneslag28inn DagerMellomHjerneslag AkuttHjerneslag28Inn;

run;

%mend akutthjerneslag;



%macro parkinson(datasett = );

data &datasett;
set &datasett;

/* Ny kode pr. 25.05.2016 */

array diagnose {*} Hdiag: Tdiag:;
     do i=1 to dim(diagnose);
          if (diagnose{i})='G20' then Parkinson=1;
		  if (diagnose{i}) in ('G21','G22','G23') then Parkinsonisme=1;

     end;

if parkinson = 1 or parkinsonisme = 1 then parkinson_alt = 1;

run;

%mend parkinson;


