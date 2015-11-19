# Note that this script will standardise the data with the
# total sum of all OTUs detected at a given site.
# this is not the same as the original number of reads, low
# quality reads that were discarded by SILVAngs are not
# featured here.

if (exists("iprCounts") == FALSE){
  source("https://raw.githubusercontent.com/MicroB3-IS/osd-analysis/master/emgData/import_ipr.R")
} else {print("using existing iprCounts matrix")}


if (is.element("vegan", installed.packages()[,1])) {
  print("using existing vegan installation...")
} else {install.packages("vegan")}

require(vegan)

tssIprCounts <- decostand(
  iprCounts, 
  MARGIN = 1, 
  method = "total"
  )

gc()