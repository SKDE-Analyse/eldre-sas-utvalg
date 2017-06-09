data tot;
set npr_utva.EA_utvalg_eoc_reinn;  
alder = eoc_alder;
aar = eoc_aar;
drop eoc_alder eoc_aar;
run;

%let datasett = tot;
%let niva1 = tot;

data &datasett;
set &datasett;
alle = 1;
run;


%let agg_var = inn_elek;
%let niva3 = inn_elek;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = Holter_gml;
%let niva3 = Holter_gml;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = demens_KognSv;
%let niva3 = demens_KognsSv;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = holter;
%let niva3 = holter;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = demens;
%let niva3 = demens;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = hjertesvikt;
%let niva3 = hjertesvikt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = parkinson;
%let niva3 = parkinson;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = parkinson_alt;
%let niva3 = parkinson_alt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = parkinsonisme;
%let niva3 = parkinsonisme;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);


%let agg_var = kols_innl_akutt;
%let niva3 = kols_innl_akutt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = lungebet_inn;
%let niva3 = lungebet_inn;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);



/*Aggregering*/

%let agg_var = cellegft;
%let niva3 = cellegft;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);


%let agg_var = kogn_svikt;
%let niva3 = kogn_svikt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);
/**/
/*%let agg_var = alle;*/
/*%let niva3 = tot_alle;*/
/*%inndeling(inndata = &datasett, agg_var = &agg_var, behold_alle = 1);*/
/*%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);*/

%let agg_var = alle;
%let niva3 = tot;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = Straale_beh;
%let niva3 = Straale_beh;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = lungebet;
%let niva3 = lungebet;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = laarh_osteos;
%let niva3 = laarh_osteos;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = laarh_prot;
%let niva3 = laarh_prot;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = laarh_tot;
%let niva3 = laarh_tot;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = akutthjerneslag;
%let niva3 = akutthjerneslag;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = hjerteinfarkt;
%let niva3 = hjerteinfarkt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = a_ekg;
%let niva3 = a_ekg;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = ekko;
%let niva3 = ekko;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = holter;
%let niva3 = holter;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);


%let agg_var = revask;
%let niva3 = revask;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = pci;
%let niva3 = pci;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = bypass;
%let niva3 = bypass;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = under_aattifem;
%let niva3 = u_85;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = over_aattifem;
%let niva3 = o_85;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = Graast_opr;
%let niva3 = Graast_opr;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = kneprotese;
%let niva3 = kneprotese;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = hofteprotese;
%let niva3 = hofteprotese;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = injek;
%let niva3 = injek;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = injek_AMD;
%let niva3 = injek_AMD;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = injek_diab;
%let niva3 = injek_diab;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = injek_Vene;
%let niva3 = injek_Vene;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = unik_happ_15;
%let niva3 = unik_happ_15;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = unik_happ_14;
%let niva3 = unik_happ_14;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = unik_happ_13;
%let niva3 = unik_happ_13;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = hoftebrudd;
%let niva3 = hoftebrudd;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = pacemaker;
%let niva3 = pacemaker;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = pacem_crt;
%let niva3 = pacem_crt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = pacem_u_crt;
%let niva3 = pacem_u_crt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

/*Reinnleggelser og primæropphold*/

%let agg_var = innlegg_reinn;
%let niva3 = innlegg_reinn;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = innlegg_prim;
%let niva3 = innlegg_prim;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = lungebet_reinn;
%let niva3 = lungebet_reinn;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = lungebet_prim;
%let niva3 = lungebet_prim;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = kols_inl_ak_reinn;
%let niva3 = kols_inl_ak_reinn;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = kols_inl_ak_prim;
%let niva3 = kols_inl_ak_prim;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = ak_hj_slag_reinn;
%let niva3 = ak_hj_slag_reinn;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = ak_hj_slag_prim;
%let niva3 = ak_hj_slag_prim;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = hoftebrudd_reinn;
%let niva3 = hoftebrudd_reinn;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = hoftebrudd_prim;
%let niva3 = hoftebrudd_prim;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = hjertesvikt_reinn;
%let niva3 = hjertesvikt_reinn;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = hjertesvikt_prim;
%let niva3 = hjertesvikt_prim;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);


 /*Død etter 30, 90 og 365 dager*/

%let agg_var = dod30_hjertesvikt;
%let niva3 = dod30_hjertesvikt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = dod365_hoftebrudd;
%let niva3 = dod365_hoftebrudd;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = dod30_hoftebrudd;
%let niva3 = dod30_hoftebrudd;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = dod365_hoftebrudd;
%let niva3 = dod365_hoftebrudd;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = dod30_lungebet_inn;
%let niva3 = dod30_lungebet_inn;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = dod365_lungebet_inn;
%let niva3 = dod365_lungebet_inn;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = dod30_akutthjerneslag;
%let niva3 = dod30_akutthjerneslag;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = dod365_akutthjerneslag;
%let niva3 = dod365_akutthjerneslag;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);
