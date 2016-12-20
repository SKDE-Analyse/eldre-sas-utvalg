data tot;
set utvalg_eldre;
run;

%let datasett = tot;
%let niva1 = tot;

data &datasett;
set &datasett;
alle = 1;
run;

/*%let agg_var = pal_beh;*/
/*%let niva3 = pal_beh;*/
/*%inndeling(inndata = &datasett, agg_var = &agg_var);*/
/*%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);*/
/**/
/*%let agg_var = kur_beh;*/
/*%let niva3 = kur_beh;*/
/*%inndeling(inndata = &datasett, agg_var = &agg_var);*/
/*%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);*/

%let agg_var = Straale_beh;
%let niva3 = Straale_beh;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = straale_unik;
%let niva3 = straale_unik;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);


/*%let agg_var = kur_unik;*/
/*%let niva3 = kur_unik;*/
/*%inndeling(inndata = &datasett, agg_var = &agg_var);*/
/*%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);*/
/**/
/*%let agg_var = pal_unik;*/
/*%let niva3 = pal_unik;*/
/*%inndeling(inndata = &datasett, agg_var = &agg_var);*/
/*%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);*/


%let agg_var = cellegft;
%let niva3 = cellegft;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

/*%let agg_var = cellegft_unik;*/
/*%let niva3 = cellegft_unik;*/
/*%inndeling(inndata = &datasett, agg_var = &agg_var);*/
/*%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);*/

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

%let agg_var = hjertesvikt;
%let niva3 = hjertesvikt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = parkinson;
%let niva3 = parkinson;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = parkinson_m_bdiag;
%let niva3 = parkinson_m_bdiag;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = akutthjerneslag;
%let niva3 = akutthjerneslag;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = demens;
%let niva3 = demens;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = demens_m_bdiag;
%let niva3 = demens_m_bdiag;
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

%let agg_var = pacemaker;
%let niva3 = pacemaker;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = pacem_arryt;
%let niva3 = pacem_arryt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = pacem_hjertesv;
%let niva3 = pacem_hjertesv;
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

%let agg_var = alle;
%let niva3 = tot;
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

%let agg_var = hofteprotese_reg;
%let niva3 = hofteprotese_reg;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = kols_innl_akutt;
%let niva3 = kols_innl_akutt;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = bentetthet;
%let niva3 = bentetthet;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = gastroskopi;
%let niva3 = gastroskopi;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = kolonskopi;
%let niva3 = kolonskopi;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = unik_injek;
%let niva3 = unik_injek;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = unik_inj_AMD;
%let niva3 = unik_inj_AMD;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = unik_inj_Vene;
%let niva3 = unik_inj_Vene;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = unik_inj_diab;
%let niva3 = unik_inj_diab;
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

%let agg_var = injek_Vene;
%let niva3 = injek_Vene;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = injek_diab;
%let niva3 = injek_diab;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = retinasykdom;
%let niva3 = retinasykdom;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = injek_retinasykd;
%let niva3 = injek_retinasykd;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = PDT_retinasykd;
%let niva3 = PDT_retinasykd;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = laser_retinasykd;
%let niva3 = laser_retinasykd;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = unik_happ;
%let niva3 = unik_happ;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = happ;
%let niva3 = happ;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

%let agg_var = ks_Brudd;
%let niva3 = ks_Brudd;
%inndeling(inndata = &datasett, agg_var = &agg_var);
%agg_15delt(inndata =&datasett._&agg_var, utdata = e_u_&niva1._&niva3);

