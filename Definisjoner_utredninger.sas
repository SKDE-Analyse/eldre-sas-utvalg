
%macro bentetthet (datasett=);

data &datasett;
set &datasett;

array prosedyre {*} NC:;
  do i=1 to dim(prosedyre);
    if substr(prosedyre{i},1,6) in ('NXFX05') then bentetthet=1;
  end;


%mend bentetthet;



%macro gastroskopi (datasett=);

data &datasett;
set &datasett;

array prosedyre {*} NC:;
  do i=1 to dim(prosedyre);
    if substr(prosedyre{i},1,6) in ('UJD02', 'UJD05') then gastroskopi=1;
  end;


%mend gastroskopi;



%macro kolonskopi (datasett=);

data &datasett;
set &datasett;

array prosedyre {*} NC:;
  do i=1 to dim(prosedyre);
    if substr(prosedyre{i},1,6) in ('UJF32', 'UJF35', 'UJF42', 'UJF45') then kolonskopi=1;
  end;


%mend kolonskopi;



%macro a_ekg(datasett = );

data &datasett;
set &datasett;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		if substr (prosedyre {i}, 1, 6) in ('FPFE50','FPFE55') then A_EKG = 1;
	end;
	
	array takst {15} Normaltariff:;
	do k = 1 to 15;
		if substr (takst {k}, 1,4) in ('129a') then A_EKG = 1;
		if substr (takst {k}, 1,3) in ('707') then A_EKG = 1;
	end;
	
run; 


%mend a_ekg;


%macro ekko(datasett = );

data &datasett;
set &datasett;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		if substr (prosedyre {i}, 1, 6) in ('FYDE30', 'FYDE31', 'FYDE32','FYDE33') then EKKO = 1;
	end;
	
	array takst {15} Normaltariff:;
	do k = 1 to 15;
		if substr (takst {k}, 1,4) in ('129e','129d','129i') then  Ekko = 1; 
	end;
	
run; 


%mend ekko;