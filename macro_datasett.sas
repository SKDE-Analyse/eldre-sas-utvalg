%macro innlegg_poli(datasett = );
/* 
Todeling av datasettet:
innleggelser og dag/poliklinikk
(gjelder kun for off)
*/

data &datasett;
set &datasett;

innlegg = .;
poli = .;

If eoc_aktivitetskategori3 = 1 and eoc_Liggetid ge 1 then innlegg = 1;
else if eoc_aktivitetskategori3 = 1 and eoc_uttilstand in (2, 3) then innlegg = 1; * ut som død eller selvmord;
else if (eoc_aktivitetskategori3 = 1 and eoc_Liggetid=0) or eoc_aktivitetskategori3=2 then poli = 1;
else if eoc_aktivitetskategori3 = 3 then poli = 1;

run;

%mend;


%macro ohjelp_elektiv(datasett = );

/*Markere ohjelp og elektiv basert på innmatehast*/

data &datasett;
set &datasett;
  elektiv = .;
  ohjelp = .;
  if eoc_hastegrad = 4 then elektiv = 1;
  if eoc_hastegrad = 1 then ohjelp = 1;
run;

%mend ohjelp_elektiv;