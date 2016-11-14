correctSpelling <- function(x, tag = 'TI', word, replace = ''){

    ### Replace by group
    x <- lapply(x, function(x) {
        for (j in 1 : length(tag)){
            y <- strsplit(x[[tag[j]]], ' ')[[1]]
            pos <- which(y == word)
            if (length(pos) > 0) y[pos] <- replace
            x[[tag[j]]] <- paste(y, collapse = ' ')
        }
        return(x)
    })
    cat(paste0('>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(x, './analysis/articles.rds')
    return(x)
}
