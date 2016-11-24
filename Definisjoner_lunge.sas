


%macro lunge(datasett = );

data &datasett;
set &datasett;

array diagnose {*} Hdiag: Tdiag:;
	do i=1 to dim(diagnose);
	                                            /* kols*/
                if substr(diagnose{i},1,3)='J44' then J44_H=1;                                  
                                               /* kronisk bronkitt */
                if substr(diagnose{i},1,3)='J40' then J40_H=1; 
                if substr(diagnose{i},1,3)='J41' then J41_H=1;
                if substr(diagnose{i},1,3)='J42' then J42_H=1;
                                               /* emfysem */
                if substr(diagnose{i},1,3)='J43' then J43_H=1;
                                               /* pneumonier */
                if substr(diagnose{i},1,3)in ('J12', 'J13', 'J14', 'J15', 'J16', 'J17', 'J18') then J12_18_H=1;
                                               /* akutt bronkitt */
                if substr(diagnose{i},1,3)='J20' then J20_H=1;
                if substr(diagnose{i},1,3)='J21' then J21_H=1; 
                                               /* uspesifisert akutt infeksjon i nedre luftveier */
                if substr(diagnose{i},1,3)='J22' then J22_H=1;                               
                                               /* akutt alvorlig astma */
                if substr(diagnose{i},1,3)='J46' then J46_H=1;
                                               /* respirasjonssvikt, ikas */
                if substr(diagnose{i},1,3)='J96' then J96_H=1;
                                              /* influensa */
                if substr(diagnose{i},1,3)in ('J09', 'J10', 'J11') then J09_J11_H=1;
											   /* Dyspné */
				if substr(diagnose{i},1,4)='R060'  then R060_H=1;  

                end;

   array Bdiagnose {*} Bdiag:;
	do i=1 to dim(Bdiagnose);
                /* kols */
          		if substr(Bdiagnose{i},1,3)='J44' then J44_B=1; 
				/* kronisk bronkitt */
                if substr(Bdiagnose{i},1,3)='J40' then J40_B=1; 
                if substr(Bdiagnose{i},1,3)='J41' then J41_B=1;
                if substr(Bdiagnose{i},1,3)='J42' then J42_B=1;
                /* emfysem */
                if substr(Bdiagnose{i},1,3)='J43' then J43_B=1;
				
    end;

if J44_H=1 or J43_H=1 or J42_H=1 or J41_H=1 or J40_H=1 then kols_H=1;
if J44_B=1 or J43_B=1 or J42_B=1 or J41_B=1 or J40_B=1 then kols_B=1;
if R060_H=1 or J09_J11_H=1 or J12_18_H or J20_H=1 or J22_H=1 or J46_H=1 or J96_H=1 then andre_luftveis_H=1;

/* alle episoder der helsehjelpen sannsynligvis er gitt grunnet kols */
if kols_H=1 or (andre_luftveis_H=1 and kols_B=1) then kols_alle=1;

/* akuttinnlagt for kols */
if kols_alle=1 and (liggetid>0 or utTilstand=2) and akutt=1 then kols_innl_akutt=1;

lungebet = .;
if J12_18_H = 1 and (kols_H ne 1 or kols_B ne 1) then lungebet = 1; 

drop J2: J4: J9: R0: kols_alle andre_luftveis_H kols_H kols_B;

run;


%mend lunge;