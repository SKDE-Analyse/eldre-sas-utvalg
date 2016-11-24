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

/*Proc datasets nolist;*/
/*delete avd:;*/
/*run;*/

%mend leggTilFraAvdFil;


%macro ohjelp_elektiv(datasett = );

/*Markere ohjelp og elektiv basert på innmatehast*/


data &datasett;
set &datasett;
  elektiv = .;
  ohjelp = .;
  if hastegrad = 4 then Planlagt = 1;
  if hastegrad = 1 then Akutt = 1;
run;

%mend ohjelp_elektiv;