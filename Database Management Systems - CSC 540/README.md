# CSC-540-Project1

### Benjamin Layko (bjlayko), Pradeep Patil (papatil), Matthew Replogle (msreplog), Andrew Terminiello (ajtermin)

To Run from Executable:

     java -jar execution.jar <unityid> <password>
     (unityid and password are for logging into Oracle database)

To Run as Java Project:

     To Set Classpath: export CLASSPATH=.:/afs/eos.ncsu.edu/software/oracle12/oracle/product/12.2/client/jdbc/lib/ojdbc8.jar
     To Compile: javac **/*.java
     To Run (From Main directory): java src/CarMaintenance unityid password

To Use SQLPlus: 
     
     add oracle12;
     sqlplus
     unityid@orcl01
     password

To Run Scripts:
     
     Start sqlplus
     Run the file by using @<path>/<filename>
     The path comes from the current directory. (ie: the current directory is usually the directory that you were located in before you launched SQLPlus.)

     Example for setup-
     @scripts/reset.sql
     @scripts/set_up.sql
     @scripts/populating.sql

For using the application to populate the tables:

     Make sure to run the populate_store.sql script first, importing store information.
     This is because all information reliant on Store and Service is inserted as part of
     populatie_service.sql.

To View tables created:
     
     SELECT table_name
          FROM user_tables
          ORDER BY table_name;

