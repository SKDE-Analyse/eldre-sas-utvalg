


%macro straaling(datasett = );

data &datasett;
set &datasett;


array prosedyre {*} NC:;
  do i=1 to dim(prosedyre);
    if substr(prosedyre{i},1,6) = 'WEOA00' then Straale =1;
    if substr(prosedyre{i},1,6) = 'WEOB05' then Bracky =1;
  end;
  if Straale =1 or Bracky =1 then Straale_Beh=1;
run;


	proc sort data=&datasett;
		by PID  descending Straale_Beh pid inndato utdato;
	run;

	data &datasett;
	set &datasett;
    	by pid descending Straale_Beh inndato utdato;
		if first.pid and Straale_Beh=1 then straale_unik=1;
/*		drop bracky straale;*/
	run;



%mend straaling;


/*Cellegift*/

%macro cellegft (datasett = );

data &datasett;
set &datasett;

     array diagnose {*} Hdiag: Bdiag: Tdiag:;
       do i = 1 to dim(diagnose); 
          if substr(diagnose{i},1,1) in ('C') then Kreft=1;
          if substr(diagnose{i},1,2) in ('D0') then Kreft=1;
          if substr(diagnose{i},1,3) in ('B21') then Kreft=1;
     end;

	array takst {*} Normaltariff:;
          do k = 1 to dim(takst);
          if substr (takst {k}, 1,3) in ('126') then Takst_kjemo = 1;
     end;

	if Cyto_1 ne ' ' then NewCyto=1;
	if Cyto_1 = ' ' then NewCyto=0;

	if kreft = 1 and (NewCyto = 1 or Takst_kjemo = 1) then cellegft = 1;

run;


	proc sort data=&datasett;
		by PID  descending cellegft pid inndato utdato;
	run;

	data &datasett;
	set &datasett;
    	by pid descending cellegft inndato utdato;
		if first.pid and cellegft=1 then cellegft_unik=1;
		drop takst_kjemo newcyto kreft;
	run;




%mend cellegft;