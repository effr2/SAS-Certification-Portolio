/* Eric Fernandez Project-Phase B*/
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

/* Section 2 */

/* 2(a) */
/* Single Categorical Variable: Country of Origin */
Proc gchart data=WineReviews;  /* general bar charting proc */                                                   
        pie country/type=percent; /* pie chart */ 
       title 'Countries Percentage' ;                  
Run;                                                                          

/* 2(b) */
/* Single Quantitative Variable: Rating Points */
Proc sgplot data=WineReviews;
	histogram points;
	title 'Ratings';   
Run;
title ;

/* 2(d) */
/* Created a new dataset with other countries that are not France, US, 
   Spain or Italy merged into one group of countries called Other */
Data WineReviewsB;
	Set WineReviews;
	/* If countries are not Spain, US, Italy or France then change to Other*/
	if Country not in ('Spain' 'US' 'Italy' 'France') then country = 'Other';
Run;

/* Relationship between Quantitative and Categorial Response:
   Quantitative: Rating Points Categorical: Country of Origin*/
Proc sgplot data=WineReviewsB;
	vbox points / /* This is the quantitative variable for the y-axis */
	category = country; /* This is the categorical variable */
	title 'Relationship between Rating and Country of Origin'; 
Run;
title ;

/* 2(e) */
/* Relationship between Quantitative Variables:
   Quantitative Variables: x=Points y= Price*/
Proc sgplot data=WineReviews;
	scatter x=Points  y=Price; /* Quantitative Variables */
	title 'Relationship between Ratings and Prices'; 
Run;
title ;
/* Section 3 */

/* 3(a) */
/* Single Categorical Variable: Variety of Wine */
/* Counting varieties using proc freq */
Proc freq data=WineReviewsB;
	tables country; /* count the number of each type of variety */
	title 'Frequency of Country'; 
Run;
title ;

/* 3(b) */
/* Single Quantitative Variable: Price of Wines */
Proc means data=WineReviews;
	var Price;
	title 'Descriptive analysis of Prices of Wine'; 
Run; 
title ; 

/* 3(d) */
/* Relationship between Price and Variety  */
Proc means data=WineReviews;
    var price;
	class Variety;
	title 'Descriptive analysis of Prices of Wine per Variety'; 
Run;
title ;

/* 3(e) */
/* Relationship between points and price */
Proc corr data=WineReviews;
	var points price;
	title 'Relationship between Rating and Price';
Run;
title ;