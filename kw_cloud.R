library(tm)
library(ggplot2)
library(reshape2)
library(wordcloud)
library(RWeka)

# Needed for a bug when calculating n-grams with weka
options(mc.cores=1)

dir= readLine(file.choose())
