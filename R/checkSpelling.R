checkSpelling <- function(data, tag = 'TI', distance = 5, method = 'lv'){

    require(stringdist)

    words <- NULL
    for (i in 1 : length(tag)){
        words <- c(words, unlist(lapply(data, function(x) x[[tag[i]]])))
    }
    words <- paste(words, collapse = ' ', sep = '')
    words <- strsplit(words, ' ')[[1]]
    words <- names(table(words))[order(table(words), decreasing = TRUE)]

    k <- 1 ; z <- 1
    groups <- list()
    cat('\n----------------------------------------------\n')
    cat('\n>>> Check word spelling - Interactive mode <<<\n\n')
    cat('   () Type enter to go to the next word\n   () Select the term-s- number-s- to group\n      - Then choose the group name\n   () Type \'c\' to save and exit\n\n')
    cat('----------------------------------------------\n\n')

    while (k <= length(words)){

        x <- stringdistmatrix(words, words[k], method = method)
        near <- sort(words[which(x <= distance & x > 0)])

        if (length(near) > 0){
            cat('\n>>>', words[k], '\n')
            print(paste(1 : length(near), ':', near))
            aaa <- readline('\nGroup: ')
            if (aaa != '' && aaa != 'c'){
                aaa <- strsplit(aaa, '[[:punct:]]| |[[:punct:]] | [[:punct:]] ')[[1]]
                groups[[z]] <- c(words[k], near[as.numeric(aaa)])
                bbb <- readline('Group name: ')
                names(groups)[z] <- bbb

                ### Replace by group
                data <- lapply(data, function(x) {
                    for (j in 1 : length(tag)){
                        wordsx <- tolower(strsplit(x[[tag[j]]], ' ')[[1]])
                        sop <- which(wordsx %in% groups[[z]])
                        if (length(sop) > 0) wordsx[sop] <- names(groups)[z]
                        x[[tag[j]]] <- paste(wordsx, collapse = ' ')
                    }
                    return(x)
                })

                ### Reextract words
                words <- NULL
                for (i in 1 : length(tag)){
                    words <- c(words, unlist(lapply(data, function(x) x[[tag[i]]])))
                }
                words <- paste(words, collapse = ' ', sep = '')
                words <- strsplit(words, ' ')[[1]]
                words <- names(table(words))[order(table(words), decreasing = TRUE)]

                pos <- which(words == groups[[z]][1])
                if (length(which(words == groups[[z]][1])) == 0)
                    k <- k - 1
                z <- z + 1
            } else {
                if (aaa == 'c'){
                    k <- length(words)
                    cat('\n')
                }
            }
        }
        k <- k + 1
    }
    cat(paste0('\n\n>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(data, './analysis/articles.rds')
    return(data)
}
