\name{groupReferences}
\alias{groupReferences}

\title{Group similar cited references}

\description{Group similar cited references}

\usage{
    groupReferences(data, distance = 10, start = NULL)
}

\arguments{
    \item{data}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{distance}{A threshold above which cited references are considered dissimilar.}
    \item{start}{Cited references to avoid restart from the first if this is not the first time this function is used.}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
