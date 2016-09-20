# Function takes in any linear model and indicate DFBETAS/DFFITS/RSTUDENT with "*" 
# if it has exceeded the corresponding value. 
# Saves one the trouble to look through every single observation.

outlierchecker <- function(model){
  p <- length(model$coeff)-1
  n <- length(model$fitted)
  hii <- (p+1)/n
  dffits <- 2*sqrt((p+1)/(n-p-1)) 
  dfbetas <- 2/sqrt(n)
  dfval <- as.data.frame(influence.measures(model)$infmat) 
  
  #print(influence.measures(model)) # uncomment to show printout of full output
  
  ncols <- ncol(dfval)-3 # Number of columns up to DFFIT
  dfval <- dfval[,c(1:ncols,length(dfval))] # Include hat
  
  #print(dfval) # uncomment to show printout of remaining values
  
  output <- matrix(c(rep("",ncol(dfval)*nrow(dfval))),nc=ncols+1)
  for (i in 1:nrow(output)) {
    for (j in 1:ncol(output)){
      if (j < ncol(output)-2) {
        if (abs(dfval[i,j]) > dfbetas) { #DFBETAS
          output[i,j] <- round(dfval[i,j],4)
        }
      }
      else if (j == ncol(output)-1) {
        if (abs(dfval[i,j]) > dffits) { #DFFITS
          output[i,j] <- round(dfval[i,j],4)
        }
      }
      else if (j == ncol(output)) {
        if (abs(dfval[i,j]) > hii) { #HAT
          output[i,j] <- round(dfval[i,j],4)
        }
      }
    }
  }
  
  output <- as.data.frame(output)
  names(output) <- colnames(dfval)
  rstudentval <- rstudent(model)
  eii <- character(n)
  for (i in 1:length(rstudentval)){
    if (abs(rstudentval[i]) > 2 ){
      eii[i] = round(rstudentval[i],4)
    }
  }
  
  output$RSTUDENT = eii
  bounds <- c(dfbetas,dffits,hii)
  names(bounds) <- c("DFBETAS","DFFITS","hii")
  print(bounds)
  print(output)
}

# Sample Run
y <- c(95,71,83,91,102,87,93,100,104,94,113,96,83,84,102,100,105,57,121,86,100)
x <- c(15,26,10,9,15,20,18,11,8,20,7,9,10,11,11,10,12,42,17,11,10)
model1 <- lm(y~x)
outlierchecker(model1)