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

m<-matrix(ncol=6)
m[1,] <- c("DADO", "TAU-MK", "SENS SLOPE", "P VALUE", "PETTIT TEST", "P VALUE")

for (i in 1:ncol(df)) {
  m<- rbind(m,
            c(names(df[i]), MannKendall(df[,i][complete.cases(df[,i])])$tau[1], as.vector(sens.slope(df[,i][complete.cases(df[,i])])$estimates), sens.slope(df[,i][complete.cases(df[,i])])$p.value, as.vector(pettitt.test(df[,i][complete.cases(df[,i])])$estimate),
              pettitt.test(df[,i][complete.cases(df[,i])])$p.value)
  )
}


write.csv(m, paste0("resultados_",arquivos[2]), row.names = F)
