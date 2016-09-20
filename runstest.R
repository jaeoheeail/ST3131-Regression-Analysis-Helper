### R CODE TO CARRY OUT RUNS TEST ###
# Prints out runs pattern, computes Z & decides whether to reject at alpha = 0.05. #

runstest <- function(model,alt){
  res <- model$res
  n2 <-0
  n1 <- 0
  u <- 1
  runpattern <- function(res){
    sign = NULL
    if (res[1]<0) {
      sign=FALSE
      cat("-")
      n2 <<- n2 + 1
    }
    else {
      sign = TRUE
      cat("+")
      n1 <<- n1 + 1
    }
    for (i in 2:length(res)){
      if (sign==TRUE & res[i] > 0) {
        cat("+")
        n1 <<- n1+1
      }
      else if (sign==TRUE & res[i] < 0) {
        n2 <<- n2 + 1
        cat(" ","-")
        sign = FALSE
        u <<- u+1
      }
      else if (sign==FALSE & res[i] < 0) {
        n2 <<- n2 + 1
        cat("-")
      }
      else if (sign==FALSE & res[i] > 0) {
        cat(" ","+")
        sign = TRUE
        u <<- u+1
        n1 <<- n1 + 1
      }
    }
    cat("\n")
  }
  runpattern(res)
  mu <- (2*n1*n2/(n1+n2))+1
  sigmasq <- ((2*n1*n2)*(2*n1*n2-n1-n2))/(((n1+n2)^2)*(n1+n2-1))
  z = (u-mu)/sqrt(sigmasq)
  cat("\n Number of Runs:",u)
  cat("\n Number of positives:",n1,"\n Number of negatives:", n2,"\n")
  cat("Z:",z,"\n")
  p_value = pnorm(z,mean=0,sd=1)
  reject = TRUE
  alpha = 0.05 # change this value if you want a different significance value
  if (alt=="two.sided"){
    p = p_value*2
    cat("p-value = ",p,"\n")
    if (p > alpha){reject=FALSE}
  }
  else if (alt=="less"){
    p = p_value
    cat("p-value = ",p,"\n")
    if (p > alpha){reject=FALSE}
  }
  else if (alt=="greater"){
    p = 1-p_value
    cat("p-value = ",p,"\n")
    if (p > alpha){reject=FALSE}
  }
  if (reject==FALSE){cat("Do not reject Null Hypothesis. No run pattern.\n")}
  else {cat("Reject Null Hypothesis. Too many or two few runs.")}
}

## Sample run
y <- c(95,71,83,91,102,87,93,100,104,94,113,96,83,84,102,100,105,57,121,86,100)
x <- c(15,26,10,9,15,20,18,11,8,20,7,9,10,11,11,10,12,42,17,11,10)
model1 <- lm(y~x)
runstest(model1,"greater") #H1: too many runs (one-sided test)
runstest(model1,"less") #H1: too few runs (one-sided test)
runstest(model1,"two.sided") #H1: too few or too many runs (two-sided)