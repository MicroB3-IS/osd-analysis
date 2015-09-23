# Import OSD metdata
# !!! This is a preliminary script!!!
# More curation needs to be done on some fields, such as ENVO classifications
# and output should be validated. If you spot any errors with your site's
# data, please let Renzo, Pier, or Ivo know!

# First step, pull the data from the database export online.
# If any data is updated on the database, you'll have the latest
# version. If the format (column names, etc) is the same between
# releases, the same script can be used.
# Note: if not using Windows, you may need to use RCurl.

setInternet2(TRUE) # Allows https access

# pull CSV file, declare that its first row is a row of headers (col names)
# that it is pipe, "|", separated, and that 
# data are quoted with double quotes

# This could be (should be?) switched to PANGAEA's tsv link...
rawContextualData <- read.csv(
	"https://zarafa.mpi-bremen.de/owncloud/public.php?service=files&t=f0e297f451b9944b32f4b2366c74cde3&download&path=/samples/OSD2014-env_data-2015-09-01.csv",
	header = T,
	sep = "|",
	quote = '"',
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

# create a temporal data object
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

#Clean up ...
rm(list = c("tempNames"))
gc()
na, n