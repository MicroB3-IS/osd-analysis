# May be needed on some Windows machines
#setInternet2(TRUE) # Allows https access

# check 
if (exists("iprCounts") == FALSE){
  source("https://raw.githubusercontent.com/MicroB3-IS/osd-analysis/master/emgData/import_ipr.R")
} else {print("using existing iprCounts matrix")}


if (is.element("metagenomeSeq", installed.packages()[,1])) {
  print("using existing metagenomeSeq installation...")
} else {install.packages("metagenomeSeq")}

require(metagenomeSeq)

# Create the metagenomeSeq object
# rows are samples/sites, columns are variables,
# thus the need to transpose for the MGS object
MGS <- newMRexperiment(
  counts = t(iprCounts)
)

# Trigger metagenomeSeq to calculate its Cumulative Sum scaling factor.
# note that one sample has only one RF in the data. This can lead to errors
# if using cumNormStatFast: see https://support.bioconductor.org/p/64061/
MGS <- cumNorm(MGS, p = cumNormStat(MGS))

# this may report that it's using the 'default value' as the estimated
# quantile value is too small. The value used is 0.5
# See: https://support.bioconductor.org/p/64311/

# export the OSD counts to a standard matrix
# normalise with css and apply a log2 transformation to reduce dispersion
# between samples.
# we set the scaling factor, sl, to the median of the normalisation factors
# stored in the MGS object, as recommended by Paulsen et al.

cssIprCounts <- t(MRcounts(
  MGS, 
  norm = TRUE,
  log = TRUE,
  sl = median(unlist(normFactors(MGS)))
))

rm(MGS)
gc()


