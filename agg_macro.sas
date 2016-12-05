
%macro aggreger(inndata =, agg_var =, utdata = );

%let mappe = skde_pet;

proc sort data=&inndata;
by aar ermann alder komnr bydel;
run; 

proc sql;
   create table &mappe..&utdata as 
   select distinct aar, ermann, alder, komnr, bydel, BoRHF, SUM(&agg_var) as &agg_var
   from &inndata
   group by aar, ermann, alder, komnr, bydel;
quit; run;

%mend;

%macro agg_15delt(inndata =, utdata = );

/*
Lagre et sett (&mappe..&utdata) som inneholder aggregerte data for de syv kategoriene
tot, off, priv, elektiv, ohjelp, innlegg, poli + unik pasient for disse syv, samt liggetid.*/

%let mappe = skde_pet;
proc sql;
   create table &mappe..&utdata as 
   select distinct aar, ermann, alder, komnr, bydel,
   SUM(tot) as tot, SUM(tot_unik) as tot_unik, 
   SUM(off) as off, SUM(off_unik) as off_unik,
   SUM(priv) as priv, SUM(priv_unik) as priv_unik,
   SUM(elektiv) as elek, SUM(elektiv_unik) as elek_unik,
   SUM(ohjelp) as ohj, SUM(ohjelp_unik) as ohj_unik,
   SUM(innlegg) as inn, SUM(innlegg_unik) as inn_unik,
   SUM(inn_elektiv) as inn_elek, SUM(inn_elektiv_unik) as inn_elek_unik,
   SUM(inn_ohjelp) as inn_ohj, SUM(inn_ohjelp_unik) as inn_ohj_unik,
   SUM(Innlegg_u_overf) as Inn_uov,
   SUM(Inn_u_overf_elektiv) as Inn_uov_elek,
   SUM(Inn_u_overf_ohjelp) as Inn_uov_ohj,
   SUM(poli) as poli, SUM(poli_unik) as poli_unik,
   SUM(poli_off) as poli_off, SUM(poli_off_unik) as poli_off_unik,
   SUM(poli_priv) as poli_priv, SUM(poli_priv_unik) as poli_priv_unik,
   SUM(liggetid) as liggetid
   from &inndata
   group by aar, ermann, alder, komnr, bydel;
quit; run;

%mend;

%macro inndeling(inndata =, agg_var = );

/*
Lage nytt datasett (&inndata._&agg_var) med tot, off, etc. er markert for
en gitt variabel (&agg_var)
*/ 

data &inndata._&agg_var;
set &inndata;
where &agg_var = 1;
run;

%innlegg_u_overf(datasett = &inndata._&agg_var);

data &inndata._&agg_var;
set &inndata._&agg_var;
tot = 1;
run;

data &inndata._&agg_var;
set &inndata._&agg_var;
  if innlegg = 1 then do;
    if elektiv = 1 then inn_elektiv = 1;
    if ohjelp = 1 then inn_ohjelp = 1;
  end;
run;

data &inndata._&agg_var;
set &inndata._&agg_var;
  if poli = 1 then do;
    if off = 1 then poli_off = 1;
    if priv = 1 then poli_priv = 1;
  end;
run;

data &inndata._&agg_var;
set &inndata._&agg_var;
  if Innlegg_u_overf = 1 then do;
    if elektiv = 1 then Inn_u_overf_elektiv = 1;
    if ohjelp = 1 then Inn_u_overf_ohjelp = 1;
  end;
run;


%unik_pasient(datasett = &inndata._&agg_var, variabel = tot);
%unik_pasient(datasett = &inndata._&agg_var, variabel = priv);
%unik_pasient(datasett = &inndata._&agg_var, variabel = off);
%unik_pasient(datasett = &inndata._&agg_var, variabel = ohjelp);
%unik_pasient(datasett = &inndata._&agg_var, variabel = elektiv);
%unik_pasient(datasett = &inndata._&agg_var, variabel = innlegg);
%unik_pasient(datasett = &inndata._&agg_var, variabel = poli);
%unik_pasient(datasett = &inndata._&agg_var, variabel = inn_elektiv);
%unik_pasient(datasett = &inndata._&agg_var, variabel = inn_ohjelp);
%unik_pasient(datasett = &inndata._&agg_var, variabel = poli_off);
%unik_pasient(datasett = &inndata._&agg_var, variabel = poli_priv);

%mend;


%macro unik_pasient(datasett = , variabel =);

/* 
Macro for å markere unike pasienter 

Ny variabel, &variabel._unik, lages i samme datasett
*/

/*1. Sorter på år, aktuell hendelse (merkevariabel), PID, InnDato, UtDato;*/
proc sort data=&datasett;
by aar &variabel pid inndato utdato;
run;

/*2. By-statement sørger for at riktig opphold med hendelse velges i kombinasjon med First.-funksjonen og betingelse på hendelse*/
data &datasett;
set &datasett;
&variabel._unik = .;
by aar &variabel pid inndato utdato;
if first.pid and &variabel = 1 then &variabel._unik = 1;	
run;

proc sort data=&datasett;
by pid inndato utdato;
run;

%mend;

%macro unik_pasient_alle_aar(datasett = , variabel =);

/* 
Macro for å markere unike pasienter i hele datasettet

Ny variabel, Unik_&variabel, lages i samme datasett
*/

/*1. Sorter på aktuell hendelse (merkevariabel), PID, InnDato, UtDato;*/
proc sort data=&datasett;
by &variabel pid inndato utdato aar;
run;

/*2. By-statement sørger for at riktig opphold med hendelse velges i kombinasjon med First.-funksjonen og betingelse på hendelse*/
data &datasett;
set &datasett;
Unik_&variabel = .;
by &variabel pid inndato utdato;
if first.pid and &variabel = 1 then Unik_&variabel=1;	
run;

proc sort data=&datasett;
by pid inndato utdato;
run;

%mend;


/*innleggelser uten overføringer*/

%macro innlegg_u_overf(datasett = );

proc sort Data=&datasett;
by innlegg pid inndato utdato;
run;

data &datasett;
set &datasett;
by innlegg pid inndato utdato;
Innlegg_u_overf = .;
Overforing = .;
if innlegg=1 then do;
	Lag_PID=Lag(PID);
	Lag_UtDato=Lag(UtDato);
	Lag_BehSh=Lag(BehSh);
	if (PID=LAG_PID) then Dager_mellom=InnDato-LAG_UtDato;
	if BehSH ne LAG_BehSH and 0<=Dager_mellom<=1 then Overforing=1;
end;
	
run;

data &datasett;
set &datasett;
  if overforing ne 1 and innlegg = 1 then Innlegg_u_overf = 1;
  drop LAG_UtDato LAG_PID Lag_BehSh Dager_mellom ;
run;

%mend;