



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

%macro dod_etter_opphold(datasett =, variabel =alle);


data &datasett;
set &datasett;

/* Sjekker om pasient er død nå og om dødsfall skjedde etter inndato
(hvis før inndato: døddato er feil)
*/
if doddato ne . and doddato > eoc_inndato then do;
   	  if &variabel = 1 then dod_&variabel = 1;
      if doddato - eoc_utdato < 365 and &variabel = 1 then dod365_&variabel = 1;
      if doddato - eoc_utdato < 30 and &variabel = 1 then dod30_&variabel = 1;
end;

run;

%mend;


%macro elek_innl(datasett =);


data &datasett;
set &datasett;
 
   	  if innlegg = 1 and elektiv = 1 then inn_elek = 1;   

run;

%mend;



