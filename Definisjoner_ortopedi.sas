



%macro laarhals(datasett =);

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag: Tdiag:;
     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,4) in ('S720') then laarhalsbrudd_diag=1;
     end;

array Prosedyre {*} NC:;
    do i=1 to dim(prosedyre); 
		if substr(prosedyre{i},1,5) in ('NFJ30','NFJ40','NFJ50','NFJ60','NFJ70','NFJ80') then Osteosyntese_Laarhals=1;
 		if substr(prosedyre{i},1,3) in ('NFB') then Protese=1;
end;

	if laarhalsbrudd_diag = 1 and (Osteosyntese_Laarhals=1 or Protese=1)  then laarh_tot = 1;
	if laarhalsbrudd_diag = 1 and Protese=1 then laarh_prot = 1;
	if laarhalsbrudd_diag = 1 and Osteosyntese_Laarhals=1 then laarh_osteos = 1;

drop Osteosyntese_Laarhals laarhalsbrudd_diag Protese;

run;

%mend laarhals;


%macro hofteprotese(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag: Tdiag:;

     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,4) in ('S720','S721','S722') then hoftebrudd_diag=1;
     end;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		/*Primære totalproteser hofte, der brudd er ekskludert*/

		
	if SUBSTR(prosedyre{i},1,5) in ('NFB20', 'NFB30', 'NFB40','NFB99') then Hofteprotese_pros=1;
    end;  

	if hoftebrudd_diag ne 1 and Hofteprotese_pros=1 then Hofteprotese=1;


run;

%mend hofteprotese;




%macro kneprotese(datasett = );

data &datasett;
set &datasett;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
	 /*Primære kneproteser*/
		if SUBSTR(prosedyre{i},1,4) in ('NGB0', 'NGB1') then kneprotese=1;
		if SUBSTR(prosedyre{i},1,5) in ('NGB20', 'NGB30', 'NGB40', 'NGB99') then kneprotese=1;

	end;
run;

%mend kneprotese;

/**/
/*%macro ks_brudd(datasett =);*/
/**/
/*/* Kunnskapssenterets definisjon på Reinnleggelser.*/
/*Etter primærinnleggelse for det er kodet med en av disse 11 diagnosegruppene (som hoveddiagnose) beregnes total reinnleggelse etter 8 timer og innen 30 dager */*/
/**/
/*/* Urinveisinfeksjonkodene: Kun cystitt (blærekatarr, ikke øvre urinveier (pyelonefritt)*/
/*Bruddkodene: 'S22'Ribben,'S32'Rygg (columna),'S42'skulder/overarm,'S52'underarm/håndledd,'S62'Håndledd/hånd,'S72'Hofte,'S82'Kne/legg/ankel,'S92' Fot,'T08' Ryggsøyle (columna),'T10'Overekstremitet,'T12' Underekstremitet*/
/*Giktkodene: M05-07, Reumatoid artritt, psoriasis artritt, M10 Urinsyregikt, M11 Krystallindusert leddlidelse, M12 Andre spesifisrete leddlidelser, */
/*M13 Annen artritt, M15-19 Artroser*/
/*Mangelanemi-kodene: D50 Jernmangelanemi, D51 Vit B12 mangel, D52 Folsyremangel, D53 Andre mangelanemier*/*/
/**/
/*data &datasett;*/
/*set &datasett;*/
/**/
/*array diagnose {*} Hdiag: Tdiag:;*/
/*  do i=1 to dim(diagnose);*/
/*/*    if substr(diagnose{i},1,3) in ('J40','J41','J42','J43','J44','J45','J46','J47') then ks_Astma_KOLS=1;*/*/
/*/*    if substr(diagnose{i},1,4) in ('N300','N301','N302','N303','N308','N309') then ks_Urinveisinfeksjon=1;*/*/
/*    if substr(diagnose{i},1,3) in ('S22','S32','S42','S52','S62','S72','S82','S92','T08','T10','T12') then ks_Brudd_alle=1;*/
/*/*    if substr(diagnose{i},1,3) in ('E86') then ks_Dehydrering=1;*/*/
/*/*    if substr(diagnose{i},1,4) in ('K590') then ks_Forstoppelse=1;*/*/
/*/*    if substr(diagnose{i},1,3) in ('A00','A01','A02','A03','A04','A05','A06','A07','A08','A09') then ks_Gastroenteritt=1;*/*/
/*/*    if substr(diagnose{i},1,3) in ('M05','M06','M07','M10','M11','M12','M13','M15','M16','M17','M18','M19') then ks_Gikt=1;*/*/
/*/*    if substr(diagnose{i},1,3) in ('I43','I50','J81') then ks_Hjertesvikt=1;*/*/
/*/*    if substr(diagnose{i},1,4) in ('I099','I119','I130','I132','I255', 'I420','I425','I426','I427','I428','I429','I971') then ks_Hjertesvikt=1;*/*/
/*/*    if substr(diagnose{i},1,3) in ('D50','D51','D52','D53') then ks_Mangelanemi=1;*/*/
/*/*    if substr(diagnose{i},1,3) in ('J12','J13','J14','J15','J16','J17','J18') then ks_Lungebetennelse=1;*/*/
/*/*    if substr(diagnose{i},1,3) in ('I61','I63','I64') then ks_Hjerneslag=1;*/*/
/*  end;*/
/**/
/*/*if ks_Astma_KOLS= 1 or ks_Urinveisinfeksjon= 1 or ks_Brudd= 1 or ks_Dehydrering= 1 or ks_Forstoppelse= 1 or ks_Gastroenteritt= 1 or ks_Gikt= 1 or ks_Hjertesvikt= 1 or ks_Mangelanemi= 1 or ks_Lungebetennelse= 1 or ks_Hjerneslag= 1 then ks_reinngr = 1;*/*/
/**/
/*if ks_Brudd_alle = 1 and innlegg = 1 then ks_brudd = 1; */
/**/
/*run;*/
/**/
/*%mend;



%macro hoftebrudd(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag: Tdiag:;

     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,4) in ('S720','S721','S722') then hoftebrudd_diag_B=1;
     end;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);

		/*Reposisjoner, primære totalproteser hofte, delproteser og osteosyntese*/

	if SUBSTR(prosedyre{i},1,5) in ('NFB01','NFB02','NFB11','NFB12','NFB20','NFB30','NFB40','NFB59','NFB62','NFB99',
	'NFJ00','NFJ01','NFJ02','NFJ03','NFJ10','NFJ11','NFJ12','NFJ13','NFJ20','NFJ21','NFJ22','NFJ23','NFJ30','NFJ31','NFJ32','NFJ33','NFJ40','NFJ41',
	'NFJ42','NFJ43','NFJ50','NFJ51','NFJ52','NFJ53','NFJ60','NFJ61','NFJ62','NFJ63','NFJ70','NFJ71','NFJ72','NFJ73','NFJ80','NFJ81','NFJ82','NFJ83',
	'NFJ90','NFJ91','NFJ92','NFJ93') then Hoftebrudd_pros=1;
    end;   

	if hoftebrudd_diag_B=1 and Hoftebrudd_pros=1 then Hoftebrudd=1;

run;

%mend hoftebrudd;