#RDEX#\dontrun{
require(psd)
##
## Various utilities
##
set.seed(1234)
X <- rnorm(1e2)
##
## Matrix and vector creation:
##
# NA matrix
nd <- 5
na_mat(nd)
na_mat(nd,nd-1)
# zeros
zeros(nd)
# and ones
ones(nd)
##
## Check for tapers object:
##
is.tapers(X)
is.tapers(as.tapers(X))
##
## Check for spec object:
##
PSD <- spectrum(X, plot=FALSE)
# return is class 'spec'
is.spec(PSD) # TRUE
# but the underlying structure is just a list
PSD <- unclass(PSD)
is.spec(PSD) # FALSE
##
## Environment character strings
##
print(envname <- get_psd_env_name())
print(envir <- char2envir(envname))
try(char2envir("some nonexistent environment"), silent=TRUE) # error
# and environment objects:
print(.GlobalEnv)
envir2char(.GlobalEnv)
envir2char(envir)
try(envir2char(some_nonexistent_environment), silent=TRUE) # error
##
## decibels
##
dB(1) # signal is equal <--> zero dB
sig <- 1e-10
all.equal(sig, dB(dB(sig), invert=TRUE))
pow <- sig**2
all.equal(pow, dB(dB(sig, is.power=TRUE), invert=TRUE, is.power=TRUE))
## 
## Variance of difference series
##
vardiff(X)
varddiff(X)
all.equal(vardiff(X, TRUE), varddiff(X))
##
## modulo division
##
x <- 1:10
mc1a <- mod(1,2)
mc2a <- mod(1+x,2)
mc1b <- 1 %% 2
mc2b <- 1 + x %% 2
mc2c <- (1 + x) %% 2
all.equal(mc1a, mc1b) # TRUE
all.equal(mc2a, mc2b) # "Mean absolute difference: 2"
all.equal(mc2a, mc2c) # TRUE
##
#RDEX#}
