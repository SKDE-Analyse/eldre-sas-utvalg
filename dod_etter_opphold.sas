data utvalg_eldre;
set npr_utva.EA_utvalg_eoc_reinn;
run;


%dod_etter_opphold(datasett = utvalg_eldre, variabel = AkuttHjerneslag);

%dod_etter_opphold(datasett = utvalg_eldre, variabel = lungebet_inn);

%dod_etter_opphold(datasett = utvalg_eldre, variabel = hoftebrudd);

%dod_etter_opphold(datasett = utvalg_eldre, variabel = hjertesvikt);


/**/
data npr_utva.EA_utvalg_eoc_reinn;
set utvalg_eldre;
run;

