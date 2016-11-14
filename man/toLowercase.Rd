\name{toLowercase}
\alias{toLowercase}

\title{Convert all citations fields to lower case}

\description{Convert all citations fields to lower case}

\usage{
    toLowercase(data, tag = 'TI')
}

\arguments{
    \item{data}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{tag}{A vector of tags containing textual information}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
