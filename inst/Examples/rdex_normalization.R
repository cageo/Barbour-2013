# \dontrun{
##
## Normalization
##
set.seed(1234)
# timeseries with sampling frequency **not** equal to 1:
X <- ts(rnorm(1e3), frequency=20)
# spec.pgram: double sided
pgram <- spectrum(X)
# psdcore: single sided
psd <- psdcore(X)
# note the normalization differences:
plot(pgram, log="dB", ylim=c(-40,10))
plot(psd, add=TRUE, col="red", log="dB")
# A crude representation of integrated spectrum: 
#   should equal variance of white noise series (~= 1)
mean(pgram$spec)*max(pgram$freq)
mean(psd$spec)*max(psd$freq)
#
# normalize objects with class 'spec'
pgram <- normalize(pgram, src="spectrum")
psd <- normalize(pgram, src="rlpspec")
# replot them
plot(pgram, log="dB", ylim=c(-40,10))
plot(psd, add=TRUE, col="red", log="dB")
#
# Again, integrated spectrum should be ~= 1:
mean(pgram$spec)*max(pgram$freq)
mean(psd$spec)*max(psd$freq)
#
# }