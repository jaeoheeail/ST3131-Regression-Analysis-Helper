# ST3131-Regression-Analysis-Helper
> Perform all-in-one outlier tests and runs test

## outlierchecker.R
```
# Sample Run
y <- c(95,71,83,91,102,87,93,100,104,94,113,96,83,84,102,100,105,57,121,86,100)
x <- c(15,26,10,9,15,20,18,11,8,20,7,9,10,11,11,10,12,42,17,11,10)
model1 <- lm(y~x)
outlierchecker(model1)
  DFBETAS    DFFITS       hii 
0.4364358 0.6488857 0.0952381 
   dfb.1_ dfb.x   dffit    hat RSTUDENT
1                                      
2                       0.1545         
3                                      
4                                      
5                                      
6                                      
7                                      
8                                      
9                                      
10                                     
11                                     
12                                     
13                                     
14                                     
15                                     
16                                     
17                                     
18 0.8311       -1.1558 0.6516         
19               0.8537           3.607
20                                     
21                                     
```   
## runstest.R
```
# Sample Run   
runstest(model1,"greater") #H1: too many runs (one-sided test)
+  ---  +  -  +++++  ---  +++  -  +  -  +
 Number of Runs: 11
 Number of positives: 12 
 Number of negatives: 9 
Z: -0.1307441 
p-value =  0.5520111 
Do not reject Null Hypothesis. No run pattern.
```
