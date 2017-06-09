
data utvalg_eldre;
set npr_utva.EA_utvalg_eoc;
run;

%include "&filbane.makroer\master\reinnleggelser.sas";


%reinnleggelser(dsn=utvalg_eldre, primaer = innlegg, forste_utdato='30Nov2012'd, kun_innleggelser = 1);

data utvalg_eldre;
set utvalg_eldre;
innlegg_prim = primaeropphold;
innlegg_reinn = primaer_med_reinn;
drop primaeropphold primaer_med_reinn reinnleggelse;
run;


%reinnleggelser(dsn=utvalg_eldre, primaer = hjertesvikt, forste_utdato='30Nov2012'd, kun_innleggelser = 1);

data utvalg_eldre;
set utvalg_eldre;
hjertesvikt_prim = primaeropphold;
hjertesvikt_reinn = primaer_med_reinn;
drop primaeropphold primaer_med_reinn reinnleggelse;
run;


%reinnleggelser(dsn=utvalg_eldre, primaer = lungebet, forste_utdato='30Nov2012'd, kun_innleggelser = 1);

data utvalg_eldre;
set utvalg_eldre;
lungebet_prim = primaeropphold;
lungebet_reinn = primaer_med_reinn;
drop primaeropphold primaer_med_reinn reinnleggelse;
run;

%reinnleggelser(dsn=utvalg_eldre, primaer = kols_innl_akutt, forste_utdato='30Nov2012'd, kun_innleggelser = 1);

data utvalg_eldre;
set utvalg_eldre;
kols_inl_ak_prim = primaeropphold;
kols_inl_ak_reinn = primaer_med_reinn;
drop primaeropphold primaer_med_reinn reinnleggelse;
run;

%reinnleggelser(dsn=utvalg_eldre, primaer = akutthjerneslag, forste_utdato='30Nov2012'd, kun_innleggelser = 1);

data utvalg_eldre;
set utvalg_eldre;
ak_hj_slag_prim = primaeropphold;
ak_hj_slag_reinn = primaer_med_reinn;
drop primaeropphold primaer_med_reinn reinnleggelse;
run;

%reinnleggelser(dsn=utvalg_eldre, primaer = hoftebrudd, forste_utdato='30Nov2012'd, kun_innleggelser = 1);

data utvalg_eldre;
set utvalg_eldre;
hoftebrudd_prim = primaeropphold;
hoftebrudd_reinn = primaer_med_reinn;
drop primaeropphold primaer_med_reinn reinnleggelse;
/*run;*/

data npr_utva.EA_utvalg_eoc_reinn;
set utvalg_eldre;
where EoC_aar ne 2012;
run;
