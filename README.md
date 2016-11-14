# rscimap

An R package to clean words and cited references in bibliographic citations to perform robust wordclouds or social network analysis (also known as science mapping)




## Installation

You can install this package from Github.

```r
### First install the < devtools > package (if not already installed)
install.packages('devtools')

### Then install the < rscimap > package
library(devtools)
devtools::install_github('ahasverus/rscimap')

### And load the package < rscimap >
library(rscimap)
```

## Documentation

The first step is to get citations from a search on Web of Science. To export the result of the search from Web of Science, save citations in _Other File Formats_ and select _Full records and Cited References_ in the format _Other Reference Software_.

![Screenshot of the Web of Science export interface](/img/wos.png)

#### Filter document types

...

```r
### Listing files to be openned
(fls  <- list.files(path = '~/Documents/biblio',
                    pattern = '.txt$',
                    full.names = TRUE))

### Set the output directory
setwd('~/Documents/biblio')

### Filter documents by type
refs <- filterArticles(files = fls,
                       type = c('Article', 'Editorial Material', 'Review'))
```


#### Remove punctuation characters

...

```r
### Remove ponctuation (with some exceptions if required)
refs <- removePonctuation(data = refs,
                          tag = c('TI', 'ID', 'DE', 'AB'),
                          exception = c('-', '\''))
```



#### Convert to lower case

...

```r
### Convert to lowercase
refs <- toLowercase(data = refs,
                    tag = c('TI', 'ID', 'DE', 'AB'))
```



#### Remove stopwords

...

```r
### Remove stopwords, adverbs and numbers
refs <- removeWords(x = refs,
                    tag = c('TI', 'ID', 'DE', 'AB'),
                    stopwords = TRUE,
                    numbers = TRUE,
                    adjectives = TRUE,
                    adverbs = TRUE,
                    oneletter = TRUE)
```

To see which words will be removed:

```r
### List of stopwords to be removed
getStopwords(which = 'stopwords')

### List of adjectives to be removed
getStopwords(which = 'adjectives')

### List of adverbs to be removed
getStopwords(which = 'adverbs')
```


#### Remove word endings

...

```r
### Remove common words endings (automatic and manual)
refs <- removeWordEndings(x = refs,
                          tag = c('TI', 'ID', 'DE', 'AB'),
                          ask = TRUE,
                          import = FALSE)
```



#### Split associated words

...

```r
### Split associated words
refs <- splitWords(x = refs,
                   tag = c('TI', 'ID', 'DE', 'AB'),
                   import = FALSE)
```


#### Check words spelling (group words)

...

```r
### Correct words spelling (manual)
refs <- checkSpelling(data = refs,
                      tag = c('TI', 'ID', 'DE', 'AB'),
                      distance = 5,
                      method = 'lv')
```



#### Correct words spelling (specific cases)

...

```r
### Correct specific spelling
refs <- correctSpelling(x = refs,
                        tag = c('TI', 'ID', 'DE', 'AB'),
                        word = 'cliamte',
                        replace = 'climate')
```



#### Combine two words

...

```r
### Combine two words (i.e. climate change to climateChange)
refs <- combineWords(x = refs,
                     tag = c('TI', 'ID', 'DE', 'AB'),
                     threshold = 5)
```

## Notes

Only Web-of-Science format is implemented. Moreover informations are only extracted for articles, editorial material and review types.
