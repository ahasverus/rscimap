extractTags <- function(data, tag, sep = '', collapse = TRUE){

    tag <- toupper(tag)
    if (nchar(tag) == 2) tag <- paste(tag, ' ', sep = '')

    pos <- which(substr(data, 1, 3) == tag)
    if (length(pos) == 0){
        if (tag == 'VL '){
            tag <- ''
        } else {
            if (tag == 'BP '){
                tag <- 'AR '
                pos <- which(substr(data, 1, 3) == tag)
                if (length(pos) == 0){
                    tag <- ''
                }
            } else {
                tag <- ''
            }
        }
    }

    if (tag != ''){
        val <- gsub(tag, '', toupper(data[pos]))
        pos <- pos + 1
        while (substr(data[pos], 1, 3) == '   '){
            if (collapse){
                val <- paste(val, toupper(data[pos]), sep = sep)
            } else {
                val <- c(val, toupper(data[pos]))
            }
            pos <- pos + 1
        }
        val <- gsub('   ', '', val)
    } else {
        val <- ''
    }
    return(val)
}
