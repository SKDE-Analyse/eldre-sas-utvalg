
/* Data fra 2013 til 2014 leses inn */

Data off_sh;
set npr_skde.magnus_sho_2013 npr_skde.magnus_sho_2014 npr_skde.magnus_sho_2015;
where alder > 74;
off = 1;
run;

/* Legge inn prosedyrer fra avd. fil */


%leggTilFraAvdFil(dsn = off_sh);


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


Proc datasets nolist;
delete off_sh avt_spes;
run;

data npr_utva.EA_alle_75pluss;
set alle_75pluss;
run;