/* Problems 1-6 */
filename what "~/STA4853/hw2p1_data.txt";
data hw2p1;
infile what;
input z1-z6;
run;

/* The following code will produce the usual items
   used to "identify" an ARMA model for a time series. 
   This will be done for each of the series z1 to z6.  */

proc arima data=hw2p1;
identify var=z1; /* Problem 1 */
identify var=z2; /* Problem 2 */
identify var=z3; /* Problem 3 */
identify var=z4; /* Problem 4 */
identify var=z5; /* Problem 5 */
identify var=z6; /* Problem 6 */
run;

/* Problems 7-11 */
filename what "~/STA4853-Homeworks/hw2p2_data.txt";

data look;
infile what;
time=_n_;
input z7-z11;
run;
/* Problem 7 */
/* Creating time series plots for z7 to z11. */
title "Series z7";
proc sgplot data=look;
series x=time y=z7;
run;

/* Splitting series z7 into half */
title "Series z7, observations 1 to 100";
proc arima data=look(firstobs=1 obs=100);
identify var=z7;
run;

title "Series z7, observations 101 to 200";
proc arima data=look(firstobs=101 obs=200);
identify var=z7;
run;

/* Problem 8 */
title "Series z8";
proc sgplot data=look;
series x=time y=z8;
run;

/* Splitting series z8 into half */
title "Series z8, observations 1 to 100";
proc arima data=look(firstobs=1 obs=100);
identify var=z8;
run;

title "Series z8, observations 101 to 200";
proc arima data=look(firstobs=101 obs=200);
identify var=z8;
run;

/* Problem 9 */
title "Series z9";
proc sgplot data=look;
series x=time y=z9;
run;

/* Problem 10 */
title "Series z10";
proc sgplot data=look;
series x=time y=z10;
run;

/* Splitting series z10 into half */
title "Series z10, observations 1 to 100";
proc arima data=look(firstobs=1 obs=100);
identify var=z10;
run;

title "Series z10, observations 101 to 200";
proc arima data=look(firstobs=101 obs=200);
identify var=z10;
run;

/* Problem 11 */
title "Series z11";
proc sgplot data=look;
series x=time y=z11;
run;

/* Splitting series z11 into half */
title "Series z11, observations 1 to 100";
proc arima data=look(firstobs=1 obs=100);
identify var=z11;
run;

title "Series z11, observations 101 to 200";
proc arima data=look(firstobs=101 obs=200);
identify var=z11;
run;
