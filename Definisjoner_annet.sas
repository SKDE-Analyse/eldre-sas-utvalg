



%macro under_aattifem(datasett = );

data &datasett;
set &datasett;

if alder lt 85 then under_aattifem = 1;
run;

%mend;

%macro over_aattifem(datasett = );

data &datasett;
set &datasett;

if alder ge 85 then over_aattifem = 1;
run;

%mend;

%macro dod_etter_ett_aar(datasett =, variabel =alle);


data &datasett;
set &datasett;

%if &variabel = alle %then %do;
if doddato - eoc_utdato < 365 then dod = 1;
%end;
%else %do;
if doddato - eoc_utdato < 365 and &variabel = 1 then dod_&variabel = 1;
%end;

run;

%mend;



