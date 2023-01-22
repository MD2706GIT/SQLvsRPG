**free
// -----------------------------------------------
// Carica 500.000 record nel file FILE001F
// -----------------------------------------------
ctl-opt dftactgrp(*no) actgrp(*caller)
option(*nodebugio: *srcstmt)
;
dcl-s i         packed(8);
dcl-s num       packed(8);
dcl-c random    'akjdnclkadjsclhbdsclhbfcjhbdfvjhdbchbjchjasbdcudye';
dcl-ds dsFILE001  extname('FILE001F') end-ds;

Exec SQL
SET OPTION commit=*none,
 closqlcsr=*endmod,
 COMPILEOPT = 'DBGVIEW(*ALL)'
;

for i = 1 to 500000;
   clear dsFILE001;
   num = getRandom( 10000000);
   ID =  i;
   codCli = 'C0000001';
   num = getRandom( 30);
   ragSoc = %subst(random: num: 20);
   num = getRandom( 30);
   indir = %subst(random: num: 20);
   num = getRandom( 40);
   local = %subst(random: num: 10);
   num = getRandom( 48);
   prov = %subst(random: num: 2);
   num = getRandom( 99999);
   cap = num;
   num = getRandom( 47);
   naz = %subst(random: num: 3);
   num = getRandom( 20);
   note = %subst(random: num: 30);
   Exec SQL
   INSERT INTO File001F VALUES(:dsFILE001)
   ;

endfor;

*inLR = *on;
return;

// ---------------------------------------------
// Restituisce numero casuale da 1 a pMax
// ---------------------------------------------

dcl-proc getRandom ;
   dcl-pi *n  packed(8);
     dcl-parm pMax  packed(8) const;  // num.max da restituire
   end-pi;
   dcl-s  num   packed(8);
   Exec SQL
   VALUES RAND() * :pmax + 1
   INTO   :num
   ;
   return num;
end-proc;
