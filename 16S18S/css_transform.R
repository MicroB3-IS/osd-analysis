#TODO: turn this into a general script to CSS transform an OTU table or similar

library(data.table)
library(phyloseq)
library(metagenomeSeq)


#TODO: add import of abundance table, taxonomy, and contextual data from OWNCloud
#TODO: think about the library sizes - number of reads vs number of annotated reads
#      same issue as TSS

osd.tara.metadata<-sample_data(rbind(osd.metadata.filt,tara.metadata.filt))


# complete the phyloseq objects...
osd.physeq <- phyloseq(
  osd.resfam.counts,
  resfam.def,
  sample_data((osd.metadata.filt))
  )

# Explore OSD resistome data
#We filter the OTUs that has at least one count on more than 
osd.physeq
# remove samples with less than 5 read-coverage-standardised abundances per ORF
# greater than 0
osd.physeq.filtered = prune_samples(sample_sums(osd.physeq)>=5, osd.physeq)
osd.physeq.filtered
# Remove RFs with sums less than 2 in at least 10 % of the samples
osd.physeq.filtered = filter_taxa(osd.physeq.filtered, function(x) sum(x >= 2) > (0.1*length(x)), TRUE)
osd.physeq.filtered

# create a physeq object to work with...
physeq <- osd.physeq.filtered
# export a table of RFs by samples
OTU <- as(otu_table(physeq), "matrix")

# Convert sample_data to AnnotatedDataFrame, needed by metagenomeSeq
# this will contain lat lon depth and study code in the ADF format
ADF <- AnnotatedDataFrame(data.frame(sample_data(physeq)))

# define dummy 'feature' data for OTUs, using their name Helps with
# extraction and relating to taxonomy later on.
# Recall that taxa names are RF descriptions
TDF <- AnnotatedDataFrame(data.frame(RFname = taxa_names(physeq), row.names = taxa_names(physeq)))

# Create the metagenomeSeq object
MGS <- newMRexperiment(
  counts = OTU,  # RF abundances
  phenoData = ADF, # lat lon depth study etc
  featureData = TDF # RF descriptions
)

# Trigger metagenomeSeq to calculate its Cumulative Sum scaling factor.
# note that one sample has only one RF in the data. This can lead to errors
# if using cumNormStatFast: see https://support.bioconductor.org/p/64061/
MGS <- cumNorm(MGS, p = cumNormStat(MGS))
# this will report that it's using the 'default value' as the estimated
# quantile value is too small. The value used is 0.5
# See: https://support.bioconductor.org/p/64311/

# export the OSD counts to a standard matrix
# normalise with css and apply a log2 transformation to reduce dispersion
# between samples.
# we set the scaling factor, sl, to the median of the normalisation factors
# stored in the MGS object, as recommended by Paulsen et al.

countData.css <- MRcounts(
  MGS, 
  norm = T,
  log = T,
  sl = median(unlist(normFactors(MGS)))
)

