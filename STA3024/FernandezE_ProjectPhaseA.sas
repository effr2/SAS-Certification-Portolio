/* Eric Fernandez Project-Phase A*/
/* I certify that the SAS code given is my original and exclusive work*/

/* To read the file:
 Create a  new folder.
 Upload 'winemag-data_first150k.csv' to the folder
 Right click on 'winemag-data_first150k.csv' and select Properties
 Copy the path name and paste to the filename statement below
 Add a slash and the file name to the end of the path
*/
FILENAME CSV "~/STA3024/winemag-data_first150k.csv" TERMSTR=LF;


/** Import the CSV file.  **/
PROC IMPORT DATAFILE=CSV
		    OUT=WineReviews
		    DBMS=CSV
		    REPLACE;
RUN;

/*Print out the first 20 reviews out of 150,000 reviews*/
proc print data=WineReviews(obs=20);
run;