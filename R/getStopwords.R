getStopwords <- function(which = 'stopwords'){

    if (which == 'stopwords'){
        return(readRDS(system.file("external/stopwords.rds", package = "rscimap")))
    }
    if (which == 'adjectives'){
        return(readRDS(system.file("external/adjectives.rds", package = "rscimap")))
    }
    if (which == 'adverbs'){
        return(readRDS(system.file("external/adverbs.rds", package = "rscimap")))
    }

    if (!(which %in% c('stopwords', 'adjectives', 'adverbs')))
        stop('which must be < stopwords >, < adjectives > or < adverbs >.')
}
