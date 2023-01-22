**free
ctl-opt dftactgrp(*no) actgrp(*caller)
option(*nodebugio: *srcstmt)
;
dcl-f File001L  disk usage(*input) keyed;

dcl-s i         packed(8);
dcl-s rows      packed(8);
dcl-s cliente   char(200);
dcl-s $exit     ind;
dcl-ds dsFILE002   extname('FILE002F') dim(10000) qualified end-ds;
dcl-ds dsFILE0021  extname('FILE002F') end-ds;

Exec SQL
SET OPTION commit=*none,
 closqlcsr=*endmod,
 COMPILEOPT = 'DBGVIEW(*ALL)'
;
// 1 - Lettura con SETLL+READE
Exec SQL
INSERT INTO TestLog
VALUES ('READE', '*START', CURRENT_TIMESTAMP)
;

setll ('C0000001') File001L;
dou %eof(File001L);
  reade ('C0000001') File001L;
  if not %eof(File001L);
     cliente = codcli + ' ' + ragsoc + ' ' + indir;
  endif;
enddo;

Exec SQL
INSERT INTO TestLog
VALUES ('READE', '*END', CURRENT_TIMESTAMP)
;
// 2 - Lettura con SQL a blocchi
Exec SQL
INSERT INTO TestLog
VALUES ('SQL', '*START', CURRENT_TIMESTAMP)
;

Exec SQL
DECLARE c1 CURSOR FOR
SELECT * FROM File002F
WHERE  codcli = 'C0000001'
;
Exec SQL
OPEN c1
;
$exit = *off;
dou $exit;
  Exec SQL
  FETCH c1 FOR 10000 ROWS INTO :dsFILE002
  ;
  select;
    when SQLCODE = 0;
       for i = 1 to %elem(dsFILE002);
         dsFILE0021 = dsFILE002(i);
           cliente = codcli + ' ' + ragsoc + ' ' + indir;
       endfor;
    when SQLCODE = 100;
      $exit = *on;
    other;
      $exit = *on;
  endsl;

enddo;

Exec SQL
INSERT INTO TestLog
VALUES ('SQL', '*END', CURRENT_TIMESTAMP)
;

*inLR = *on;
return;
