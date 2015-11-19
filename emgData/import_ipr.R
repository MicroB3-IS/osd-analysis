
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

iprDescriptions <- iprData[, c("IPR", "description"), with = F]

iprData[ , description:=NULL]

# Replace EMG codes with OSD Names...

enaRun2osdId <- fread(
  "https://owncloud.mpi-bremen.de/index.php/s/eaB3ChiDG6i9C6M/download?path=%2F2014%2Femg&files=OSDlabel-to-ENArun-2015-11-19.tsv",
  header = F,
  sep = "\t",
  showProgress = F
  )

setnames(enaRun2osdId, c("osdLabel", "enaRun"))
setkey(enaRun2osdId, "enaRun")

setnames(
  iprData,
  gsub("_MERGED_FASTQ", "", names(iprData))
)

# extract col names
iprNames <- data.table(names(iprData))
setnames(iprNames, "enaRun")
setkey(iprNames, "enaRun")

# validate...
#cbind(
#  merge(iprNames, enaRun2osdId),
#  enaRun2osdId
#)

# validate...
#cbind(
#  merge(iprNames, enaRun2osdId)[names(iprData), "osdLabel", with = F],
#  names(iprData)
#)


iprNames.osdLabels <- merge(iprNames, enaRun2osdId)[names(iprData), "osdLabel", with = F]
iprNames.osdLabels[1] <- "IPR"
setnames(iprData, iprNames.osdLabels$osdLabel)

rm(iprNames)
rm(iprNames.osdLabels)
