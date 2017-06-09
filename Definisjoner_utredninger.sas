


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

%macro Holter(datasett = );

data &datasett;
set &datasett;

array prosedyre {*} NC:;
	do i=1 to dim(prosedyre);
		if substr (prosedyre {i}, 1, 6) in ('FPFE15','FPFE30') then Holter= 1; 
			if substr (prosedyre {i}, 1, 6) in ('FPFE15') then Holter_gml= 1; /* NÅ OGSÅ MED FPFE30 - LANGTIDS EKG */
	end;
	
	array takst {15} Normaltariff:;
	do k = 1 to 15;
		if substr (takst {k}, 1,4) in ('129c','129g') then  Holter = 1; 
		if substr (takst {k}, 1,4) in ('129c','129g') then  Holter_gml = 1; 
	end;
	
run; 


%mend Holter;

