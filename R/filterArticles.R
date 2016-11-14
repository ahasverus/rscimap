filterArticles <- function(files, type = c('Article', 'Editorial Material', 'Review')){

    options(warn = -1)

    dt <- paste(paste('DT', type), collapse = '|')

    cat(paste0('\n\n>>> Filtering citations < ', paste0(type, collapse = ', '), ' >...\n'))

    refs <- list()
    k <- 1

    for (i in 1 : length(files)){

        tab  <- readLines(files[i])
        pos0 <- which(substr(tab, 1, 3) == 'PT ')
        pos1 <- which(substr(tab, 1, 2) == 'ER')

        for (j in 1 : length(pos0)){

            zero <- ifelse(nchar(k) == 1, '000', ifelse(nchar(k) == 2, '00', ifelse(nchar(k) == 3, '0', '')))
            dat  <- paste(c(tab[pos0[j]:pos1[j]], ''), collapse = '\n', sep = '')

            if (length(grep(dt, dat)) > 0 && length(grep('CR ', dat)) > 0){

                mat <- tab[pos0[j]:pos1[j]]

                infos  <- list()
                labels <- c('AU', 'TI', 'AB', 'DE', 'ID', 'PY', 'J9', 'VL', 'BP', 'EP', 'CR')

                for (z in 1 : length(labels)){

                    infos[[z]] <- extractTags(mat, tag = labels[z],
                                              sep = ifelse(labels[z] == 'AU', ' ; ', ' '),
                                              collapse = ifelse(labels[z] == 'CR', FALSE, TRUE))
                    names(infos)[z] <- labels[z]
                }

                infos <- c(NOID = paste('REF', zero, k, sep = ''), infos)

                refs[[k]] <- infos
                k <- k + 1
            }
        }
    }
    cat(paste0('>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(refs, './analysis/articles.rds')
    return(refs)
}
