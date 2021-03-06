\name{parabolic_weights}
\alias{parabolic_weights}
\alias{parabolic_weights.tapers}
\alias{parabolic_weights_fast}
\alias{parabolic_weights_fast.default}
\alias{parabolic_weights_fast.tapers}
\title{Calculate parabolic weighting factors.}
\usage{
parabolic_weights(tapvec, tap.index = 1L)

\method{parabolic_weights}{tapers}(tapvec, tap.index = 1L)

parabolic_weights_fast(ntap = 1L)

\method{parabolic_weights_fast}{default}(ntap = 1L)
}
\arguments{
  \item{tapvec}{\code{'tapers'} object; the number of
  tapers at each frequency}

  \item{tap.index}{integer; the index of \code{tapvec} from
  which to produce a sequence of weights for}

  \item{ntap}{integer; the number of tapers to provide
  weightings for.}
}
\value{
A list with taper indices, and the weights \eqn{W_N}.
}
\description{
The resampled spectrum involves summing weighted tapers;
this produces the weighting factors.
}
\details{
If one has a \code{tapers} object, specify the
\code{taper.index} to produce a sequence of weights up to
the value at that index; the user is likely to never need
to use this function.

Weighting factors are calculated as follows: \deqn{W_N
\equiv n_T^2 - \frac{3 K_N^2}{2 n_T (n_T - 1/4) (n_T + 1)}}
where \eqn{n_T} is the total number of tapers, and
\eqn{K_N} is the integer sequence \eqn{[0,n_T-1]}
}
\examples{
#RDEX#\dontrun{
require(psd)
##
## Show parabolic weighting factors
##

## some preliminaries
require(grDevices)
require(RColorBrewer)
#
maxx <- 1e3
xseq <- c(5,maxx,seq(from=1,to=2.8,by=0.2))
# plot palette
pal <- "Spectral"
npal <- switch(pal, RdYlBu=11, Spectral=11, Blues=9)
pal.col <- RColorBrewer::brewer.pal(npal, pal)
cols <- rev(grDevices::colorRampPalette(pal.col)(maxx))

## a roundabout way of bootstrapping y-axis limits:
WgtsU <- parabolic_weights_fast(xseq[1])
xseq <- xseq[-1]
DfU <- data.frame(matrix(unlist(WgtsU), ncol=2, byrow=FALSE))
WgtsL <- parabolic_weights_fast(xseq[1])
xseq <- xseq[-1]
DfL <- data.frame(matrix(unlist(WgtsL), ncol=2, byrow=FALSE))
# the limits:
ylims <- round(dB(c(min(DfL$X2), max(DfU$X2))), 1) + c(-2,5)

# function for plotting text
TFUN <- function(Df.){
  tx <- max(Df.$X1)
  ty <- mean(Df.$X2)
  text(log10(tx)+0.1, dB(ty), sprintf("\%i", tx), col=cols[tx])
}
# function for weighting factors and plotting
WFUN<-function(x){
  message(x)
  Wgts <- parabolic_weights_fast(x)
  Df <- data.frame(matrix(unlist(Wgts), ncol=2, byrow=FALSE))
  lcol <- cols[x]
  lines(dB(X2) ~ log10(X1), Df, type="s", lwd=2, col=lcol)
  TFUN(Df)
}

## Plot parabolic weighting, in dB, colored by maximum num tapers
plot(dB(X2) ~ log10(X1), DfU, type="s", xlim=c(0, log10(maxx)+0.2), 
     col=cols[5], lwd=2, ylim=ylims, yaxs="i", 
     main="Multitaper weighting factors by maximum tapers applied",
     xlab="log10 taper sequence", 
     ylab="dB")
TFUN(DfU)
invisible(lapply(round(10**xseq), FUN=WFUN))
WFUN(maxx)

##
#RDEX#}
}
\author{
A.J. Barbour <andy.barbour@gmail.com> adapted original by
R.L.Parker, and authored the optimized version.
}
\seealso{
\code{\link{psdcore}}, \code{\link{riedsid}}
}
\keyword{tapers}
\keyword{tapers-weighting}

