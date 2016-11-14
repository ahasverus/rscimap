\name{filterArticles}
\alias{filterArticles}

\title{Select only some types of documents}

\description{Select only some types of documents (i.e. scientific papers, reviews and editorials)}

\usage{
    filterArticles(files, type = c('Article', 'Editorial Material', 'Review'))
}

\arguments{
    \item{files}{A vector of filenames containing bibliographic citations}
    \item{type}{A vector of documents types}
}

\value{A list in which each element is a bibliographic citation in a specific format (i.e. a sub-list where each element is a specific information [authors, keywords, title, etc.]).}

\author{Nicolas Casajus}

\examples{
### See https://github.com/ahasverus/rscimap
}
