\name{correctSpelling}
\alias{correctSpelling}

\title{Manual correction of word spelling}

\description{Manual correction of word spelling}

\usage{
    correctSpelling(x, tag = 'TI', word, replace = '')
}

\arguments{
    \item{x}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{tag}{A vector of tags containing textual information}
    \item{word}{The old spelling of one single word (no space)}
    \item{replace}{The new spelling of the word (space allowed)}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
