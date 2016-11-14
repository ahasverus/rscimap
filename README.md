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

The first step is to get citations from a search on Web of Science about a specific topic.
Once you get the result of your search, select __Save to Other File Formats__ to export bibliographic citations as shown below.

![Screenshot of the Web of Science export interface](/img/wos1.png)

Then select __Full records and Cited References__ and the format __Other Reference Software__ to export citations. Be careful: this export method works only for 500 records at the same time. If you have more than 500, you'll have to repeat this export step by adjusting the __Number of records__.

![Screenshot of the Web of Science export interface](/img/wos2.png)

Finally put this/these file(s) in a folder, let's say `biblio`, on your desktop. Your(s) file(s) should look like this:

![Screenshot of the Web of Science export interface](/img/ris.png)



### Format documents and filter document types

The first step is to format raw citations in a more _user-friendly_ format, i.e. an __R list__ where each element of this list is a citation. Each citation is a sub-list where each element is a specific information (e.g. authors, title, keywords, volume, abstract, cited references, etc.).

The `filterArticles()` function allows you to also select specific documents types. For now, only _article_, _editorial_ and _review_ are implemented. If you don't want to select specific document types, just set the argument `type` to `NULL`.

```r
### Set the input/output directory
setwd('~/Desktop/biblio')

### Filename with raw citations
fls  <- '~/Desktop/biblio/search-wos.txt'

### Filter documents by type
refs <- filterArticles(files = fls,
                       type = c('Article', 'Editorial Material', 'Review'))
```


### Remove punctuation characters

...

```r
### Remove ponctuation (with some exceptions if required)
refs <- removePonctuation(data = refs,
                          tag = c('TI', 'ID', 'DE', 'AB'),
                          exception = c('-', '\''))
```



### Convert to lower case

...

```r
### Convert to lowercase
refs <- toLowercase(data = refs,
                    tag = c('TI', 'ID', 'DE', 'AB'))
```



### Remove stopwords

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


### Remove word endings

...

```r
### Remove common words endings (automatic and manual)
refs <- removeWordEndings(x = refs,
                          tag = c('TI', 'ID', 'DE', 'AB'),
                          ask = TRUE,
                          import = FALSE)
```



### Split associated words

...

```r
### Split associated words
refs <- splitWords(x = refs,
                   tag = c('TI', 'ID', 'DE', 'AB'),
                   import = FALSE)
```


### Check words spelling (group words)

...

```r
### Correct words spelling (manual)
refs <- checkSpelling(data = refs,
                      tag = c('TI', 'ID', 'DE', 'AB'),
                      distance = 5,
                      method = 'lv')
```



### Correct words spelling (specific cases)

...

```r
### Correct specific spelling
refs <- correctSpelling(x = refs,
                        tag = c('TI', 'ID', 'DE', 'AB'),
                        word = 'cliamte',
                        replace = 'climate')
```



### Combine two words

...

```r
### Combine two words (i.e. climate change to climateChange)
refs <- combineWords(x = refs,
                     tag = c('TI', 'ID', 'DE', 'AB'),
                     threshold = 5)
```

## Notes

Only Web-of-Science format is implemented. Moreover informations are only extracted for articles, editorial material and review types.
