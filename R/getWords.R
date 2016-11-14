getWords <- function(data, tag = 'TI', format = 'advanced', nmax = NULL){

    words <- strsplit(paste(unlist(lapply(data, function(x){
        y <- NULL
        for (j in 1 : length(tag)){
            y <- c(y, x[[tag[j]]])
        }
        return(y)
    })), collapse = ' ', sep = ''), ' ')[[1]]

    if (format == 'advanced'){

        words  <- table(words)[order(table(words), decreasing = TRUE)]
        twords <- data.frame(words)
        pos <- which((twords[ , 1]) == '')
        if (length(pos) > 0) twords <- twords[-pos, ]

        twords <- data.frame(words = paste(twords[ , 1], twords[ , 2], sep = ':'))
        if (is.null(nmax)){
            twords <- as.character(twords)
        } else {
            twords <- as.character(twords[1:nmax, ])
        }

        for (k in 1 : length(twords)){
            x <- strsplit(twords[k], '')[[1]]
            twords[k] <- paste(toupper(substr(twords[k], 1, 1)), tolower(substr(twords[k], 2, nchar(twords[k]))), sep = '')
        }

        cat(paste(twords, collapse = '\n'), file = './words2wordle-advanced.txt')
    }

    if (format = 'simple'){

        words  <- table(words)[order(table(words), decreasing = TRUE)]
        twords <- data.frame(words)
        pos <- which((twords[ , 1]) == '')
        if (length(pos) > 0) twords <- twords[-pos, ]

        if (is.null(nmax)){
            twords <- as.character(twords[ , 1])
        } else {
            twords <- as.character(twords[1:nmax, 1])
        }

        cat(paste(twords, collapse = ' '), file = './words2wordle-simple.txt')
    }

    if (!(format %in% c('simple', 'advanced')))
        stop('Format has to be < simple > or < advanced >.')

    return(twords)
}
