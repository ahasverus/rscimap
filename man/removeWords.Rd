\name{removeWords}
\alias{removeWords}

\title{Remove common uninformative words}

\description{Remove common uninformative words}

\usage{
    removeWords(x, tag = 'TI', stopwords = TRUE, numbers = TRUE, adjectives = TRUE, adverbs = TRUE, oneletter = TRUE)
}

\arguments{
    \item{x}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{tag}{A vector of tags containing textual information}
    \item{stopwords}{If \code{TRUE} common words area deleted (i.e. and, or, then, also, etc.). See \code{\link{getStopwords}} for a complete list.}
    \item{numbers}{If \code{TRUE} numbers are deleted}
    \item{adjectives}{If \code{TRUE} common adjectives are deleted. See \code{\link{getStopwords}} for a complete list.}
    \item{adverbs}{If \code{TRUE} common adverbs are deleted. See \code{\link{getStopwords}} for a complete list.}
    \item{oneletter}{If \code{TRUE} one-letter words are deleted. See \code{\link{getStopwords}} for a complete list.}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\seealso{
    \code{\link{getStopwords}}
}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
