combineWords <- function(x, tag = 'TI', threshold = 3){

    words <- NULL
    for (i in 1 : length(tag)){
        words <- c(words, unlist(lapply(x, function(x) x[[tag[i]]])))
    }
    words <- paste(words, collapse = ' ', sep = '')
    words <- strsplit(words, ' ')[[1]]
    freq <- table(words)[order(table(words), decreasing = TRUE)]
    words <- names(table(words))[order(table(words), decreasing = TRUE)]

    k <- 1
    newWords <- NULL
    cat('\n----------------------------------------------------\n')
    cat('\n>>> Combine words in one term - Interactive mode <<<\n\n')
    cat('   () Type enter to go to the next word\n   () Select the term number to add\n      - Then choose the form\n      - Write the acronym (no punctation nor space)\n   () Type \'c\' to save and exit\n\n')
    cat('----------------------------------------------------\n\n')

    while (freq[k] >= threshold){
        ppp <- proximityWords(refs, word = words[k], tag = tag, threshold = threshold)
        if (!is.null(ppp)){
            aaa <- 0
            while (aaa != '' && aaa != 'c'){
                cat('\n>>>', words[k], '\n')
                cat('\n', paste(1:length(ppp), ': ', names(ppp), '\n', sep = ''))
                aaa <- readline('\nGroup with: ')
                if (aaa %in% as.character(c(1:length(ppp)))){
                    cat('\nSuggested spelling\n', c(paste('1:', names(ppp)[as.numeric(aaa)], words[k]), '\n', paste('2:', words[k], names(ppp)[as.numeric(aaa)])), '\n')
                    ccc <- 0
                    while (as.numeric(ccc) != 1 && as.numeric(ccc) != 2){
                        ccc <- readline('\nWhich spelling: ')
                    }
                    old <- ifelse(ccc == 1, paste(names(ppp)[as.numeric(aaa)], words[k]), paste(words[k], names(ppp)[as.numeric(aaa)]))
                    new <- readline('Group name: ')
                    newWords <- c(newWords, new)

                    ### Replace by group
                    x <- lapply(x, function(x){
                        for (j in 1 : length(tag)){
                            x[[tag[j]]] <- gsub(old, new, x[[tag[j]]])
                        }
                        return(x)
                    })

                    ppp <- ppp[-as.numeric(aaa)]
                }
            }

            ### Redefine words
            words <- NULL
            for (i in 1 : length(tag)){
                words <- c(words, unlist(lapply(x, function(x) x[[tag[i]]])))
            }
            words <- paste(words, collapse = ' ', sep = '')
            words <- strsplit(words, ' ')[[1]]
            pos <- which(words %in% newWords)
            if (length(pos) > 0) words <- words[-pos]
            freq <- table(words)[order(table(words), decreasing = TRUE)]
            words <- names(table(words))[order(table(words), decreasing = TRUE)]

            if (aaa == 'c'){
                freq[k+1] <- threshold - 10
                cat('\n')
            }
        }
        k <- k + 1
    }
    cat(paste0('\n\n>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(x, './analysis/articles.rds')
    return(x)
}
