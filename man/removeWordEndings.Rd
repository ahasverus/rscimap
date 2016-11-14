\name{removeWordEndings}
\alias{removeWordEndings}

\title{Remove words endings}

\description{Remove common words endings (e.g. verbs endings, plurial, etc.). An automatic process is performed, but user can also use an interactive mode to complete the process.}

\usage{
    removeWordEndings(x, tag = 'TI', ask = TRUE, import = FALSE)
}

\arguments{
    \item{x}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{tag}{A vector of tags containing textual information}
    \item{ask}{If \code{TRUE} an interactive mode is launched in addition to automatic mode.}
    \item{import}{If \code{TRUE} user can start this process from where he has stopped the last time.}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
