CREATE OR REPLACE procedure DBADMIN.load_a_file(p_filename in varchar2 )
as
   l_clob     clob;
   l_bfile    bfile;
begin
   insert into all_text values (seq_all_text.nextval, p_filename, sysdate, empty_clob() )
   returning text into l_clob;
   -- Load Clob into a BFile
   -- Added another line of documentation
   l_bfile := bfilename( 'TEXT_FILES', p_filename );
   dbms_lob.fileopen( l_bfile );
   dbms_lob.loadfromfile( l_clob, l_bfile,
   dbms_lob.getlength( l_bfile ) );
   dbms_lob.fileclose( l_bfile );
end;
/