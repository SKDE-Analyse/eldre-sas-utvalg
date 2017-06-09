

%macro graastaer(datasett =);

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag:;
     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,3) in ('H25') then graast_diag=1;
     end;

array Prosedyre {*} NC:;
    do i=1 to dim(prosedyre); 
		if substr(prosedyre{i},1,5) in ('CJE20') then graast_pros=1;
		
end;

array takst {15} Normaltariff:;
	do k = 1 to 15;
		if substr (takst {k}, 1,4) in ('K01a') then graast_takst=1;
	end;

	if graast_diag=1 and graast_pros = 1 then Graast_opr_pros=1;
	if graast_diag=1 and graast_takst=1 then Graast_opr_takst=1;
	if graast_opr_pros=1 or graast_opr_takst=1 then Graast_opr=1;	
	drop graast_diag graast_pros graast_takst;
												
run;

%mend graastaer;






%macro hoereapp(datasett =);

data &datasett;
set &datasett;

array prosedyre {*} NC:;
     	do i=1 to dim(prosedyre);
				if prosedyre{i} in ('DXGT00') then happ=1;
		end;

array takst {15} Normaltariff:;
		do k = 1 to 15;
			if substr (takst {k}, 1,4) in ('324a', '324b') then happ = 1;	
		end;

run;

proc sort data= &datasett;
by happ PID INNDATO UTDATO;
run;

data  &datasett;
set  &datasett;
	by happ PID INNDATO UTDATO;
	if happ=1 then do;
	if first.PID=1 then unik_happ=1;
	end;

If unik_happ = 1 and aar = 2015 then unik_happ_15 = 1;
If unik_happ = 1 and aar = 2014 then unik_happ_14 = 1;
If unik_happ = 1 and aar = 2013 then unik_happ_13 = 1;

run;

%mend hoereapp;



%macro injeksjon_oye(datasett =);

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag:;
     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,4) in ('H348') then Veneokklusjon=1;
         if substr(diagnose{i},1,4) in ('H353') then AMD=1;
	 if substr(diagnose{i},1,4) in ('H360') then Diab_retinopati=1;
	 if substr(diagnose{i},1,4) in ('E103', 'E113') then Diab_oyekompl=1;
		 
     end;

array Prosedyre {*} NC:;
    do i=1 to dim(prosedyre); 
		if substr(prosedyre{i},1,5) in ('CKD05') then injek_pros=1; 
		if substr(prosedyre{i},1,5) in ('ZXC15') then PDT_pros=1; 
		if substr(prosedyre{i},1,5) in ('CKC12') then laser_pros=1; 
end;
	/*kode for å fremstille ulike behandlingsteknikker ved retinasykdommer*/
	if Diab_oyekompl= 1 or Diab_retinopati = 1 or Veneokklusjon=1 or AMD=1 then Retinasykdom=1;
	if Retinasykdom=1 and injek_pros=1 then injek_retinasykd=1;
	if Retinasykdom=1 and PDT_pros=1 then PDT_retinasykd=1;
	if Retinasykdom=1 and laser_pros=1 then laser_retinasykd=1;
	/*OBS! - Her teller vi sannsynligvis de som har fått flere behandlinger flere ganger i tredelt figur*/

	/*kode for å fremstille ulike indikasjoner (diagnoser) ved injeksjonsbehandling*/
	if Veneokklusjon=1 and injek_pros=1 then injek_Vene=1;
	if AMD=1 and injek_pros=1 then injek_AMD=1;
	if (Diab_oyekompl= 1 or Diab_retinopati = 1) and injek_pros = 1 then injek_diab = 1;	

	if injek_Vene=1 or injek_AMD=1 or injek_diab=1 then injek=1;

	if injek_AMD = 1 and injek_diab = 1 then injek_amd_diab = 1;

	drop injek_pros Veneokklusjon AMD diab_retinopati Diab_oyekompl laser_pros PDT_pros;

run;

%mend injeksjon_oye;