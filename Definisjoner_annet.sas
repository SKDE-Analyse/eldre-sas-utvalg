



%macro under_aattifem(datasett = );

data &datasett;
set &datasett;

if alder lt 85 then under_aattifem = 1;
run;

%mend under_aattifem;

%macro over_aattifem(datasett = );

data &datasett;
set &datasett;

if alder ge 85 then over_aattifem = 1;
run;

%mend over_aattifem;




