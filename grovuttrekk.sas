
/* Data fra 2013 til 2015 leses inn */

Data off_sh;
set npr_skde.magnus_avd_2012 npr_skde.magnus_avd_2013 npr_skde.magnus_avd_2014 npr_skde.magnus_avd_2015;
where alder > 73;
off = 1;
run;

%VarFraParvus (dsnMagnus=off_sh, var_som=cyto_1 inntid uttid, var_avtspes=);

%episode_of_care(dsn=off_sh);

Data off_sh;
set off_sh;
where eoc_aar ne 2012 and eoc_alder > 74;
run;


* Sette de private sykehus til priv;
data off_sh;
set off_sh;
if behrhf = 5 then do;
off = .;
priv = 1;
privsh = 1;
end;
run;

/* Markere innleggelser og poliklinikk/dag */
%innlegg_poli(datasett = off_sh);

data avt_spes;
set npr_skde.magnus_avtspes_2013 npr_skde.magnus_avtspes_2014 npr_skde.magnus_avtspes_2015;
where alder > 74;
priv = 1;
poli = 1;
run;

/* Slå sammen (samt slå sammen HF?)*/
data alle_75pluss;
set off_sh avt_spes;
run;

/* Markere ohjelp og elektiv */
%ohjelp_elektiv(datasett = alle_75pluss);


/*Proc datasets nolist;*/
/*delete off_sh avt_spes;*/
/*run;*/

data npr_utva.EA_alle_75pluss;
set alle_75pluss;
run;