removeWordEndings <- function(x, tag = 'TI', ask = TRUE, import = FALSE){

    verbsList <- readRDS(system.file("external/verbs.rds", package = "rscimap"))
    superlativesList <- readRDS(system.file("external/superlatives.rds", package = "rscimap"))

    x <- lapply(x, function(x) {

        for (i in 1 : length(tag)){
            if (length(x[[tag[i]]]) == 1){
                y <- tolower(strsplit(x[[tag[i]]], ' ')[[1]])
            } else {
                y <- x[[tag[i]]]
            }

            sop <- unlist(lapply(verbsList, function(x) ifelse(length(which(x %in% y) > 0), 1, 0)))
            sop <- sop[which(sop == 1)]
            if (length(sop) > 0){
                for (j in 1 : length(sop)){
                    pos <- which(names(verbsList) == names(sop)[j])
                    pos <- which(y %in% verbsList[[pos[1]]])
                    y[pos] <- names(sop)[j]
                    x[[tag[i]]] <- paste(y, collapse = ' ')
                }
            }

            sop <- unlist(lapply(superlativesList, function(x) ifelse(length(which(x %in% y) > 0), 1, 0)))
            sop <- sop[which(sop == 1)]
            if (length(sop) > 0){
                for (j in 1 : length(sop)){
                    pos <- which(names(superlativesList) == names(sop)[j])
                    pos <- which(y %in% superlativesList[[pos]])
                    y[pos] <- names(sop)[j]
                    x[[tag[i]]] <- paste(y, collapse = ' ')
                }
            }
        }

        return(x)
        })

    x <- lapply(x, function(x) {

        for (i in 1 : length(tag)){

            words <- tolower(strsplit(x[[tag[i]]], ' ')[[1]])

            pos <- grep('as$|bs$|cs$|ds$|gs$|hs$|ks$|ls$|ms$|os$|ps$|rs$|ts$|ys$', words)
            if (length(pos) > 0) words[pos] <- substr(words[pos], 1, nchar(words[pos])-1)

            pos <- grep('yed$|ssed$|med$|sted$|cted$|pted$|nted$|lted$|rted$|ited$|ssed', words)
            if (length(pos) > 0) words[pos] <- substr(words[pos], 1, nchar(words[pos])-2)

            pos <- grep('ved$|xed$|ced$|zed$|ated$|sed$', words)
            if (length(pos) > 0) words[pos] <- substr(words[pos], 1, nchar(words[pos])-1)

            words[pos] <- gsub('ied$', 'y', words[pos])

            pos <- grep('tted$', words)
            if (length(pos) > 0) words[pos] <- substr(words[pos], 1, nchar(words[pos])-3)

            x[[tag[i]]] <- paste(words, collapse = ' ')
        }

        return(x)
        })



    ############################################################################



    if (ask) {

        words <- NULL
        for (i in 1 : length(tag)){
            words <- c(words, unlist(lapply(x, function(x) x[[tag[i]]])))
        }
        words <- paste(words, collapse = ' ', sep = '')
        Words <- sort(unique(strsplit(words, ' ')[[1]]))
        words <- strsplit(words, ' ')[[1]]

        Words <- sort(Words[grep('ded$|hed$|red$|ned$|ped$|led$|ged$|ked$|es$|ns$|ing$', Words)])

        if (import){
            toAdd <- readRDS('./analysis/log-ending.rds')
            for (q in 1 : ncol(toAdd)) toAdd[ , q] <- as.character(toAdd[ , q])
            ssop <- which(Words %in% toAdd$old)
            if (length(ssop) > 0) Words <- sort(Words[-ssop])
        }

        NewWords <- character(length(Words))

        k <- 1
        cat('\n---------------------------------------------\n')
        cat('\n>>> Remove word ending - Interactive mode <<<\n\n')
        cat('   () Type enter to keep the spelling\n   () Type the new spelling\n   () Type \'<\' to go to the previous word\n   () Type \'c\' to save and exit\n\n')
        cat('---------------------------------------------\n\n')
        while (k <= length(Words)){
            input <- readline(paste('>>> ', Words[k], ' (n=', length(which(words == Words[k])), ')\t', sep = ''))
            if (input == '<' && k > 1){
                k <- k - 1
            }
            if (input == 'c'){
                k <- 1000000
            }
            if (input != '<' && input != 'c'){
                NewWords[k] <- input
                k <- k + 1
            }
        }
        cat('\n')

        if (import){
            toAdd <- readRDS('./analysis/log-ending.rds')
            for (q in 1 : ncol(toAdd)) toAdd[ , q] <- as.character(toAdd[ , q])
            Words <- c(Words, toAdd$old)
            NewWords <- c(NewWords, toAdd$new)
            abc <- order(Words, decreasing = FALSE)
            Words <- Words[abc]
            NewWords <- NewWords[abc]
        }

        x <- lapply(x, function(x) {

            for (i in 1 : length(tag)){
                words <- tolower(strsplit(x[[tag[i]]], ' ')[[1]])

                sop <- which(NewWords == '-')
                if (length(sop) > 0){
                    pos <- which(words %in% Words[sop])
                    if (length(pos) > 0) words <- words[-pos]
                }

                sop <- which(NewWords != '-' & NewWords != '')
                if (length(sop) > 0){
                    pos <- which(words %in% Words[sop])
                    if (length(pos) > 0){
                        for (k in 1 : length(pos)){
                            mop <- which(Words == words[pos[k]])
                            words[pos[k]] <- NewWords[mop]
                        }
                    }
                }

                x[[tag[i]]] <- paste(words, collapse = ' ')
            }

            return(x)
            })

        pos <- which(NewWords != '')
        if (length(pos) > 0){
            NewWords <- NewWords[1:max(pos)]
            Words <- Words[1:max(pos)]
        }
        saveRDS(data.frame(tag = as.character(rep('TI', length(Words))), old = as.character(Words), new = as.character(NewWords)), './analysis/log-ending.rds')
    }

    if (import && !ask){

        toAdd <- readRDS('./analysis/log-ending.rds')
        for (q in 1 : ncol(toAdd)) toAdd[ , q] <- as.character(toAdd[ , q])
        Words <- toAdd$old
        NewWords <- toAdd$new
        abc <- order(Words, decreasing = FALSE)
        Words <- Words[abc]
        NewWords <- NewWords[abc]

        x <- lapply(x, function(x) {
            for (i in 1 : length(tag)){
                words <- tolower(strsplit(x[[tag[i]]], ' ')[[1]])

                sop <- which(NewWords == '-')
                if (length(sop) > 0){
                    pos <- which(words %in% Words[sop])
                    if (length(pos) > 0) words <- words[-pos]
                }

                sop <- which(NewWords != '-' & NewWords != '')
                if (length(sop) > 0){
                    pos <- which(words %in% Words[sop])
                    if (length(pos) > 0){
                        for (k in 1 : length(pos)){
                            mop <- which(Words == words[pos[k]])
                            words[pos[k]] <- NewWords[mop]
                        }
                    }
                }

                x[[tag[i]]] <- paste(words, collapse = ' ')
            }

            return(x)
            })
    }
    cat(paste0('>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(x, './analysis/articles.rds')
    return(x)
}
