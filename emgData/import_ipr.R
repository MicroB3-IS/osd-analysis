
# May be needed on some Windows machines: 
#setInternet2(TRUE) # Allows https access

if (is.element("data.table", installed.packages()[,1])) {
  print("using existing data.table installation...")
} else {install.packages("data.table")}

require(data.table)

# import with data.table's fread() due to table size...
# you may need to install the curl package to allow fread()
# to access the file via HTTPS...

iprData <- fread(
  input = "https://owncloud.mpi-bremen.de/index.php/s/eaB3ChiDG6i9C6M/download?path=%2F2014%2Femg%2FEMG_abundance&files=IPR_abundances.tsv",
  header = T,
  sep = "\t",
  showProgress = FALSE
)

iprDescriptions <- iprData[, "description", with = F]

iprData[ , description:=NULL]

# Replace EMG codes with OSD Names...
if (exists("rawContextualData") == FALSE){
  source("https://raw.githubusercontent.com/MicroB3-IS/osd-analysis/master/contextualData/import_contextual_data.R")
} else {print("using existing rawContextualData object")}

sampleMap[, c("osd_id", "ena_acc")]
