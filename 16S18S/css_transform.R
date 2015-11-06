# May be needed on some Windows machines
#setInternet2(TRUE) # Allows https access

# check 
if (exists("raw16Scounts") == FALSE){
  source("https://raw.githubusercontent.com/MicroB3-IS/osd-analysis/master/16S18S/import_16S.R")
} else {print("using existing raw16Scounts matrix")}


if (is.element("metagenomeSeq", installed.packages()[,1])) {
  print("using existing metagenomeSeq installation...")
} else {install.packages("metagenomeSeq")}

require(metagenomeSeq)

# Create the metagenomeSeq object
MGS <- newMRexperiment(
  counts = t(raw16Scounts)
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

css16Scounts <- t(MRcounts(
  MGS, 
  norm = TRUE,
  log = TRUE,
  sl = median(unlist(normFactors(MGS)))
))

rm(MGS)
gc()


