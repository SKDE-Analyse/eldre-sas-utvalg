
%macro demens(datasett = );

/* Ny kode pr. 25.05.2016 */

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Tdiag:;
     do i=1 to dim(diagnose);
     if substr(diagnose {i},1,3)in ('G30','F00','F01' ,'F02','F03','F04','F05')  then Demens=1;
         if substr(diagnose{i},1,5) in ('Z5089') then Demens_tillegg=1;
         if substr(diagnose{i},1,4) in ('Z509', 'F067') then Demens_tillegg=1;
     end;

array bdiagnose {*}  Bdiag: ;
     do i=1 to dim(bdiagnose);
    	if substr(bdiagnose {i},1,3)in ('G30','F00','F01' ,'F02','F03','F04','F05')  then Demens_BDiag=1;
    end;

if Demens_BDiag=1 and Demens_tillegg=1 then Demens=1 ;

if Demens_BDiag=1 or Demens=1 then Demens_m_BDIAG=1 ;

run;

%mend demens;
/**/
/*%macro demens_m_bdiag(datasett = );*/
/**/
/*data &datasett;*/
/*set &datasett;*/
/**/
/*array diagnose {*} Hdiag: Bdiag: Tdiag:;*/
/*	do i=1 to dim (diagnose);*/
/*		 if substr(diagnose {i},1,3)='G30' then AlzheimersSykdom_m_bdiag=1;*/
/*         if substr(diagnose {i},1,3)='F00' then AlzheimersDemens_m_bdiag=1;*/
/*         if substr(diagnose {i},1,3)='F01' then VaskulærDemens_m_bdiag=1;*/
/*         if substr(diagnose {i},1,3)='F02' then DemensAnnensykdom_m_bdiag=1;*/
/*		 if substr(diagnose {i},1,3)='F03' then AnnenDemens_m_bdiag=1;*/
/*		 if substr(diagnose {i},1,3)='F04' then HukommelsesSvikt_m_bdiag=1;*/
/*		 if substr(diagnose {i},1,3)='F05' then Delirium_m_bdiag=1;*/
/*	end;*/
/*  if AlzheimersSykdom_m_bdiag=1 or AlzheimersDemens_m_bdiag=1 or VaskulærDemens_m_bdiag=1 or DemensAnnensykdom_m_bdiag=1 or AnnenDemens_m_bdiag=1 then Demens_m_bdiag=1;*/
/**/
/*run;*/
/**/
/*%mend demens_m_bdiag;*/

%macro akutthjerneslag(datasett = );

data &datasett;
set &datasett;
array diagnose {*} Hdiag: Bdiag: Tdiag:;
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
	if Hjerneslag28Inn=1 and ohjelp=1 then AkuttHjerneslag28Inn=1;
	AkuttHjerneslag=AkuttHjerneslag28Inn;

drop lag: hjerneslag28inn DagerMellomHjerneslag AkuttHjerneslag28Inn

run;

%mend akutthjerneslag;


%macro parkinson(datasett = );

data &datasett;
set &datasett;

/* Ny kode pr. 25.05.2016 */

array diagnose {*} Hdiag: Tdiag:;
     do i=1 to dim(diagnose);
          if (diagnose{i})='G20' then Parkinson=1;
          if substr(diagnose{i},1,5) in ('Z5089','Z5150') then Parkinson_tillegg=1;
          if substr(diagnose{i},1,4) in ('Z509') then Parkinson_tillegg=1;
     end;

array bdiagnose {*}  Bdiag:;
     do i=1 to dim(bdiagnose);
           if (bdiagnose{i})='G20' then Parkinson_bi=1;
     end;

if Parkinson_bi=1 and Parkinson_tillegg=1 then Parkinson=1;

if Parkinson_bi=1 or Parkinson=1 then Parkinson_m_BDIAG=1;

run;

%mend parkinson;


