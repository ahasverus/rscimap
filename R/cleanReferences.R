cleanReferences <- function(data){

    cat(paste0('\n\n>>> Cleaning references...\n'))

    ### Clean references
    for (k in 1 : length(data)){

        refs <- strsplit(data[[k]]$CR, ',')
        yr <- table(unlist(lapply(refs, function(x) grep('^ [0-9]{4}', x))))
        yr <- as.numeric(names(yr[which.max(yr)]))
        year <- gsub('[[:space:]]', '', unlist(lapply(strsplit(data[[k]]$CR, ','), function(x) x[yr])))

        if (yr == 2){
            authors <- unlist(lapply(strsplit(data[[k]]$CR, ','), function(x) x[1]))
        }
        if (yr == 1){
            authors <- unlist(lapply(strsplit(data[[k]]$CR, ','), function(x) x[2]))
        }
        journal <- unlist(lapply(strsplit(data[[k]]$CR, ','), function(x) x[3]))
        volume  <- unlist(lapply(strsplit(data[[k]]$CR, ','), function(x) x[4]))

        authors <- gsub('\\.', ' ', authors)
        pos <- c(grep('\\*|^\\[', authors), which(substr(authors, 1, 1) %in% c(0:9, '(')))
        if (length(pos) > 0){
            data[[k]]$CR <- data[[k]]$CR[-pos]
            authors  <- authors[-pos]
            year     <- year[-pos]
            journal  <- journal[-pos]
            volume   <- volume[-pos]
        }

        tmp <- strsplit(authors, '[[:space:]]')
        n   <- max(unlist(lapply(tmp, function(x) length(x))))
        xx  <- unlist(lapply(tmp, function(x) paste(x[1], ' ', sep = '')))
        for (z in 2 : n){
            xx <- paste(xx, unlist(lapply(tmp, function(x) if (!is.na(x[z])){ ifelse(nchar(x[z]) > 2, substr(x[z], 1, 1), x[z]) } else {''})), sep = '')
        }

        journal <- gsub('^[[:space:]]', '', journal)

        for (z in 1 : length(data[[k]]$CR)){
            if (!is.na(volume[z]) && nchar(volume[z]) < 6){
                data[[k]]$CR[z] <- gsub(' ,', ',', paste(xx[z], year[z], journal[z], volume[z], sep = ', ', collapse = ''))
            } else {
                data[[k]]$CR[z] <- gsub(' ,', ',', paste(xx[z], year[z], journal[z], sep = ', ', collapse = ''))
            }
            data[[k]]$CR[z] <- gsub('[[:space:]]+', ' ', data[[k]]$CR[z])
        }

        pos <- grep('[0-9]{4}', year)
        data[[k]]$CR <- data[[k]]$CR[pos]
    }
    cat(paste0('>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(data, './analysis/articles.rds')
    return(data)
}
