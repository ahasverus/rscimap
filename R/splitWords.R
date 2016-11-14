splitWords <- function(x, tag = 'TI', import = TRUE){

    words <- NULL
    for (i in 1 : length(tag)){
        words <- c(words, unlist(lapply(x, function(x) x[[tag[i]]])))
    }
    words <- paste(words, collapse = ' ', sep = '')
    words <- strsplit(words, ' ')[[1]]
    words <- names(table(words))[order(table(words), decreasing = TRUE)]
    words <- unique(words[grep('-', words)])

    if (import){
        toAdd <- readRDS('./analysis/log-split.rds')
        for (q in 1 : ncol(toAdd)) toAdd[ , q] <- as.character(toAdd[ , q])
        ssop <- which(words %in% toAdd$old)
        if (length(ssop) > 0) words <- words[-ssop]
    }

    k <- 1
    NewWords <- character(length(words))
    cat('\n-------------------------------------------------\n')
    cat('\n>>> Split associated words - Interactive mode <<<\n\n')
    cat('   () Type enter to fusion words\n   () Type the new spelling\n   () Type \'-\' to delete the word\n   () Type \'c\' to save and exit\n\n')
    cat('-------------------------------------------------\n\n')

    while (k <= length(words)){
        cat('\n>>>', words[k], '\n')
        aaa <- readline('\nNew form: ')
        if (aaa != '' && aaa != 'c' && aaa != '-'){
            NewWords[k] <- new <- aaa
            x <- lapply(x, function(x) {
                for (j in 1 : length(tag)){
                    y <- tolower(strsplit(x[[tag[j]]], ' ')[[1]])
                    pos <- which(y == words[k])
                    if (length(pos) > 0) y[pos] <- new
                    x[[tag[j]]] <- paste(y, collapse = ' ')
                }
                return(x)
                })
        }
        if (aaa == ''){
            new <- strsplit(words[k], '-')[[1]]
            NewWords[k] <- new <- paste(new[1], toupper(substr(new[2], 1, 1)), substr(new[2], 2, nchar(new[2])), sep = '')
            x <- lapply(x, function(x) {
                for (j in 1 : length(tag)){
                    y <- tolower(strsplit(x[[tag[j]]], ' ')[[1]])
                    pos <- which(y == words[k])
                    if (length(pos) > 0) y[pos] <- new
                    x[[tag[j]]] <- paste(y, collapse = ' ')
                }
                return(x)
                })
        }
        if (aaa == '-'){
            NewWords[k] <- '-'
            x <- lapply(x, function(x){
                for (j in 1 : length(tag)){
                    y <- tolower(strsplit(x[[tag[j]]], ' ')[[1]])
                    pos <- which(y == words[k])
                    if (length(pos) > 0) y <- y[-pos]
                    x[[tag[j]]] <- paste(y, collapse = ' ')
                }
                return(x)
                })
        }
        if (aaa == 'c'){
            jj <- k - 1
            k <- length(words)
            cat('\n')
        }
        if (aaa != 'c' && k == length(words))
            jj <- k
        k <- k + 1
    }

    if (import){
        for (k in 1 : nrow(toAdd)){
            if (toAdd[k, 'new'] != '' && toAdd[k, 'new'] != '-'){
                x <- lapply(x, function(x) {
                    for (j in 1 : length(tag)){
                        y <- tolower(strsplit(x[[tag[j]]], ' ')[[1]])
                        pos <- which(y == toAdd[k, 'old'])
                        if (length(pos) > 0) y[pos] <- toAdd[k, 'new']
                        x[[tag[j]]] <- paste(y, collapse = ' ')
                    }
                    return(x)
                    })
            }
            if (toAdd[k, 'new'] == ''){
                NewWords[k] <- new <- gsub('-', ' ', aaa)
                x <- lapply(x, function(x) {
                    for (j in 1 : length(tag)){
                        y <- tolower(strsplit(x[[tag[j]]], ' ')[[1]])
                        pos <- which(y == toAdd[k, 'old'])
                        if (length(pos) > 0) y[pos] <- toAdd[k, 'new']
                        x[[tag[j]]] <- paste(y, collapse = ' ')
                    }
                    return(x)
                    })
            }
            if (toAdd[k, 'new'] == '-'){
                x <- lapply(x, function(x) {
                    for (j in 1 : length(tag)){
                        y <- tolower(strsplit(x[[tag[j]]], ' ')[[1]])
                        pos <- which(y == toAdd[k, 'old'])
                        if (length(pos) > 0) y <- y[-pos]
                        x[[tag[j]]] <- paste(y, collapse = ' ')
                    }
                    return(x)
                    })
            }
        }
        tab <- data.frame(old = as.character(words)[1:jj], new = as.character(NewWords)[1:jj])
        toAdd <- rbind(toAdd, tab)
    } else {
        toAdd <- data.frame(old = as.character(words)[1:jj], new = as.character(NewWords)[1:jj])
    }
    cat(paste0('>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(toAdd, './analysis/log-split.rds')
    saveRDS(x, './analysis/articles.rds')
    return(x)
}
