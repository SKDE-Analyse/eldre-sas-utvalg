%macro reinnlegg_11gr(datasett =);

/* Kunnskapssenterets definisjon på Reinnleggelser.
Etter primærinnleggelse for det er kodet med en av disse 11 diagnosegruppene (som hoveddiagnose) beregnes total reinnleggelse etter 8 timer og innen 30 dager */

/* Urinveisinfeksjonkodene: Kun cystitt (blærekatarr, ikke øvre urinveier (pyelonefritt)
Bruddkodene: 'S22'Ribben,'S32'Rygg (columna),'S42'skulder/overarm,'S52'underarm/håndledd,'S62'Håndledd/hånd,'S72'Hofte,'S82'Kne/legg/ankel,'S92' Fot,'T08' Ryggsøyle (columna),'T10'Overekstremitet,'T12' Underekstremitet
Giktkodene: M05-07, Reumatoid artritt, psoriasis artritt, M10 Urinsyregikt, M11 Krystallindusert leddlidelse, M12 Andre spesifisrete leddlidelser, 
M13 Annen artritt, M15-19 Artroser
Mangelanemi-kodene: D50 Jernmangelanemi, D51 Vit B12 mangel, D52 Folsyremangel, D53 Andre mangelanemier*/

data &datasett;
set &datasett;

array diagnose {*} Hdiag:;
  do i=1 to dim(diagnose);
    if substr(diagnose{i},1,3) in ('J40','J41','J42','J43','J44','J45','J46','J47') then ks_Astma_KOLS=1;
    if substr(diagnose{i},1,4) in ('N300','N301','N302','N303','N308','N309') then ks_Urinveisinfeksjon=1;
    if substr(diagnose{i},1,3) in ('S22','S32','S42','S52','S62','S72','S82','S92','T08','T10','T12') then ks_Brudd=1;
    if substr(diagnose{i},1,3) in ('E86') then ks_Dehydrering=1;
    if substr(diagnose{i},1,4) in ('K590') then ks_Forstoppelse=1;
    if substr(diagnose{i},1,3) in ('A00','A01','A02','A03','A04','A05','A06','A07','A08','A09') then ks_Gastroenteritt=1;
    if substr(diagnose{i},1,3) in ('M05','M06','M07','M10','M11','M12','M13','M15','M16','M17','M18','M19') then ks_Gikt=1;
    if substr(diagnose{i},1,3) in ('I43','I50','J81') then ks_Hjertesvikt=1;
    if substr(diagnose{i},1,4) in ('I099','I119','I130','I132','I255', 'I420','I425','I426','I427','I428','I429','I971') then ks_Hjertesvikt=1;
    if substr(diagnose{i},1,3) in ('D50','D51','D52','D53') then ks_Mangelanemi=1;
    if substr(diagnose{i},1,3) in ('J12','J13','J14','J15','J16','J17','J18') then ks_Lungebetennelse=1;
    if substr(diagnose{i},1,3) in ('I61','I63','I64') then ks_Hjerneslag=1;
  end;

if ks_Astma_KOLS= 1 or ks_Urinveisinfeksjon= 1 or ks_Brudd= 1 or ks_Dehydrering= 1 or ks_Forstoppelse= 1 or ks_Gastroenteritt= 1 or ks_Gikt= 1 or ks_Hjertesvikt= 1 or ks_Mangelanemi= 1 or ks_Lungebetennelse= 1 or ks_Hjerneslag= 1 then ks_reinngr = 1;

run;

%mend;
