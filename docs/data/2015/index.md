---
---
# Introduction

Purpose of this guide is to give a consolidated and authoritative overview of the data from OSD 2015.
After reading this guide, you should:

* have an overview of which data from OSD 2015 is available and how to access it
* understand how the data was generated
* be able to correctly use and interpret the data

## Overview of data sets

## Primers

In 2015 we started using a new primer pair, designated **alma-alma** (to be distinguished from the original, designated **osd-osd**). The 16S **osd-osd** primer pair is described in [Caporaso et al., 2012](https://dx.doi.org/10.1038/ismej.2012.8) (see Supplementary Material). The 16S **alma-alma** primer pair is described in [Parada et al., 2016](https://dx.doi.org/10.1111/1462-2920.13023). The 18S **osd-osd** primer pair is based on [Stoeck et al., 2010](10.1111/j.1365-294X.2009.04480.x) -

 **PLEASE NOTE** the sequence of the reverse primer was modified by adding an extra TGA triplet at the 3' end. An overview table is available below.

| ribosomal subunit | designation | direction | label | sequence | reference |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 16S | alma | forward | 515F-Y | 5'-GTGYCAGCMGCCGCGGTAA-3' | [Parada et al., 2016](https://dx.doi.org/10.1111/1462-2920.13023) |
| 16S | alma | reverse | 926R | 5'-CCGYCAATTYMTTTRAGTTT-3' | [Parada et al., 2016](https://dx.doi.org/10.1111/1462-2920.13023) |
| 16S | osd | forward | 515F | 5'-GTGCCAGCMGCCGCGGTAA-3' |  [Caporaso et al., 2012](https://dx.doi.org/10.1038/ismej.2012.8) |
| 16S | osd | reverse | 806R | 5'-GGACTACHVGGGTWTCTAAT-3' |  [Caporaso et al., 2012](https://dx.doi.org/10.1038/ismej.2012.8) |
| 18S | osd | forward | TAReuk454FWD1 | 5′-CCAGCASCYGCGGTAATTCC-3′ | [Stoeck et al., 2010](10.1111/j.1365-294X.2009.04480.x) |
| 18S | osd | reverse | TAReukREV3_modified | 5'-ACTTTCGTTCTTGATYRATGA-3' | modified after [Stoeck et al., 2010](10.1111/j.1365-294X.2009.04480.x) |

## 16S datasets

* OSD 2015 (alma-alma)
* MYOSD 2015 (alma-alma)
* OSD 2014 (alma-alma) - re-sequencing of the OSD 2014 16S samples with the alma-alma primer pair for comparability

## 18S datasets

* OSD 2015 (osd-osd)

## Technical samples

Several Blanks, a staggered community and an even community samples were sequenced with the 16S alma-alma primer pair as controls.

* The OSD 2015 samples labelled OSD201, OSD202, OSD203, OSD204, OSD205, OSD206, OSD207, OSD209 are blanks.
* The DNA extractions (for both OSD and MYOSD) were done using eight DNA extraction kits. For each kit one extraction was done on sterile water to ensure the kit was not contaminated.
* **IMPORTANT NOTE:** Sample OSD203 was sent as a blank to the sequencing center but the results (e.g. SILVAngs analysis) we got suggest the labels were mixed up and this is now a valid water sample, but unfortunately we cannot trace back which water sample that might be. The sample is available in all datasets and is included in the [SILVAngs Analysis](#SILVAngs Analysis).

* Several blanks from OSD 2014 were re-sequenced with the **alma-alma** primer pair. An overview table is available below.

| sample label | community |
| --- | --- |
| TEC0_2015-06_1_16S_alma-alma | evencom |
| TEC0_2015-06_2_16S_alma-alma | stagcom |
| TEC0_2014-06_1_16S_alma-alma | blank |
| TEC0_2014-06_2_16S_alma-alma | DNA Kit 1|
| TEC0_2014-06_3_16S_alma-alma | DNA Kit 2|
| TEC0_2014-06_4_16S_alma-alma | DNA Kit 3|

**NOTE:** The technical samples labelled 'TEC0_...' were included in most (but not all) SILVAngs analyses. Please consult the section [SILVAngs Analysis](#SILVAngs Analysis) for more detail.

## Sample labeling

All samples described here are labelled using a new labeling scheme, which is independent of the sample metadata, and therefore different from the labeling in the 2014. The reason is that in 2014 we experienced a lot of metadata changes which happened after the sequence data was already pre-processed and even analysed, which made correcting the labels extremely difficult. Once the metadata for 2015 is finally curated we will provide a mapping between the new and the old label scheme.
The new labeling scheme is as follows
`${campaign_name}${site_id|kit_number}_${campaign_date}_${artificial_number}_${dataset_name}_${primer_pair_name}`

Where:

* **campaign_name** is one of:
  * OSD
  * MYOSD
* **site_id** is the stable OSD site id or the MYOSD kit number
* **campaign_date** is the date of campaign in the format 'YYYY-MM' (e.g. 2015-06)
* **artificial_number** is counting samples from the same campaign site on the same campaign_date and starts with 1
* **dataset_name** is one of
  * 18S for 18S sequence data
  * 16S for 16S sequence data
* **primer_pair_name** is the designation of the primer pair (see section [Primers](#Primers)); one of:
  * osd-osd
  * alma-alma

**NOTE:** Minor deviations from the scheme are possible in some file names and SILVAngs analysis results. This means that additional information might be included in the sample labels, for example '16S/18S' notation or 'qc.filt' suffix (denoting quality filtering and additional length filtering, see [Sequence Data Pre Processing](Sequence Data Pre Processing) ).

## Sequence data

### Access

All sequence data sets (both raw and workable) are available here:

* OSD 2015 16S alma-alma (147 samples, including blanks, see [Technical samples](#Technical samples) for more details): [raw](https://mb3is.megx.net/osd-files?path=%2F2015%2Fosd%2Fdatasets%2Fraw%2Frdna%2Falma-alma) - [workable](https://mb3is.megx.net/osd-files?path=%2F2015%2Fosd%2Fdatasets%2Fworkable%2Frdna%2Falma-alma)
* MyOSD 2015 16S alma-alma (167 samples): [raw](https://mb3is.megx.net/osd-files?path=%2F2015%2Fmyosd%2Fdatasets%2Fraw%2Frdna%2Falma-alma) - [workable](https://mb3is.megx.net/osd-files?path=%2F2015%2Fmyosd%2Fdatasets%2Fworkable%2Frdna)
* OSD 2015 18S osd-osd (139 samples): [raw](https://mb3is.megx.net/osd-files?path=%2F2015%2Fosd%2Fdatasets%2Fraw%2Frdna%2Fosd-osd) - [workable](https://mb3is.megx.net/osd-files?path=%2F2015%2Fosd%2Fdatasets%2Fworkable%2Frdna%2Fosd-osd)
* OSD 2014 16S alma-alma (162 samples): [raw](https://mb3is.megx.net/osd-files?path=%2F2014%2Fosd2014_alma-alma%2Fdatasets%2Fraw%2Frdna) - [workable](https://mb3is.megx.net/osd-files?path=%2F2014%2Fosd2014_alma-alma%2Fdatasets%2Fworkable%2Frdna)
* Technical samples (6 samples, see [Technical samples](#Technical samples) for more details): [raw](https://mb3is.megx.net/osd-files?path=%2F2015%2Ftechnical%2Fraw%2Frdna) - [workable](https://mb3is.megx.net/osd-files?path=%2F2015%2Ftechnical%2Fworkable%2Frdna)

All sequence data will be submitted for long-term archival to the [European Nucleotide Archive (ENA)](http://www.ebi.ac.uk/ena/) (see ENA umbrella project [PRJEB5129](http://www.ebi.ac.uk/ena/data/view/PRJEB5129) and/or [OSD 2014 Data Guide](OSD 2014 Data Guide)), once the manual curation of the contextual data is finalized (see section [Contextual Data](#Contextual Data) for more detail).

## Pre-processing

The pre-processsing was done using the same workflow as in 2014 with minor modifications - see [Sequence Data Pre Processing](Sequence Data Pre Processing)

## Contextual data

The contextual data for OSD 2015 and MyOSD 2015 is currently being manually curated.

## SILVAngs analysis

The SILVAngs analysis was carried out with SILVA version 123.1 as a reference. The results can be found here:

* [OSD 2015 16S alma-alma](https://mb3is.megx.net/osd-files?path=%2F2015%2Fosd%2Fsilva-ngs%2F16s%2Flgc%2Falma-alma) (all six technical samples included in the analysis)
* [MyOSD 2015 16S alma-alma](https://mb3is.megx.net/osd-files?path=%2F2015%2Fmyosd%2Fsilva-ngs%2F16s%2Flgc%2Falma-alma) (all six technical samples included in the analysis)
* [OSD 2015 18S osd-osd](https://mb3is.megx.net/osd-files?path=%2F2015%2Fosd%2Fsilva-ngs%2F18s%2Flgc%2Fosd-osd) (**WARNING** all six technical samples included in the analysis; however technical samples are 16S whereas this dataset is 18S)
* [OSD 2014 16S alma-alma](https://mb3is.megx.net/osd-files?path=%2F2014%2Fosd2014_alma-alma%2Fsilva-ngs)
