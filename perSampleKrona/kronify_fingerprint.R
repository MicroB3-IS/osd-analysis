# Read *MODIFIED* fingerprint file. 
# The fingerprint file is tab-separated and
# in it's original form does not have a header entry for the last column ("Taxpath").
# The header was corrected manually.
fingerprint_raw<-read.delim('myosd2016---ssu---fingerprint----Total---sim_93---tax_silva---td_20.csv.corrected', row.names=NULL, check.names = FALSE)
dim(fingerprint_raw)

# Show the lines (taxpaths) which will be excluded
subset(fingerprint_raw, (grepl("Chloroplast;", Taxpath, fixed=TRUE) | grepl("Mitochondria;", Taxpath, fixed=TRUE)), select = Taxpath)

# Exclude Taxpaths containing 'Chloroplast' and 'Mitochondria'
finger<-subset(fingerprint_raw, (!grepl("Chloroplast;", Taxpath, fixed=TRUE) & !grepl("Mitochondria;", Taxpath, fixed=TRUE)))
nrow(finger)

#taxpath <- data.frame(do.call('rbind', strsplit(as.character(finger$Taxpath),';',fixed=TRUE)))


require(splitstackshape)
taxpath <- data.frame(cSplit(finger,"Taxpath",";",fixed = TRUE))
taxpath <- taxpath[,grep("Taxpath", colnames(taxpath))]

taxpath<-sapply(taxpath,as.character)
taxpath[is.na(taxpath)]<- ""

mypaste<-function(v1)
{
  df<-data.frame(finger[v1],taxpath)
  df<-subset(df, df[,1]!=0)
  write.table(df,file=paste(v1, ".krona.tsv", sep=""), quote=FALSE,row.names=FALSE,col.names = FALSE,sep = "\t")
}

filenames<-colnames(finger[,c(-(ncol(finger)))])
sapply(filenames,mypaste)


