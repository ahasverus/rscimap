\name{getWords}
\alias{getWords}

\title{Get cleaned words}

\description{Get cleaned words to perform wordcloud.}

\usage{
    getWords(data, tag = 'TI', format = 'advanced', nmax = NULL)
}

\arguments{
    \item{data}{A list of bibliographic returned by \code{\link{filterArticles}}}
    \item{tag}{A vector of tags containing textual information}
    \item{format}{< simple > for all words in a file or < advanced > for words associated with their frequency}
    \item{nmax}{The number of words (sorting by their frequency)}
}

\value{A vector of words or word/frequency.}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
