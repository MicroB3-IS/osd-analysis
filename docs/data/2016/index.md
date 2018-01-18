# Introduction

Purpose of this guide is to give a consolidated and authoritative overview of the data from MyOSD 2016.
After reading this guide, you should:
* have an overview of which data from MyOSD 2016 is available and how to access it
* understand how the data was generated
* be able to correctly use and interpret the data

# Overview of Datasets

## Primers
The 16S **alma-alma** primer pair is described in [Parada et al., 2016](https://dx.doi.org/10.1111/1462-2920.13023).

| ribosomal subunit | designation | direction | label | sequence | reference |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 16S | alma | forward | 515F-Y | 5'-GTGYCAGCMGCCGCGGTAA-3' | [Parada et al., 2016](https://dx.doi.org/10.1111/1462-2920.13023) |
| 16S | alma | reverse | 926R | 5'-CCGYCAATTYMTTTRAGTTT-3' | [Parada et al., 2016](https://dx.doi.org/10.1111/1462-2920.13023) |

## 16S datasets
* MYOSD 2016 (alma-alma)
* OSD 2016 (alma-alma)
* One sample from OSD 2015 ()

## Technical samples
### Blanks
Several blank samples were sequenced with the 16S alma-alma primer pair as controls. The DNA extractions were done using DNA extraction kits. For each kit one extraction was done on sterile water to ensure the kit was not contaminated. These blank samples are labelled as follows:
* For MYOSD 2016, any sample whose label starts with **MYOSD0** (i.e. site_id=0, see section [Sample labeling](#Sample-labeling)) is a blank except for the samples listed below as other technical samples.
* For OSD 2016, any sample whose label starts with **OSD0** (i.e. site_id=0, see section [Sample labeling](#Sample-labeling) is a blank except for the samples listed below as other technical samples.
### Others
| sample label | comment / description |
| :---| :---|
| MYOSD0_2016-06_1 | control in compliance with the MyOSD sampling protocol.
| MYOSD0_2016-06_2 | first contamination step, by placing syringe and filter on the ground
| MYOSD0_2016-06_3 | intense contamination step, by placing filter and syringe on the ground and by touching Sterivex and syringe openings without gloves
| MYOSD0_2016-06_10 | Blu Tak experiment |
| MYOSD0_2016-06_11 | Blu Tak experiment |

## Sample labeling
All samples described here are labelled using the same labeling scheme as the [2015 datasets](Guide-to-2015-data#sample-labeling), which is independent of the sample metadata, and therefore different from the labeling in the 2014.

The current labeling scheme is as follows
`${campaign_name}${site_id|kit_number}_${campaign_date}_${artificial_number}_${dataset_name}_${primer_pair_name}`

Where:

* **campaign_name** is one of:
  * OSD
  * MYOSD
* **site_id** is the stable OSD site id or the MYOSD kit number
* **campaign_date** is the date of campaign in the format 'YYYY-MM' (e.g. 2015-06)
* **artificial_number** is counting samples from the same campaign site on the same campaign_date and starts with 1
* **dataset_name** is one of
  * 16S for 16S sequence data
* **primer_pair_name** is the designation of the primer pair (see section [Primers](#Primers)); one of:
  * alma-alma

**NOTE:** Minor deviations from the scheme are possible in some file names and SILVAngs analysis results. This means that additional information might be included in the sample labels, for example '16S/18S' notation or 'qc.filt' suffix (denoting quality filtering and additional length filtering, see [Sequence Data Pre Processing]( {{'/pre-processing' | relative}} ) ).

## Sequence data access

All sequence datasets (both raw and workable) will be made available as soon as we are done with quiality control. All sequence data will be submitted for long-term archival to the [European Nucleotide Archive (ENA)](http://www.ebi.ac.uk/ena/) (see ENA umbrella project [PRJEB5129](http://www.ebi.ac.uk/ena/data/view/PRJEB5129) and/or [OSD 2014 Data Guide](OSD 2014 Data Guide)), once the manual curation of the contextual data is finalized (see section [Contextual Data](#Contextual Data) for more detail).

## Pre-processing

The pre-processsing was done using the same workflow as in 2014 with minor modifications - see [Sequence Data Pre Processing](Sequence Data Pre Processing)

## Contextual Data

The contextual data for OSD 2016 and MyOSD 2016 is currently being manually curated.

## SILVAngs Analysis

The SILVAngs analysis is currently running, stay tuned for results.
