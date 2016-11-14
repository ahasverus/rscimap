\name{cleanReferences}
\alias{cleanReferences}

\title{Clean cited references in articles}

\description{Clean cited references in articles}

\usage{
    cleanReferences(data)
}

\arguments{
    \item{data}{A list of bibliographic returned by \code{\link{filterArticles}}}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
