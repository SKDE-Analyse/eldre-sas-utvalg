



%macro laarhals(datasett =);

data &datasett;
set &datasett;
drop laarhals: prot: annen:;
run;

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Bdiag: Tdiag:;
     do i=1 to dim(diagnose);
         if substr(diagnose{i},1,4) in ('S720') then laarhalsbrudd_diag=1;
     end;

array Prosedyre {*} NC:;
    do i=1 to dim(prosedyre); 
		if substr(prosedyre{i},1,5) in ('NFJ30','NFJ40','NFJ50','NFJ60','NFJ70','NFJ80','NFJ80') then Osteosyntese_Laarhals=1;
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

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		/*Primære hofteproteser*/
       if SUBSTR(prosedyre{i},1,3)='NFB' then Hofteprotese=1;

		
	   if SUBSTR(prosedyre{i},1,5) in ('NFB20', 'NFB30', 'NFB40','NFB99') then Hofteprotese_reg=1;


    end;  
run;

%mend hofteprotese;




%macro kneprotese(datasett = );

data &datasett;
set &datasett;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
	 /*Primære kneproteser*/
       if SUBSTR(prosedyre{i},1,3)='NGB' then kneprotese=1;

		if SUBSTR(prosedyre{i},1,4) in ('NGB0', 'NGB1') then kneprotese_reg=1;
	   if SUBSTR(prosedyre{i},1,5) in ('NGB20', 'NGB30', 'NGB40', 'NGB99') then kneprotese_reg=1;

	end;
run;

%mend kneprotese;
