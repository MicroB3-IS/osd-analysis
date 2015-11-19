#TODO FIXME: row names need to be updated.
#setdiff(row.names(raw16Scounts), unique(intersect(row.names(rawContextualData), row.names(raw16Scounts))))
#[1] "OSD114_2014-06-21_50m_NPL022" 
#[2] "OSD118_2014-06-24_0.2m_NPL022"
#[3] "OSD72_2014-07-21_0.8m_NPL022" 

# assuming that the contextual data from the 17th 
# of November has the right names, we have...
#cbind(
#  contextualData = grep("OSD114|OSD118|OSD72.*NPL022", sort(row.names(rawContextualData)), value = T),
#  raw16SCounts = grep("OSD114|OSD118|OSD72.*NPL022", sort(row.names(raw16Scounts)), value = T)
#  )
# May be needed on some Windows machines
#setInternet2(TRUE) # Allows https access

if (is.element("data.table", installed.packages()[,1])) {
  print("using existing data.table installation...")
  } else {install.packages("data.table")}

require(data.table)

# The count file is c. 90 MB, so be prepared for a wait...
# import with data.table's fread() due to table size...
# you may need to install the curl package to allow fread()
# to access the file via HTTPS...

raw16Scounts <- fread(
  input = "https://owncloud.mpi-bremen.de/index.php/s/eaB3ChiDG6i9C6M/download?path=%2F2014%2Fsilva-ngs%2F16s%2Flgc%2Fotu_table&files=osd2014_16s_lgc_otu_by_sample.csv",
  header = T,
  sep = ",",
  showProgress = FALSE
)

# OTUs by sampling sites...
#dim(raw16Scounts)
#[1] 259712    156



raw16Scounts.df <- as.data.frame(
    raw16Scounts[,2:dim(raw16Scounts)[2], with = F]
)

row.names(raw16Scounts.df) <- raw16Scounts[,1, with = F][[1]]

raw16Scounts <- t(as.matrix(raw16Scounts.df))

rm(raw16Scounts.df)
gc()


