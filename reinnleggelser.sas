
data utvalg_eldre;
set npr_utva.EA_utvalg_eoc;
run;

%dod_etter_ett_aar(datasett = utvalg_eldre, variabel =ks_Brudd);

%include "&filbane.makroer\develop\reinnleggelser.sas";

%reinnleggelser(dsn=utvalg_eldre, primaer = innlegg, siste_utdato ='30Nov2015'd);

data utvalg_eldre;
set utvalg_eldre;
innlegg_reinn = EoC_reinnleggelse;
drop EoC_reinnleggelse;
run;

%reinnleggelser(dsn=utvalg_eldre, primaer = hjertesvikt, siste_utdato ='30Nov2015'd);

data utvalg_eldre;
set utvalg_eldre;
hjertesvikt_reinn = EoC_reinnleggelse;
drop EoC_reinnleggelse;
run;


%reinnleggelser(dsn=utvalg_eldre, primaer = hjerneslag, siste_utdato ='30Nov2015'd);

data utvalg_eldre;
set utvalg_eldre;
hjerneslag_reinn = EoC_reinnleggelse;
drop EoC_reinnleggelse;
run;


%reinnleggelser(dsn=utvalg_eldre, primaer = ks_hjerneslag, siste_utdato ='30Nov2015'd);

data utvalg_eldre;
set utvalg_eldre;
ks_hjerneslag_reinn = EoC_reinnleggelse;
drop EoC_reinnleggelse;
run;


%reinnleggelser(dsn=utvalg_eldre, primaer = ks_reinngr, siste_utdato ='30Nov2015'd);

data utvalg_eldre;
set utvalg_eldre;
ks_reinngr_reinn = EoC_reinnleggelse;
drop EoC_reinnleggelse;
run;


%reinnleggelser(dsn=utvalg_eldre, primaer = ks_brudd, siste_utdato ='30Nov2015'd);

data utvalg_eldre;
set utvalg_eldre;
ks_brudd_reinn = EoC_reinnleggelse;
drop EoC_reinnleggelse;
run;


data npr_utva.EA_utvalg_eoc_reinn;
set utvalg_eldre;
where EoC_aar ne 2012;
run;
