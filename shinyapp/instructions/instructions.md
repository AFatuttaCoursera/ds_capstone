**Introduction**
----------------

This application has been created as the result of the capstone project
for Data Science course on Coursera.

The main goal of this project is to create a predictive text shiny
application, similar to the ones you find in your mobile phones, that
given a sentence, will try to predict what might be the next word.

**Data analysis**
-----------------

The initial data set was given on Coursera website, extracted by a web
crawler fron internet. It comprehend 3 different sources blogs, twitter
and news feeds.

My approach consists in taking all the documents and splitting them into
smaller chunks, easier to manipulate and analyze. At the end of the
elaboration, I've aggregated the results and created the application.

I've generated the following entities:

-   a table containing all the words found in the data set
-   three tables containing all the BI-grams,TRI-grams, QUAD-grams
    distinct combination found in the datasets (N-gram: chunk of text
    composed of N words, ex. BI-gram is a combination of 2 words)
-   a cross table that relate the above tables with the single words.
    this words contains also the number of occurrencies related to other
    words, allowing to find the most common words associated with
    a bi/tri/quad-gram.

All this process has been needed due to technical limitation and
computational cost of a real time data set analysis. The whole dataset
size was about 600MB uncompressed and contains hundred thousand rows and
million words, therefore it wouldn't be efficent nor quick to do a real
time analysis on the whole set, instead I decided to prepare and
manipulate the data in a way that allow the needed footprint to be small
and the searches to be quick.

Moreover the application should emulate something that we have on mobile
phones, that has limited local resources both in memory or CPU power.

**How to use the application**
------------------------------

First, you have to leave this page and click on the second tab that you
can find above this introduction, name is "Text Prediction App". This
application works only for english words, so you might try other
languages, but it might not work at all.

Here you have a very simple screen, similar to a mobile interface, you
got your chat above and the text input field below. In the middle of the
two you can see the prediction field.

Here, once something has been input into the text form, you will get 3
options to choose from, they correspond to the most frequent words
associated with the ones you wrote, the more big is the word, more is
likely to be associated.

Example input: "I have a test"

Prediction: "tomorrow","today","new"

Completed sentence: "I have a test tomorrow"

**Current known limits**
------------------------

To create my own datasets for the project, I used some common techniques
for text mining and natural language processing, those includes the
removal of stopwords, words stemming and others.

The result of this is that the datasets I've prepared do not contain
common words as "the","is","a", etc. and all words that refers to the
same root have been reduced to it, for example "catlike", "catty"
becomes "cat".

If you want more informations, please refer to following links:

-   [Natural Language
    Processing](https://en.wikipedia.org/wiki/Natural_language_processing)
-   [Stemming](https://en.wikipedia.org/wiki/Stemming)
-   [Stopwords](https://en.wikipedia.org/wiki/Stop_words)

**Please be aware that profanities have not been filtered out.**

**Future evolutions**
---------------------

The next iteration of this software could include the following:

-   Custom ngram insertions: user can save custom words and relations
    that are going to be added to current dictionaries
-   Whole words: with the use of an additional dictionary, we could
    propose the most common word associated with his root, allowing the
    user to see the unstemmed word.
