
getwd()
setwd("C:\\Users\\saikrishnak\\Dropbox\\RnD Hadoop\\Tweets")
# load the wordlists
pos.words = scan("positive-words.txt",what='character', comment.char=';')
neg.words = scan("negative-words.txt",what='character', comment.char=';')

# bring in the sentiment analysis algorithm
# we got a vector of sentences. plyr will handle a list or a vector as an "l" 
# we want a simple array of scores back, so we use "l" + "a" + "ply" = laply:
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{ 
  require(plyr)
  require(stringr)
  scores = laply(sentences, function(sentence, pos.words, neg.words) 
  {
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence)
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    return(score)
  }, 
  pos.words, neg.words, .progress=.progress )
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}

# and to see if it works, there should be a score...either in German or in English
sample = c("ich liebe dich. du bist wunderbar","I hate you. Die!");
sample

test.sample = score.sentiment(sample , pos.words, neg.words);
test.sample

##Load the  Tweet File 

tweets.df= read.table("processed_tweets.txt",sep="\t")
heading.tweets = c('message','name')
names(tweets.df)= heading.tweets
head(tweets.df)
test.sample = score.sentiment(tweets.df$message, pos.words, neg.words);

final.df = data.frame(test.sample,tweets.df$name)
summary(final.df)

write.table(final.df, file ="R_Output.csv",row.names=FALSE,sep=",") 