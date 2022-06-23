library(trend)
library(Kendall)
library(imputeTS)

arquivos <- dir(pattern=".txt$")

df<-read.csv(arquivos[1], h=T, sep="\t")

for (col in 1:ncol(df)) {
  if (NA %in% df[, col]) {
    df[,col] <- na.interpolation(df[,col])
  } 
}

df<-df[-49,]

ano1<-1971:2018
#ano2 <- 1971:2018

df['ano1'] <- ano1
#df['ano2'] <- ano2

for (i in 1:8) {
  plot(df$ano1, df[,i], t="l", ylab = names(df)[i], xlab="")
}
