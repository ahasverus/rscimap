proximityWords <- function(x, word, tag = 'TI', threshold = 5){

    z <- lapply(x, function(x) {
        res <- NULL
        for (j in 1 : length(tag)){
            y <- strsplit(x[[tag[j]]], ' ')[[1]]
            pos <- which(y == word)
            if (length(pos) > 0){
                for (q in 1 : length(pos)){
                    if (pos[q] > 1){
                        res <- c(res, y[pos[q]-1])
                    }
                    if (pos[q] < length(y)){
                        res <- c(res, y[pos[q]+1])
                    }
                }
            }
        }
        return(res)
    })
    res <- sort(table(unlist(z)))
    res <- rev(sort(res[which(res >= threshold)]))
    if (!is.null(res) && length(res) > 0){
        return(res)
    } else {
        return(NULL)
    }
}
