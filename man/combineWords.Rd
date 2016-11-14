\name{combineWords}
\alias{combineWords}

\title{Associate two words in a single one}

\description{Associate two words in a single one (interactive mode)}

\usage{
    combineWords(x, tag = 'TI', threshold = 3)
}

\arguments{
    \item{x}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{tag}{A vector of tags containing textual information}
    \item{threshold}{A threshold value to suggest word association.}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
