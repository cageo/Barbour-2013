\docType{methods}
\name{psd-environment}
\alias{get_adapt_history}
\alias{get_psd_env_name}
\alias{get_psd_env_pointer}
\alias{new_adapt_history}
\alias{psd-environment}
\alias{psd_envAssign}
\alias{psd_envAssignGet}
\alias{psd_envClear}
\alias{psd_envGet}
\alias{psd_envList}
\alias{psd_envRefresh}
\alias{psd_envStatus}
\alias{update_adapt_history}
\title{Various environment manipulation functions.}
\usage{
get_psd_env_pointer()

get_psd_env_name()

psd_envRefresh(verbose = TRUE)

psd_envClear()

psd_envStatus()

psd_envList()

psd_envGet(variable)

psd_envAssign(variable, value)

psd_envAssignGet(variable, value)

new_adapt_history(adapt_stages)

get_adapt_history()

update_adapt_history(stage, ntap, PSD, freq = NULL)
}
\arguments{
  \item{verbose}{logical; should messages be given?}

  \item{variable}{character; the name of the variable to
  get or assign}

  \item{value}{character; the name of the variable to
  assign}

  \item{adapt_stages}{scalar; The number of adaptive
  iterations to save (excluding pilot spectrum).}

  \item{stage}{scalar; the current stage of the adaptive
  estimation procedure}

  \item{ntap}{vector; the tapers}

  \item{PSD}{vector; the power spectral densities}

  \item{freq}{vector; the frequencies}
}
\value{
\code{psd_envRefresh} returns (invisibly) the result of
\code{psd_envStatus()}.

the object represented by \code{variable} in the \code{psd}
environment.
}
\description{
The computation of \emph{adaptive} power spectral density
estimates requires bookkeeping and non-destructive
manipulation of variables. The functions here are mainly
convenience wrappers designed to maintain variable
separation from the \code{.GlobalEnv} environment so that
no innocent variable is destroyed in the process of
iteratively computing spectra. \strong{The user should
generally not be using the \emph{setters} even though all
functions exist in the namespace.}

\code{get_psd_env_pointer} is a convenience wrapper to get
the environment pointer.

\code{get_psd_env_name} is a convenience wrapper to get the
environment name.

\code{psd_envRefresh} will clear any variables in the
enviroment and reset the initialization stamp.

\code{psd_envClear} clears the contents of the environment.

\code{psd_envStatus} returns a list of some information
regarding the status of the environment.

\code{psd_envList} returns a listing of any assignments.

\code{psd_envGet} returns the value of \code{variable}.

\code{psd_envAssign} assigns \code{value} to
\code{variable}, but does not return it.

\code{psd_envAssignGet} both assigns and returns a value.

\code{new_adapt_history} initializes a nested-list object
to store the data from each iteration.

\code{update_adapt_history} updates the adaptive estimation
history list.
}
\note{
\code{psd_envClear} does \emph{not} remove the
environment--simply the assignments within it.
}
\section{Defaults and Initialization}{
  One can use \code{get_psd_env_pointer()} and
  \code{get_psd_env_name()} to access the pointer and name
  of the environment, if needed.

  \code{psd_envRefresh} should be used when a fresh
  environment is desired: typically only if, for example,
  \code{\link{psdcore}} is used rather than
  \code{\link{pspectrum}}.
}

\section{Assigning and Retieving}{
  \code{psd_envAssign} and \code{psd_envGet} perform the
  assignments and retrieval of objects in the environment.
  A convenience function, \code{psd_envAssignGet}, is
  included so that both assignment and retrieval may be
  performed at the same time.  This ensures the assignment
  has succeeded, and the returned value is not from some
  other frame.
}

\section{Getters and Setters}{
  The functions here can be classified whether the get, or
  set variables in the environment; some do both. Others
  make no modifications to the environment.

  \subsection{Getter}{ \itemize{
  \item{\code{get_adapt_history}}{}
  \item{\code{get_psd_env_name}}{}
  \item{\code{get_psd_env_pointer}}{}
  \item{\code{psd_envGet}}{} \item{\code{psd_envList}}{}
  \item{\code{psd_envStatus}}{} } }

  \subsection{Setter}{ \itemize{
  \item{\code{new_adapt_history}}{}
  \item{\code{psd_envAssign}}{} } }

  \subsection{Getter and Setter}{ \itemize{
  \item{\code{psd_envAssignGet}}{}
  \item{\code{psd_envClear}}{}
  \item{\code{psd_envRefresh}}{}
  \item{\code{update_adapt_history}}{} } }
}

\section{Adaptive History}{
  The list object for historical adapt-data may be accessed
  with \code{\link{get_adapt_history}}. The top names of
  the returned list are \describe{
  \item{\code{stg_kopt}}{Sequential taper vectors.}
  \item{\code{stg_psd}}{Sequential power spectral density
  vectors.} \item{\code{freq}}{The frequencies for each set
  of \code{stg_kopt} and \code{stg_psd}.} }
}
\examples{
#RDEX#\dontrun{
require(psd)
##
## psd working environment
##
# Get some status information about the psd working environment
psd_envStatus()
#
# Get a list of all variables
psd_envList()
#
# Pull the variable "init" into .GlobalEnv
print(x <- psd_envGet("init"))
#
# Pull the adaptive history into .GlobalEnv
get_adapt_history()
#RDEX#}
}
\seealso{
\code{\link{psd-utilities}}, \code{\link{pspectrum}}
}

