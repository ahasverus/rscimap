\name{removePonctuation}
\alias{removePonctuation}

\title{Remove punctuation characters in citations fields}

\description{Remove punctuation characters in citations fields}

\usage{
    removePonctuation(data, tag = 'TI', exception = NULL)
}

\arguments{
    \item{data}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{tag}{A vector of tags containing textual information}
    \item{exception}{A vector of punctuation symbols to keep. If \code{NULL} all punctuations characters are removed.}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
