# Import OSD metdata

# The data set itself is documented here:
# https://github.com/MicroB3-IS/osd-analysis/wiki/OSD-2014-environmental-data-csv-documentation
# If you spot any errors in this data, plese post an issue to: 
# https://github.com/MicroB3-IS/osd-analysis/issues

# First step, pull the data from the database export online.
# Note: if not using Windows, you may need to use RCurl.

setInternet2(TRUE) # Allows https access

# pull CSV file, declare that its first row is a row of headers (col names)
# that it is pipe, "|", separated, and that 
# data are quoted with double quotes

# This could be (should be?) switched to PANGAEA's tsv link...
rawContextualData <- read.csv(
	"https://owncloud.mpi-bremen.de/index.php/s/eaB3ChiDG6i9C6M/download?path=%2F2014%2Fsamples&files=OSD2014-env_data-2015-09-01.csv",
	header = T,
	sep = "|",
	quote = '"',
	colClasses = "character"
	)

# Set row names to a (sensible) unique identifier, here I chose the ENA 
# accession code, already in the data.
row.names(rawContextualData) <- rawContextualData[, "label"]

# check the dimensions of the table...
#  dim(rawContextualData)
#    [1] 203  54

# Now, partition the table into objects that contain logically aggregated

# Create a table mapping various IDs to one another...
sampleMap <- rawContextualData[
	,
	c(
		"osd_id",
		"label",
		"bioarchive_code",
		"ena_acc",
		"biosample_acc",
		"site_name"
		)
	]
	

# create a spatial data object
spatialData <- rawContextualData[, 
	c(
		"start_lat",
		"start_lon",
		"stop_lat",
		"stop_lon",
		"water_depth"
	)
]

# cast as numeric
spatialData <- sapply(spatialData, as.numeric)
# regenerate row names
row.names(spatialData) <- row.names(rawContextualData)


# create a temporal data object


# Standardise UTC times to POSIX
# R can do calculations with these, unlike simple strings
#
# for example:
# temporalData.computable$startTimes[1:4] - temporalData.computable$startTimes[5:8]
# Time differences in days
# [1] -1.239583 -3.294410 -2.386806 -2.303472
#
# row.names are lost, however, but the order is preserved

temporalData.computable <- list()
temporalData.computable$startTimes <- strptime(rawContextualData$start_date_time_utc, format="%Y-%m-%dT%H:%M:%S+00", tz = "UTC")
temporalData.computable$endTimes <- strptime(rawContextualData$end_date_time_utc, format="%Y-%m-%dT%H:%M:%S+00", tz = "UTC")


# store the textual representations of time and date.
# not useful for computation (use the list object above for that),
# but good for reference.
temporalData <- rawContextualData[, 
	c(
		"local_date",  # local at site!! Not Zulu.
		"local_start", # local at site!! Not Zulu.
		"local_end",   # local at site!! Not Zulu.
		"start_date_time_utc",
		"end_date_time_utc"
	)
]



# Create a table containing all categorical variables...
factorData <- rawContextualData[, 
	c(
		"iho_label",
		"mrgid", # Marine regions general identifer (corresponds to IHO label
		"protocol",   # 
		"biome",
		"biome_id",
		"feature",
		"feature_id",
		"material",
		"material_id"
	)
]

# Transform [biome,feature,material]_id values to valid IDs

idFields <- c("biome_id", "feature_id", "material_id")

for (i in idFields) {
  factorData[,paste(i)] <- gsub("^","http://purl.obolibrary.org/obo/ENVO_", factorData[, paste(i)])
}

rm(idFields)

# Tell R that these are "factor" data, so that they are treated like
# categorical variables...

tempNames <- names(factorData)
factorData[,tempNames] <- lapply(factorData[,tempNames], factor)


# Create a table with unstructured data (like free text descriptions)...
unstructuredFields <- rawContextualData[, 
	c(
		"objective",
		"platform", 
		"device",    
		"description"
	)
]

# create a numeric data object - some variables have only a few
# (or sometimes only one) non-empty entry!
numericData <- rawContextualData[, 
	c(
		"water_temperature",
		"salinity", 
		"ph",    
		"phosphate",
		"carbon_organic_particulate",
		"carbon_organic_dissolved_doc",
		"nitrate",
		"nitrite",
		"nano_microplankton",
		"downward_par",
		"conductivity",
		"primary_production_isotope_uptake",
		"primary_production_oxygen",
		"dissolved_oxygen_concentration",
		"nitrogen_organic_particulate_pon",
		"meso_macroplankton",
		"bacterial_production_isotope_uptake",
		"nitrogen_organic_dissolved_don",
		"ammonium",
		"silicate",
		"bacterial_production_respiration",
		"turbidity",
		"fluorescence",
		"pigment_concentration",
		"picoplankton_flow_cytometry"
	)
]

# Convert into a matrix (this is appropriate [faster and less likely to
# lead to errors] than a data frame object.
numericData <- data.matrix(numericData)

# For semantic consistency, replace NaNs with NAs
numericData[is.nan(numericData)] <- NA

combinedEnvSpatTempData <- data.frame(
  spatialData,
  temporalData,
  factorData, 
  numericData
  )

#Clean up ...
rm(list = c("tempNames", "i"))
gc()
