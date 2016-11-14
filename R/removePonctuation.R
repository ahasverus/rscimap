removePonctuation <- function(data, tag = 'TI', exception = NULL){

    if (!is.list(data))
        stop('Data has to be the output of filterArticles(), i.e. a list.')

    cat(paste0('\n>>> Removing punctuations in < ', paste0(tag, collapse = ', '), ' >...\n'))


    if (!is.null(tag)){

        if (is.null(exception)){
            expr <- '[[:punct:]]'
        } else {
            expr <- paste('([', paste('', exception, collapse = '', sep = ''), '])|[[:punct:]]', collapse = '', sep = '')
        }

        for (i in 1 : length(tag)){

            data <- lapply(data, function(x){
                x[tag[i]] <- gsub(expr, '\\1', x[tag[i]])
                return(x)
            })

            ### Apostrophe lookup
            data <- lapply(data, function(x){
                x[tag[i]] <- gsub('\'s |\'', '', x[tag[i]])
                return(x)
            })
        }
    }
    cat(paste0('>>> Done!\n'))
    cat(paste0('>>> Results exported in ', getwd(), '/analysis/articles.rds\n\n'))
    dir.create('./analysis', showWarnings = FALSE)
    saveRDS(data, './analysis/articles.rds')
    return(data)
}
