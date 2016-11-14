toLowercase <- function(data, tag = 'TI'){

    if (!is.list(data))
        stop('Data has to be the output of filterArticles(), i.e. a list.')

    cat(paste0('\n\n>>> Converting < ', paste0(tag, collapse = ', '), ' > to lower case...\n'))

    if (!is.null(tag)){
        data <- lapply(data, function(x){
            for (i in 1 : length(tag)){
                x[[tag[i]]] <- tolower(x[[tag[i]]])
            }
            return(x)
        })
    }
    cat(paste0('>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(data, './analysis/articles.rds')
    return(data)
}
