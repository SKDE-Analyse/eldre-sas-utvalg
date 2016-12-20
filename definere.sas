* Finne diagnosegrupper;
/**/
data utvalg_eldre;
set npr_utva.EA_alle_75pluss;
run;



%straaling(datasett = utvalg_eldre);

%cellegft(datasett = utvalg_eldre);

%laarhals(datasett = utvalg_eldre);

%hjertesvikt(datasett = utvalg_eldre);

%demens(datasett = utvalg_eldre);

%parkinson(datasett = utvalg_eldre);

%hjerteinfrakt(datasett = utvalg_eldre);

%akutthjerneslag(datasett = utvalg_eldre);

%kneprotese(datasett = utvalg_eldre);

%hofteprotese(datasett = utvalg_eldre);

%under_aattifem(datasett = utvalg_eldre);

%over_aattifem(datasett = utvalg_eldre);

%a_ekg(datasett = utvalg_eldre);

%ekko(datasett = utvalg_eldre);

%pacemaker(datasett = utvalg_eldre);

%revask(datasett = utvalg_eldre);

%hoereapp (datasett = utvalg_eldre);

%lunge (datasett = utvalg_eldre);

%gastroskopi (datasett = utvalg_eldre);

%bentetthet (datasett = utvalg_eldre);

%kolonskopi (datasett = utvalg_eldre);

%injeksjon_oye (datasett = utvalg_eldre);

%Graastaer (datasett = utvalg_eldre);

%reinnlegg_11gr (datasett = utvalg_eldre);






data utvalg_eldre;
set utvalg_eldre;
if poli = 1 and Aktivitetskategori = 5 and off = 1 then poli_ren = 1;
if poli = 1 and priv = 1 then poli_ren = 1;
run;


data utvalg_eldre;
set utvalg_eldre;
if innlegg = 1 then do;

  if overforing ne 1 then Innlegg_u_overf = 1;
end;
run;


data npr_utva.EA_utvalg_eldre;
set utvalg_eldre;
drop aggrshoppID ald_gr Ald_gr5 AnsienDato Avdeling Avdtype AvtaleRHF Cyto_1 koblingsID Fylke intern_kons hastegrad fag_SKDE
BoShHN Doddato drg drg_type ekskl_pediatri Fag omsorgsniva oppholdstype 
 SpesialistKomHN TilSted tjenesteenhetKode tjenesteenhetkodeNum TjensteenhetKode 
trimpkt UtMnd /*UtSkrKlarDager*/ /*UtSkrKlarDato*/ utTilstand NPRId_reg inntilstand 
InstitusjonId komp_drg Kontakt korrvekt HastegradInnlagte hdg niva InnAar InnMnd
/*ICD10:*/ komNrHjem: Normaltariff: /*Hdiag:*/ Tdiag: fagom: behandlingssted: Aktivitetskat: Bdiag:
DRGtype: ICD: Hdiag: UtSkr: nc: ant_hdiagAvd ant_nc: VertskommHN VertskommuneHN i
AlzheimersSykdom_m_bdiag AlzheimersDemens_m_bdiag VaskulærDemens_m_bdiag DemensAnnensykdom_m_bdiag AnnenDemens_m_bdiag
Demens_BDiag Demens_tillegg HukommelsesSvikt_m_bdiag Delirium_m_bdiag AkuttInfarkt ReInfarkt Parkinson_bi Parkinson_tillegg
laarhalsbrudd_pros laarhalsbrudd_diag laar_protese 
Lag_inndato Hjerneslag28Inn DagerMellomHjerneslag AkuttHjerneslag28Inn k
unik_pasient oppholdsnr_Straale;
run;


/*data skde_arn.utvalg_eldre;*/
/*set skde_arn.alle_70pluss;*/
/*drop aggrshoppID ald_gr Ald_gr5 AnsienDato Avdeling Avdtype AvtaleRHF */
/*BoHF_gammel BoShHN bydel2 Doddato drg drg_type ekskl_pediatri Fag omsorgsniva oppholdstype */
/*Pas_system SpesialistKomHN Spesialitet TilSted tjenesteenhetKode tjenesteenhetkodeNum TjensteenhetKode */
/*trimpkt UtMnd UtSkrKlarDager UtSkrKlarDato utTilstand vekt versjon AvtaleRHF NPRId_reg inntilstand */
/*InstitusjonId komp_drg Kontakt korrvekt innmateHast HastegradInnlagte hdg g_omsorgsniva niva InnAar InnMnd*/
/*ICD10: komNrHjem: Normaltariff: ncsp: ncmp: Hdiag: Tdiag: fagom: Beh: behandlingssted: Behandlingsniva: Bdiag:;*/
/*run;*/

