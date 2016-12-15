
/* 
Data fra 2012 til 2015 leses inn 
(bruker til slutt kun 2013-2015)
*/

Data off_sh;
set npr_skde.magnus_avd_2012 npr_skde.magnus_avd_2013 npr_skde.magnus_avd_2014 npr_skde.magnus_avd_2015;
where alder > 73;
off = 1;
run;

%VarFraParvus (dsnMagnus=off_sh, var_som=cyto_1 inntid uttid, var_avtspes=);

%include "&filbane.makroer\develop\episode_of_care.sas";
%episode_of_care(dsn=off_sh);


/*
Må ha med en mnd ekstra for reinnleggelsekode
*/

Data off_sh;
set off_sh;
where eoc_utdato > '30Nov2012'd and eoc_alder > 74;
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
eoc_aar = aar;
eoc_alder = alder;
eoc_inndato = inndato;
eoc_utdato = utdato;
run;

data avt_spes;
set avt_spes;
EoC_id = koblingsID;
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

data npr_utva.EA_alle_eoc;
set alle_75pluss;
run;
