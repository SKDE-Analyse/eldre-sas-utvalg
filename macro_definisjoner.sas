%macro innlegg_poli(datasett = );
/* 
Todeling av datasettet:
innleggelser og dag/poliklinikk
(gjelder kun for off)
*/

data &datasett;
set &datasett;

innlegg = .;
poli = .;

If aktivitetskategori3 = 1 and Liggetid ge 1 then innlegg = 1;
else if aktivitetskategori3 = 1 and uttilstand in (2, 3) then innlegg = 1; * ut som død eller selvmord;
else if (aktivitetskategori3 = 1 and Liggetid=0) or aktivitetskategori3=2 then poli = 1;
else if aktivitetskategori3 = 3 then poli = 1;

run;

%mend innlegg_poli;



%macro leggTilFraAvdFil(data = );

/* Legge inn prosedyrer fra avd. fil */


data avd;
set npr_skde.magnus_avd_2013 npr_skde.magnus_avd_2014 npr_skde.magnus_avd_2015;
keep hdiag hdiag2 nc: pid koblingsID aar;
where alder>74;
run;

%VarFraParvus (dsnMagnus=avd, var_som=aggrshoppID niva, var_avtspes=);


/*Henter Hdiag fra avdelingsoppholdsfil og legger dem til*/
%UnikeVariableAvdOpphold(variabler=Hdiag hdiag2, dsn=avd, prefix=hdiagAvd, extrawhere=);


proc sql;
create table &data as
select *
from &data left join avd_hdiagAvd
on &data..pid=avd_hdiagAvd.pid and &data..aggrshoppID=avd_hdiagAvd.aggrshoppID;
quit; title;




/*Henter Hdiag fra avdelingsoppholdsfil og legger dem til*/

%UnikeVariableAvdOpphold(variabler=NC:, dsn=avd, prefix=NC_Avd, extrawhere=);


proc sql;
create table &data as
select *
from &data left join avd_NC_Avd
on &data..pid=avd_NC_Avd.pid and &data..aggrshoppID=avd_NC_Avd.aggrshoppID;
quit; title;

Proc datasets nolist;
delete avd:;
run;

%mend leggTilFraAvdFil;


%macro ohjelp_elektiv(datasett = );

/*Markere ohjelp og elektiv basert på innmatehast*/


data &datasett;
set &datasett;
  elektiv = .;
  ohjelp = .;
  if hastegrad = 4 then elektiv = 1;
  if hastegrad = 1 then ohjelp = 1;
run;

%mend ohjelp_elektiv;

%macro hjertesvikt(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag:;
	do i=1 to dim(diagnose);
		if substr(diagnose{i},1,3) in ('I50') then hjertesvikt=1;
  end;

run;


%mend hjertesvikt;

%macro lungebet(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag:;
	do i=1 to dim(diagnose);
		if substr(diagnose{i},1,4) in ('J100','J110', 'J690') then lungebet=1;
		if substr(diagnose{i},1,3) in ('J12', 'J13','J14','J15', 'J16','J17','J18', 'J22') then lungebet=1;
  end;

run;


%mend lungebet;


%macro kols(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag:;
	do i=1 to dim(diagnose);
	                                               /* kols*/
                if substr(diagnose{i},1,3)='J44' then J44_H=1; 
                                               
                                               /* kronisk bronkitt */
                if substr(diagnose{i},1,3)='J40' then J40_H=1; 
                if substr(diagnose{i},1,3)='J41' then J41_H=1;
                if substr(diagnose{i},1,3)='J42' then J42_H=1;

                                               /* emfysem */
                if substr(diagnose{i},1,3)='J43' then J43_H=1;

                                               /* pneumonier */
                if substr(diagnose{i},1,3)='J12' then J12_H=1; 
                if substr(diagnose{i},1,3)='J13' then J13_H=1;
                if substr(diagnose{i},1,3)='J14' then J14_H=1;
                if substr(diagnose{i},1,3)='J15' then J15_H=1;
                if substr(diagnose{i},1,3)='J16' then J16_H=1; 
                if substr(diagnose{i},1,3)='J17' then J17_H=1;
                if substr(diagnose{i},1,3)='J18' then J18_H=1;

                if substr(diagnose{i},1,3)in ('J12', 'J13', 'J14', 'J15', 'J16', 'J17', 'J18') then J12_18_H=1;

                                               /* akutt bronkitt */
                if substr(diagnose{i},1,3)='J20' then J20_H=1;
                if substr(diagnose{i},1,3)='J21' then J21_H=1; 

                                               /* uspesifisert akutt infeksjon i nedre luftveier */
                if substr(diagnose{i},1,3)='J22' then J22_H=1;
                                               
                                               /* akutt alvorlig astma */
                if substr(diagnose{i},1,3)='J46' then J46_H=1;

                                               /* respirasjonssvikt, ikas */
                if substr(diagnose{i},1,3)='J96' then J96_H=1;

                                               /* influensa */
                if substr(diagnose{i},1,3)='J09' then J09_H=1; 
                if substr(diagnose{i},1,3)='J10' then J10_H=1;
                if substr(diagnose{i},1,3)='J11' then J11_H=1;
                if substr(diagnose{i},1,3)in ('J09', 'J10', 'J11') then J09_J11_H=1;

                end;

   array Bdiagnose {*} Bdiag:;
	do i=1 to dim(Bdiagnose);
                /* kols */
          		if substr(diagnose{i},1,3)='J44' then J44_B=1; 
                if substr(diagnose{i},1,4)='J440' then J440_B=1;
                if substr(diagnose{i},1,4)='J441' then J441_B=1;
                if substr(diagnose{i},1,4)='J448' then J448_B=1;
                if substr(diagnose{i},1,4)='J449' then J449_B=1;

                /* respirasjonssvikt, ikas */
                if substr(diagnose{i},1,3)='J96' then J96_B=1;
    end;


/* Utvalg 1 */
	if 		
	(J40_H=1 or /* Bronkitt, ikke spesifisert som akutt eller kronisk */
	J41_H=1 or /* Ukomplisert og mukopurulent kronisk bronkitt */
	J42_H=1 or /* Uspesifisert kronisk bronkitt */
	J43_H=1 or /* Emfysem */
	J44_H=1) /* Annen kronisk obstruktiv lungesykdom */
	then utvalg_1=1;

	if J44_B=1 and J12_18_H=1 /* Pneumonier */ then utvalg_1=1;
	if J44_B=1 and J20_H=1 /* Akutt bronkitt */ then utvalg_1=1;
	if J44_B=1 and J22_H=1 /* Unspesifiert akutt infeksjon i nedre luftveier */ then utvalg_1=1;
	/* if J44_B=1 and J46_H=1 /* Akutt alvorlig astma then utvalg_1=1;, tas ut pga små tall */ 
	if J44_B=1 and J96=1 /* Respirasjonssvikt, ikas */ then utvalg_1=1;

/* Utvalg 12 */
	if utvalg_1=1 and hastegrad ne 4 and (liggetid>0 or utTilstand=2) then kols=1;
	drop j: utvalg:;

run;


%mend kols;


%macro hjertesvikt_m_bdiag(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag:;
	do i=1 to dim(diagnose);
		if substr(diagnose{i},1,3) in ('I50') then hjertesvikt_m_bdiag=1;
  end;
 
run;


%mend hjertesvikt_m_bdiag;





%macro laarhals(datasett =);

data &datasett;
set &datasett;
drop laarhals: prot: annen:;
run;

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag:;
     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,4) in ('S720') then laarhalsbrudd_diag=1;
     end;

array Prosedyre {*} NC:;
    do i=1 to dim(prosedyre); 
		if substr(prosedyre{i},1,5) in ('NFJ60','NFJ70') then AnnenPros_Laarhals=1;
 		if substr(prosedyre{i},1,3) in ('NFB') then Protese=1;
end;

	if laarhalsbrudd_diag = 1 and (AnnenPros_Laarhals=1 or Protese=1)  then laarhals_tot = 1;
	if laarhalsbrudd_diag = 1 and Protese=1 then laarhals_prot = 1;
	if laarhalsbrudd_diag = 1 and AnnenPros_Laarhals=1 then laarhals_annen = 1;

drop AnnenPros_Laarhals laarhalsbrudd_diag Protese;

run;

%mend laarhals;



%macro hofteprotese(datasett = );

data &datasett;
set &datasett;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		/*Primære hofteproteser*/
       if SUBSTR(prosedyre{i},1,3)='NFB' then Hofteprotese=1;
    end;  
run;

%mend hofteprotese;


%macro parkinson(datasett = );

data &datasett;
set &datasett;

/* Ny kode pr. 25.05.2016 */

array diagnose {*} Hdiag:;
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

run;

%mend parkinson;



%macro hjerteinfrakt(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag:;
	do i=1 to dim(diagnose);
		if Substr(diagnose{i},1,3)='I21' then AkuttInfarkt=1;
		if Substr(diagnose{i},1,3)='I22' then ReInfarkt=1;
	end;
	if AkuttInfarkt=1 or ReInfarkt=1 then hjerteinfarkt=1;
run;

%mend hjerteinfrakt;


%macro demens(datasett = );

/* Ny kode pr. 25.05.2016 */

data &datasett;
set &datasett;

array diagnose {*} Hdiag:;
     do i=1 to dim(diagnose);
     if substr(diagnose {i},1,3)in ('G30','F00','F01' ,'F02','F03','F04','F05')  then Demens=1;
         if substr(diagnose{i},1,5) in ('Z5089') then Demens_tillegg=1;
         if substr(diagnose{i},1,4) in ('Z509', 'F067') then Demens_tillegg=1;
     end;

array bdiagnose {*}  Bdiag:;
     do i=1 to dim(bdiagnose);
    	if substr(bdiagnose {i},1,3)in ('G30','F00','F01' ,'F02','F03','F04','F05')  then Demens_BDiag=1;
    end;

if Demens_BDiag=1 and Demens_tillegg=1 then Demens=1 ;

run;

%mend demens;

%macro demens_m_bdiag(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag:;
	do i=1 to dim (diagnose);
		 if substr(diagnose {i},1,3)='G30' then AlzheimersSykdom_m_bdiag=1;
         if substr(diagnose {i},1,3)='F00' then AlzheimersDemens_m_bdiag=1;
         if substr(diagnose {i},1,3)='F01' then VaskulærDemens_m_bdiag=1;
         if substr(diagnose {i},1,3)='F02' then DemensAnnensykdom_m_bdiag=1;
		 if substr(diagnose {i},1,3)='F03' then AnnenDemens_m_bdiag=1;
		 if substr(diagnose {i},1,3)='F04' then HukommelsesSvikt_m_bdiag=1;
		 if substr(diagnose {i},1,3)='F05' then Delirium_m_bdiag=1;
	end;
  if AlzheimersSykdom_m_bdiag=1 or AlzheimersDemens_m_bdiag=1 or VaskulærDemens_m_bdiag=1 or DemensAnnensykdom_m_bdiag=1 or AnnenDemens_m_bdiag=1 then Demens_m_bdiag=1;

run;

%mend demens_m_bdiag;

%macro akutthjerneslag(datasett = );

data &datasett;
set &datasett;
array diagnose {*} Hdiag: Bdiag:;
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
	if Hjerneslag28Inn=1 and HastegradInnlagte=2 then AkuttHjerneslag28Inn=1;
	AkuttHjerneslag=AkuttHjerneslag28Inn;

run;

%mend akutthjerneslag;


%macro kneprotese(datasett = );

data &datasett;
set &datasett;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
	 /*Primære kneproteser*/
       if SUBSTR(prosedyre{i},1,3)='NGB' then kneprotese=1;
	end;
run;

%mend kneprotese;


%macro Dod_i_Sh(datasett = );

data &datasett;
set &datasett;
	if UtTilstand in (2,3) then Dod_i_Sh = 1;
run;



%mend Dod_i_Sh;



%macro under_aattifem(datasett = );

data &datasett;
set &datasett;

if alder lt 85 then under_aattifem = 1;
run;

%mend under_aattifem;

%macro over_aattifem(datasett = );

data &datasett;
set &datasett;

if alder ge 85 then over_aattifem = 1;
run;

%mend over_aattifem;



%macro a_ekg(datasett = );

data &datasett;
set &datasett;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		if substr (prosedyre {i}, 1, 6) in ('FPFE50','FPFE55') then A_EKG = 1;
	end;
	
	array takst {15} Normaltariff:;
	do k = 1 to 15;
		if substr (takst {k}, 1,4) in ('129a') then A_EKG = 1;
		if substr (takst {k}, 1,3) in ('707') then A_EKG = 1;
	end;
	
run; 


%mend a_ekg;


%macro ekko(datasett = );

data &datasett;
set &datasett;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		if substr (prosedyre {i}, 1, 6) in ('FYDE30', 'FYDE31', 'FYDE32','FYDE33') then EKKO = 1;
	end;
	
	array takst {15} Normaltariff:;
	do k = 1 to 15;
		if substr (takst {k}, 1,4) in ('129e','129d','129i') then  Ekko = 1; 
	end;
	
run; 


%mend ekko;



%macro pacemaker(datasett = );

data &datasett;
set &datasett;
	
	array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		if substr (prosedyre {i}, 1, 5) in ('FPE00','FPE10','FPE20','FPE26') then pacemaker = 1;
	end;

run;
 
%mend pacemaker;

%macro revask(datasett =);

data &datasett;
set &datasett;

array prosedyre {*} NC:;
     do i=1 to dim(prosedyre);

          if substr(prosedyre{i},1,5) in ('FNG02','FNG05') then PCI=1;
          if substr(prosedyre{i},1,5)in ('FNA00','FNA10','FNA20','FNA96','FNB00','FNB20','FNB96',
          'FNC10','FNC20','FNC30','FNC40','FNC50','FNC60','FNC96','FND10','FND20','FND96','FNE00',
          'FNE10','FNE20','FNE96') then Bypass=1;
     end;

If PCI=1 or Bypass=1 then Revask=1;
Run;

%mend revask;

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
array diagnose {*} Hdiag: Bdiag:;
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



%macro graastaer(datasett =);



data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag:;
     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,3) in ('H25') then graastaer_diag=1;
     end;

array Prosedyre {*} NC:;
    do i=1 to dim(prosedyre); 
		if substr(prosedyre{i},1,5) in ('CJE20') then graastaer_pros=1;  /*Også CJE25?*/
end;

array takst {15} Normaltariff:;
	do k = 1 to 15;
		if substr (takst {k}, 1,4) in ('K01a') then graastaer_takst = 1;
	end;

	if graastaer_diag = 1 and graastaer_pros  then Graastaer_opr_pros = 1;
	if graastaer_diag = 1 and graastaer_takst=1 then Graastaer_opr_takst = 1;
	if Graastaer_opr_pros = 1 or Graastaer_opr_takst = 1 then Graastaer_opr = 1;	

run;

%mend graastaer;


%macro bentetthet (datasett=);

data &datasett;
set &datasett;

array prosedyre {*} NC:;
  do i=1 to dim(prosedyre);
    if substr(prosedyre{i},1,6) in ('NXFX05') then bentetthet=1;
  end;


%mend bentetthet;



%macro gastroskopi (datasett=);

data &datasett;
set &datasett;

array prosedyre {*} NC:;
  do i=1 to dim(prosedyre);
    if substr(prosedyre{i},1,6) in ('UJD02', 'UJD05') then gastroskopi=1;
  end;


%mend gastroskopi;