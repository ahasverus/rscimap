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

Finally put this/these file(s) in a folder, let's say `biblio`, on your desktop. Your(s) file(s) might look like this:

![Screenshot of the Web of Science export interface](/img/ris.png)



### Format documents and filter document types

The first step is to format raw citations in a more _user-friendly_ format, i.e. an __R list__ where each element of this list is a citation. Each citation is a sub-list where each element is a specific information (e.g. authors, title, keywords, volume, abstract, cited references, etc.).

The `filterArticles()` function allows you to also select specific documents types. For now, only _article_, _editorial_ and _review_ are implemented. If you want to use all documents, just set the argument `type` to `NULL`.

```r
### Set the input/output directory
setwd('~/Desktop/biblio')

### Filename with raw citations
fls  <- 'search-wos.txt'

### Filter documents by type
refs <- filterArticles(files = fls,
                       type = c('Article', 'Editorial Material', 'Review'))
```

**NOTES:** This step is mandatory to format data for the following functions. This function and the others return a list but also write data on the disk in the output directory (in the RDS format).




### Remove punctuation characters

You can remove all punctuation symbols in all textual fields or in some fields. Just indicate the field(s) (`tag`) to remove symbols: `TI` for the document title, `ID` for authors keywords, `DE` for Keywords Plus and `AB` for the abstract.

You also can remove punctuation symbols with some exceptions. For instance, you might want to keep the hyphen in associated words. Just indicate this symbol in the argument `exception`.


```r
### Remove ponctuation (with some exceptions if required)
refs <- removePonctuation(data = refs,
                          tag = c('TI', 'ID', 'DE', 'AB'),
                          exception = '-')
```



### Convert to lower case

You can also convert all textual fields in lower case. Just indicate the field(s) (`tag`).

```r
### Convert to lowercase
refs <- toLowercase(data = refs,
                    tag = c('TI', 'ID', 'DE', 'AB'))
```



### Remove stopwords

Some words are non-informational. For instance, prepositions, postpositions, conjunctions, articles, pronouns, etc. These are stopwords. You can remove them in textual fields. You also can delete common adjectives, common adverbs, one-letter words and numbers (written in numbers or in letters). Just select what you want to delete.

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
### List of stopwords that will be removed
getStopwords(which = 'stopwords')

### List of adjectives that will be removed
getStopwords(which = 'adjectives')

### List of adverbs that will be removed
getStopwords(which = 'adverbs')
```


### Remove word endings

To perform a robust wordcloud, words need to be reduct to a single form. This is particularly true for verbs, superlatives, comparatives and plural. The function `removeWordEndings()` automatically remove common words endings based on some conjugation and grammar rules. But as to many exceptions exist, this function also offer an interactive mode to remove manually other word endings (suggested by the algorithm). Just set `ask = TRUE` to activate the interactive mode.

```r
### Remove common words endings (automatic and manual)
refs <- removeWordEndings(x = refs,
                          tag = c('TI', 'ID', 'DE', 'AB'),
                          ask = TRUE,
                          import = FALSE)
```

If you want to use this function in batches, just set `import = TRUE` to restart where you left off the last time (except for the first time).




### Split associated words

You can change the spelling of associated words tagged by the hyphen. This is an interactive mode, jsut follow the informations at the screen. For instance, you change __canis-lupus__ by __canislupus__. Skip this step if you have previously deleted hyphen symbol.

```r
### Split associated words
refs <- splitWords(x = refs,
                   tag = c('TI', 'ID', 'DE', 'AB'),
                   import = FALSE)
```


### Check words spelling (group words)

The function `removeWordEndings()` is based on common word endings. But after its use, words can still be reduced to a single form. The function `checkSpelling()` opens an interactive mode to group words in a single term. For instance, _climate_, _climates_, _climatic_ and _climatically_ can be grouped under the term _climate_. This function is based on string similarity distance of the package `stringdist`: for a given word, the algorithm computes the distance in term of letters (substitution, replacement, inversion, etc.) with all the words. The argument `distance` indicates a threshold to consider similar words: a high value will be less restrictive, but suggested similar words will be numerous. By default, the distance method is the Levenshtein distance (it counts the number of deletions, insertions and substitutions necessary to turn b into a). Type `?stringdist` for further details.

```r
### Correct words spelling (manual)
refs <- checkSpelling(data = refs,
                      tag = c('TI', 'ID', 'DE', 'AB'),
                      distance = 5,
                      method = 'lv')
```



### Correct words spelling (specific cases)

You can change the spelling of a word by specifying the old spelling and the new one as follow:

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


### Export words to wordcloud

...

```r
### Get words list
words <- getWords(data = refs,
                  tag = c('TI', 'ID', 'DE', 'AB'),
                  format = 'advanced',
                  nmax = 150)
```


### Create Documents-Terms Matrix

...

### Clean cited references

...

### Group cited references

...

### Create adjacency Matrix

...

## Notes

See Issues for future developments.
