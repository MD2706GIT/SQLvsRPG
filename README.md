# SQLvsRPG
Compare traditional I/O performance against SQL FETCH in RPG

Instructions:
- Compile FILE001F, FILE002F and related LF 
- Create TESTLOG table: SRCFILE(mylib/myfile) SRCMBR(TESTLOG) COMMIT(*NONE)  
- Launch TEST002 program. This will add 500.000 records to FILE001F, with random data
- CPYF from FILE001F to FILE002F MBROPT(*REPLACE) so we have two files with exactly the same data
- Launch TEST001 program. This will read FILE001F with traditional RPG I/O instructions, and FILE002F with SQL blocked FETCH. Start and end times fir the two operations are collected in TESTLOG table
