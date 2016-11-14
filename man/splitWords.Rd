\name{splitWords}
\alias{splitWords}

\title{Write a new spelling for associated words}

\description{Write a new spelling for associated words (i.e. transform < trade-off > into < tradeoff >)}

\usage{
    splitWords(x, tag = 'TI', import = TRUE)
}

\arguments{
    \item{x}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{tag}{A vector of tags containing textual information}
    \item{import}{If \code{TRUE} user can start this process from where he has stopped the last time.}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
