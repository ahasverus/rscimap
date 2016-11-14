\name{checkSpelling}
\alias{checkSpelling}

\title{Group words with different spellings}

\description{Group words with different spellings (i.e. transform < nest >, < nests >, < nsets > and < nesting > into < nesting >).}

\usage{
    checkSpelling(data, tag = 'TI', distance = 5, method = 'lv')
}

\arguments{
    \item{data}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{tag}{A vector of tags containing textual information}
    \item{distance}{A threshold above which words are considered dissimilar.}
    \item{method}{A character indicating the string similarity measure method to be used to identify similar words. See \code{\link[stringdist]{stringdist}} for further informations.}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
