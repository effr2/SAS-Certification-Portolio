/* Eric Fernandez Case Study */
/* I certify that the SAS code given is my original and exclusive work */

/* Part 1 DATA EXPLORATION */
/* 1(a) */
/* Datastep */
/* 
 * To read the file:
 * -Locate the file 'Teen.csv'
 * -Right click on 'Teen.csv' and select 'Properties'
 * -Copy and paste the path name to the FILENAME statement
 */
FILENAME CSV "~/STA3064/Teen.csv" TERMSTR=CRLF;
PROC IMPORT DATAFILE=CSV
		    OUT=teen
		    DBMS=CSV
		    REPLACE;
RUN;
/* Print first 20 observations */
PROC PRINT data=teen(obs=20);
RUN;

/* 1(b) */
/* Scatter plot for all the variables plotted against each other */
PROC SGSCATTER data=teen;
	matrix BirthRate BelowPovLev Crowded Dependency NoHSDiploma Income Unemployment;
RUN;

/* Output correlation coefficient table */
PROC CORR data=teen;
RUN;

/* Part 2 MODEL FITTING AND ANALYSIS */
/* 2(a), 2(b), 2(c) and 2(d) */
/* Look at ANOVA test and R-square*/
PROC REG data=teen;
	model BirthRate = Unemployment;
RUN;

/* Perform Box-Cox test to obtain lambda for power transformation */
PROC TRANSREG data=teen;
	model Boxcox(BirthRate)=Identity(Unemployment);
RUN;

/* Transform response using the lambda obtained from Box-Cox */
DATA TeenTransformed;
	set teen;
	TransformedBirthRate=BirthRate**0.75;
RUN;

/* 
 * Look at R2 and residual vs quantile plot to asses if transformation
 * is benefitial
 */
PROC REG data=TeenTransformed;
	model TransformedBirthRate = Unemployment;
RUN;

/* 2(e) */
/* Confidence intervals -- 95% default */
PROC REG data=teen;
	model BirthRate = Unemployment/clb; /* Confidence interval for the slope */
RUN;

/* 2(f) */
/* Bootstrap for slope Confidence Interval */
/* Generate 1000 replications with equal probability and with replacement(URS). */
PROC SURVEYSELECT Data=teen out=boot
                  seed=4321 samprate=1
                  method=urs outhits rep=1000; 
RUN;

/* Regression on every sample to find the slopes */
PROC REG data=boot outest=betas noprint;
	model BirthRate= Unemployment;
	by replicate;
RUN;

PROC UNIVARIATE data=betas noprint;
	var Unemployment;
	output out=BootCI pctlpts= 2.5 97.5  pctlpre=Conf_Limit_;
RUN;
/* Print 95% Confidence interval of the bootstrap set */
PROC PRINT data=BootCI;
RUN;

/* 2(g) */
/* Perform ANOVA on the model of 2(a) to verify model's effectiveness */
PROC ANOVA data=teen;
	class Unemployment;
	model BirthRate = Unemployment;
RUN;

/* 2(h) */
/* Create dataset with Unemployment=1.2 */
DATA NewTeen;
Input BirthRate Unemployment;
datalines;
. 1.2
;
RUN;

/* Create new Data set with old values plus the value created. */
DATA Teen2;
	set NewTeen teen; /* Concatenate Data Sets */
RUN;

/* Produce both 95% confidence and prediction intervals around the predicted response for x*.  */
PROC REG data=Teen2;
	model BirthRate = Unemployment/cli clm;
	id unemployment;
RUN;

/* 2(i) */
PROC REG data=Teen;
	model BirthRate = BelowPovLev Crowded Dependency NoHSDiploma Income Unemployment /VIF; /* VIF checks for multicolinearity */
RUN;
/* Model with no NoHSDiploma due to high VIF*/
PROC REG data=Teen;
	model BirthRate = BelowPovLev Crowded Dependency Income Unemployment /VIF; /* VIF checks for multicolinearity */
RUN;

/* 2(j) */
/* Stepwise method for variable selection. This model does not include NoHSDiploma*/    
PROC REG data=Teen;
	model BirthRate = BelowPovLev Crowded Dependency Income Unemployment/selection=stepwise;
RUN;

/* 2(k), 2(l) and 2(n) */
/* Do a regression using only the variables obtained from the stepwise selection method */
PROC REG data=Teen plots(label)=(CooksD RStudentByLeverage);
	model BirthRate = Crowded Unemployment/r influence;
RUN;

data TeenNew ;
 set teen;
 if community = 37 then delete;/* remove obs 37*/
RUN;

/* fit model with new dataset */
PROC REG data=TeenNew;
	model BirthRate = Crowded Unemployment/r influence;
RUN;

/* 2(m) */
/*Nested F test*/
PROC REG data=Teen;
	model BirthRate = BelowPovLev Crowded Dependency Income Unemployment;
	test BelowPovLev,Dependency,Income ;
RUN;