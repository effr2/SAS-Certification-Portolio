/* Read file spider.txt and store it in dataset spiders */
FILENAME longley '~/STA4203/longley.txt';
Data macroecon;
INFILE longley;
INPUT GNP_deflator GNP Unemployed Armed_Forces Population Year Employed;
run;

/* Problem 1-5*/
/*SSR for full model*/
PROC REG data=macroecon;
MODEL Employed= GNP_deflator GNP Unemployed Armed_Forces Population Year/vif;
plot r.*p.;
OUTPUT out=resids1 r=resid p=pred;
run;

/* Check for normality */
PROC UNIVARIATE data=resids1 normal plots;
var resid;
run;

/* Look for correlation between variables by using coefficients */
proc corr data=macroecon; 
var GNP_deflator GNP Unemployed Armed_Forces Population Year;
run;

/* Problem 6 */