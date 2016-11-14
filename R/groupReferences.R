groupReferences <- function(data, distance = 10, start = NULL){

    require(stringdist)
    refs <- sort(unique(unlist(lapply(data, function(x) x[['CR']]))))

    cat('\n---------------------------------------------\n')
    cat('\n>>> Group references - Interactive mode <<<\n\n')
    cat('   () Type enter to go to the next reference\n   () Select the references to be grouped\n      - Select the reference group spelling\n   () Type \'-\' to delete the reference\n   () Type \'c\' to save and exit\n\n')
    cat('---------------------------------------------\n\n')

    if (is.null(start)){
        i <- 1
    } else {
        i <- which(refs == start)
    }
    while (i <= length(refs)){

        aut <- strsplit(refs[i], ', ')[[1]][1]
        x <- stringdistmatrix(refs, refs[i])
        pos <- which(x < (distance + 1))
        pos <- pos[-which(x[pos] == 0)]
        authors <- unlist(lapply(strsplit(refs[pos], ', '), function(x) x[1]))
        sop <- stringdistmatrix(authors, aut)
        pos <- pos[which(sop < 5)]

        n <- sum(unlist(lapply(data, function(x){ y <- ifelse(which(x[['CR']] == refs[i]), 1, 0) ; return(y) })))

        if (length(pos) > 0){

            for (j in 1 : length(pos))
                n[(j+1)] <- sum(unlist(lapply(data, function(x){ y <- ifelse(which(x[['CR']] == refs[pos[j]]), 1, 0) ; return(y) })))

            aaa <- 0
            cat(paste('\n>>> ', refs[i], ' (n=', n[1], ')\n', sep = ''))
            while (!(aaa[1] %in% c('', 'c', as.character(1:length(pos)), '-'))){
                cat('\n', paste(1:length(pos), ': ', refs[pos], ' (n=', n[-1], ')\n', sep = ''))
                aaa <- readline('\nGroup with: ')

                if (nchar(aaa) > 0){
                    if (aaa != 'c' && aaa != '-')
                        aaa <- as.numeric(strsplit(aaa, ' ')[[1]])
                    if (aaa[1] %in% as.character(c(1:length(pos)))){
                        ppp <- refs[c(i, pos[aaa])]
                        cat('\n\nSuggested group name:\n', paste(1:(length(pos[aaa])+1), ': ', ppp, '\n', sep = ''), '\n\n')
                        ccc <- 0
                        while (!(ccc %in% as.character(1:(length(pos[aaa])+1))) && nchar(gsub(' ', '', ccc)) %in% 1:2){
                            ccc <- readline('Which group name: ')
                        }
                        data <- lapply(data, function(x) {
                            pos <- which(x[['CR']] %in% ppp)
                            if (length(pos) > 0)
                            x[['CR']][pos] <- ppp[as.numeric(ccc)]
                            return(x)
                        })
                        refs <- sort(unique(unlist(lapply(data, function(x) x[['CR']]))))
                    } else {
                        if (aaa[1] == '-'){
                            data <- lapply(data, function(x) {
                                pos <- which(x[['CR']] == refs[i])
                                if (length(pos) > 0)
                                x[['CR']] <- x[['CR']][-pos]
                                return(x)
                            })
                            refs <- refs[-i]
                            refs <- sort(unique(unlist(lapply(data, function(x) x[['CR']]))))
                        }
                        if (aaa[1] == 'c'){
                            i <- length(refs)
                        }
                    }
                }
            }
        }
        i <- i + 1
    }
    cat(paste0('>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(data, './analysis/articles.rds')
    return(data)
}
