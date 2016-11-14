removeWords <- function(x, tag = 'TI', stopwords = TRUE, numbers = TRUE, adjectives = TRUE, adverbs = TRUE, oneletter = TRUE){

    stopwordsList <- readRDS(system.file("external/stopwords.rds", package = "rscimap"))
    numbersList <- readRDS(system.file("external/numbers.rds", package = "rscimap"))
    adjectivesList <- readRDS(system.file("external/adjectives.rds", package = "rscimap"))
    adverbsList <- readRDS(system.file("external/adverbs.rds", package = "rscimap"))

    texte <- NULL
    if (stopwords) texte <- c(texte, 'stopwords')
    if (numbers) texte <- c(texte, 'numbers')
    if (adjectives) texte <- c(texte, 'common adjectives')
    if (adverbs) texte <- c(texte, 'common adverbs')
    if (oneletter) texte <- c(texte, 'one-letter words')

    cat(paste0('\n>>> Deleting in < ', paste0(tag, collapse = ', '), ' > : ', paste0(texte, collapse = ', '), '...\n'))

    for (i in 1 : length(x)){

        if (!is.null(x[[i]])){

            if (stopwords){
                for (j in 1 : length(tag)){
                    if (length(x[[i]][[tag[j]]]) == 1){
                        y <- tolower(strsplit(x[[i]][[tag[j]]], ' ')[[1]])
                    } else {
                        y <- x[[i]][[tag[j]]]
                    }
                    sop <- which(y %in% tolower(stopwordsList))
                    if (length(sop) > 0) x[[i]][[tag[j]]] <- paste(y[-sop], collapse = ' ')
                }
            }

            if (numbers){
                for (j in 1 : length(tag)){
                    if (length(x[[i]][[tag[j]]]) == 1){
                        y <- tolower(strsplit(x[[i]][[tag[j]]], ' ')[[1]])
                    } else {
                        y <- x[[i]][[tag[j]]]
                    }
                    sop <- which(y %in% tolower(numbersList))
                    if (length(sop) > 0) x[[i]][[tag[j]]] <- paste(y[-sop], collapse = ' ')

                    if (length(x[[i]][[tag[j]]]) == 1){
                        y <- tolower(strsplit(x[[i]][[tag[j]]], ' ')[[1]])
                    } else {
                        y <- x[[i]][[tag[j]]]
                    }
                    sop <- grep('[0-9]', y)
                    if (length(sop) > 0) x[[i]][[tag[j]]] <- paste(y[-sop], collapse = ' ')
                }
            }

            if (adjectives){
                for (j in 1 : length(tag)){
                    if (length(x[[i]][[tag[j]]]) == 1){
                        y <- tolower(strsplit(x[[i]][[tag[j]]], ' ')[[1]])
                    } else {
                        y <- x[[i]][[tag[j]]]
                    }
                    sop <- which(y %in% tolower(adjectivesList))
                    if (length(sop) > 0) x[[i]][[tag[j]]] <- paste(y[-sop], collapse = ' ')
                }
            }

            if (adverbs){
                for (j in 1 : length(tag)){
                    if (length(x[[i]][[tag[j]]]) == 1){
                        y <- tolower(strsplit(x[[i]][[tag[j]]], ' ')[[1]])
                    } else {
                        y <- x[[i]][[tag[j]]]
                    }
                    sop <- which(y %in% tolower(adverbsList))
                    if (length(sop) > 0) x[[i]][[tag[j]]] <- paste(y[-sop], collapse = ' ')
                }
            }

            if (oneletter){
                for (j in 1 : length(tag)){
                    if (length(x[[i]][[tag[j]]]) == 1){
                        y <- tolower(strsplit(x[[i]][[tag[j]]], ' ')[[1]])
                    } else {
                        y <- x[[i]][[tag[j]]]
                    }
                    sop <- which(nchar(y) == 1)
                    if (length(sop) > 0) x[[i]][[tag[j]]] <- paste(y[-sop], collapse = ' ')
                }
            }

        }
    }
    cat(paste0('>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(x, './analysis/articles.rds')
    return(x)
}
