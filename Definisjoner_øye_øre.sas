

%macro graastaer(datasett =);

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag: Tdiag:;
     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,3) in ('H25') then graast_diag=1;
     end;

array Prosedyre {*} NC:;
    do i=1 to dim(prosedyre); 
		if substr(prosedyre{i},1,5) in ('CJE20') then graast_pros=1;
		if substr(prosedyre{i},1,5) in ('CJE20','CJE25') then graast_pros_begge=1;		/*Også CJE25?*/
end;

array takst {15} Normaltariff:;
	do k = 1 to 15;
		if substr (takst {k}, 1,4) in ('K01a') then graast_takst=1;
	end;

	if graast_diag=1 and graast_pros = 1 then Graast_opr_pros=1;
	if graast_diag=1 and graast_takst=1 then Graast_opr_takst=1;
	if graast_opr_pros=1 or graast_opr_takst=1 then Graast_opr=1;	
	if graast_diag=1 and graast_pros_begge = 1 then Graast_opr_pros_bg=1;
												
run;

%mend graastaer;






%macro hoereapp(datasett =);

data &datasett;
set &datasett;
array prosedyre {*} NC:;
     	do i=1 to dim(prosedyre);
        	if prosedyre{i} in ('DXGT00', 'DXGT05') then happ=1;
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


run;

%mend hoereapp;



%macro injeksjon_oye(datasett =);

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag: Tdiag:;
     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,3) in ('H35') then retinopati=1;
		 if substr(diagnose{i},1,3) in ('H36') then diab_retinopati=1;
		 if substr(diagnose{i},1,3) in ('E10', 'E11') then diab_mellitus=1;
		 
     end;

array Prosedyre {*} NC:;
    do i=1 to dim(prosedyre); 
		if substr(prosedyre{i},1,5) in ('CKD05') then injek_pros=1;  /*Også CJE25?*/
end;

	if retinopati=1 and injek_pros=1 then injek_AMD=1;
	if (diab_mellitus = 1 or diab_retinopati = 1) and injek_pros = 1 then injek_diab = 1;	
	if injek_AMD=1 or injek_diab=1 then injek=1;

proc sort data= &datasett;
	by injek PID INNDATO UTDATO;
run;

data  &datasett;
set  &datasett;
	by injek PID INNDATO UTDATO;
	if injek=1 then do;
	if first.PID=1 then unik_injek=1;
	end;

	if unik_injek=1 and injek_AMD=1 then unik_inj_AMD=1;
	if unik_injek=1 and injek_diab=1 then unik_inj_diab=1;

	drop unik3aar injek_pros retinopati diab_retinopati diab_mellitus;

run;

%mend injeksjon_oye;