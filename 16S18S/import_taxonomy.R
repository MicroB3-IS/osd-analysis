
if (is.element("stringr", installed.packages()[,1])) {
  print("using existing stringr installation...")
} else {install.packages("stringr")}

require(stringr)


# May be needed on some Windows machines
#setInternet2(TRUE) # Allows https access

temp <- tempfile()
download.file("https://owncloud.mpi-bremen.de/index.php/s/eaB3ChiDG6i9C6M/download?path=%2F2014%2Fsilva-ngs%2F16s%2Flgc%2Fotu_table&files=osd2014_16S_lgc_otu_taxonomy.tsv.gz",temp)

taxonomy <- read.table(
  file = gzfile(temp),
  sep = "\t",
  header = F
)



names(taxonomy) <- c("OTU", "taxPath")

taxonomy <- data.frame(
  taxonomy$OTU,
  stringr::str_split_fixed(taxonomy$taxPath, ";", 6)
  )

taxLevels <- c(
  "otu",
  "domain", 
  "phylum", 
  "class", 
  "order", 
  "family",
  "genus"
)



names(taxonomy) <- taxLevels
  
require(plyr)

taxonomy[taxonomy == ""] <- NA

for (i in taxLevels[2:length(taxLevels)]){
  
  taxonomy[, i] <- factor(
    taxonomy[, i],
    levels = unique(
      c(levels(taxonomy[, i]), paste("Unknown", i))
      )
    )
  
  taxonomy[, i][is.na(taxonomy[, i])]<- paste("Unknown", i)
  taxonomy[, i] <- droplevels(taxonomy[, i])
}


# The unlink() function won't remove the temporary file,
# you should clear those yourself to prevent disk clogging.
unlink(temp)
gc()


