library(data.table)
library(phyloseq)
library(metagenomeSeq)

#TODO: make this a phyloseq object creation script 
# with all pre-processing and cleaning


#TODO: add import of abundance table, taxonomy, and contextual data from OWNCloud


osd.tara.metadata<-sample_data(rbind(osd.metadata.filt,tara.metadata.filt))


# complete the phyloseq objects...
osd.physeq<-phyloseq(osd.resfam.counts,resfam.def, sample_data((osd.metadata.filt)))
tara.physeq<-phyloseq(tara.resfam.counts,resfam.def, sample_data((tara.metadata.filt)))
osd.tara.physeq<-phyloseq(resfam.counts,resfam.def, osd.tara.metadata)

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