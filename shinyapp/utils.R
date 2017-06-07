loadData <- function ()
{
    require(tm)
    require(SnowballC)
    require(RWeka)
    require(stringi)
    require(data.table)
    
    finalWords<<-readRDS("./data/finalWords.gzip")
    crossGrams<<-readRDS("./data/crossGrams.gzip")
    biTable<<-readRDS("./data/biTable.gzip")
    triTable<<-readRDS("./data/triTable.gzip")
    quadTable<<-readRDS("./data/quadTable.gzip")
}

removeURL <- function(x) gsub("http[^[:space:]]*", "", x)

strip <-function(sub)
{
    corp <- VCorpus(VectorSource(sub))
    corp <- tm_map(corp, content_transformer(function(x) iconv(x, to="UTF-8", sub="byte")))
    corp <- tm_map(corp, content_transformer(tolower)) 
    corp <- tm_map(corp, content_transformer(removePunctuation))
    corp <- tm_map(corp, content_transformer(removeNumbers))
    corp <- tm_map(corp, content_transformer(removeURL))
    corp <- tm_map(corp, stripWhitespace)
    corp <- tm_map(corp, removeWords, stopwords("english"))
    corp <- tm_map(corp, stemDocument)
    corp <- tm_map(corp, stripWhitespace)
    corp$content[[1]]$content
}

getPredictions <- function ( inString, numWords=3)
{

    split<-tail( strsplit(inString,split = " ")[[1]],3)
    n<-length(split)+1
    
    res<-c()
    
    while ( length(res) == 0 & n > 1 )
    {   
        res <- switch(n,
                      null,
                      getPred2( split[1], numWords),
                      getPred3( split[1], split[2], numWords),
                      getPred4( split[1], split[2], split[3], numWords)
                      )
        
         n <- n - 1
         split<- c( tail(split,2),"")
    }
    
    if(length(res) == 0 )
    {
        split<-tail( strsplit(inString,split = " ")[[1]],3)
        n<-length(split)+1
        
        while ( length(res) == 0 & n > 1 )
        {   
            res <- switch(n,
                          null,
                          getPred2( split[1], numWords),
                          getPred3( split[1], split[2], numWords),
                          getPred4( split[1], split[2], split[3], numWords)
            )
            
            n <- n - 1
        }
    }
    
    if(length(res) == 0 )
    {
        res<-""
    }
    
    res
}


getPred2 <- function( inW1, numWords=3)
{
    ##print("get2")
    ##print(paste("w1",inW1))
    
    temp<- head( crossGrams[ gramType==2 & gramID==biTable[W1==inW1]$id ][order(count, decreasing = TRUE)], numWords)
    res <- c()
    for (i in (1:dim(temp)[1])) {
        res <- c( res, finalWords[id == temp[i]$wordID]$W )
        }
    
    res
    ##finalWords[id %in% head( crossGrams[ gramType==2 & gramID==biTable[W1==inW1]$id ][order(count, decreasing = TRUE)], numWords)$wordID ]$W
}

getPred3 <- function( inW1, inW2, numWords=3)
{
    ##print("get3")
    ##print(paste("w1",inW1,"w2",inW2))
    
    temp<- head( crossGrams[ gramType==3 & gramID==triTable[W1==inW1 & W2==inW2]$id ][order(count, decreasing = TRUE)], numWords)
    res <- c()
    for (i in (1:dim(temp)[1])) {
        res <- c( res, finalWords[id == temp[i]$wordID]$W )
    }
    
    res
    ##finalWords[id %in% head( crossGrams[ gramType==3 & gramID==triTable[W1==inW1 & W2==inW2]$id ][order(count, decreasing = TRUE)], numWords)$wordID ]$W
}

getPred4 <- function( inW1, inW2, inW3, numWords=3)
{
    ##print("get4")
    ##print(paste("w1",inW1,"w2",inW2, "w3", inW3))
    
    temp<-head( crossGrams[ gramType==4 & gramID==quadTable[W1==inW1 & W2==inW2 & W3==inW3]$id ][order(count, decreasing = TRUE)], numWords)
    res <- c()
    for (i in (1:dim(temp)[1])) {
        res <- c( res, finalWords[id == temp[i]$wordID]$W )
    }
    
    res
    ##finalWords[id %in% head( crossGrams[ gramType==4 & gramID==quadTable[W1==inW1 & W2==inW2 & W3==inW3]$id ][order(count, decreasing = TRUE)], numWords)$wordID ]$W
}

addTags <-function( res )
{
    n<-5
    
    for (i in 1:length(res))
    {
        if (i==1)
                 {
                res[i]<-paste("<font size=\"",n-i,"\"><strong>",res[i],"</strong></font>")
                }
            else {
                res[i]<-paste("<font size=\"",n-i,"\">",res[i],"</font>")
                }
    }
    res
}
