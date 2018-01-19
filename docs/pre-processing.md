---
title: "Sequence data pre-processing"
permalink: "/pre-processing"
data:
  2014:
    guide: "/data/2014"
---
# Overview

**Definition:** *pre-processing* is defined as the process in which a subset of the original raw sequence data is created which fulfills defined sequence quality criteria, suitable for further analyses.

**Intent:** The goal of formalizing this workflow is to provide all OSD participants (and the whole scientific community) with a single, quality-controlled data set in order to ensure comparability and repeatability of analysis results.

**Scope:** The workflow covers both amplicon (i.e. 16/18S rDNA) and shotgun (i.e. metagenome) data sequenced with Illumina MiSeq.

**Input:** Sequences ‘as they are delivered by the sequencing centers’. More specifically, no filtering of any kind (e.g. quality, length) has been done yet.

## Data delivery by sequencing center

Sequence data was delivered by tree different sequencing center. See also [Guide to OSD 2014 Data]( {{ data.2014.guide | relative_url }} )

## Illumina pre-processing workflow

![Sketch of the sequence pre-processing steps of OSD 2014](https://github.com/MicroB3-IS/osd-analysis/blob/master/images/osd-pre-processsing-activity-diagram-2014.png)

Caption: Quality control (using FASTQC) is done after each individual step, except shotgun step 3. The QC information is only used for actual filtering before submitting the ‘workable’ data sets. Otherwise, it has a purely informative function.

## Workflow steps

All pre-processing was done using Bash scripts. The code is available here [https://colab.mpi-bremen.de/micro-b3/svn/analysis-scripts/trunk/osd-analysis/osd-pre-processing/](https://colab.mpi-bremen.de/micro-b3/svn/analysis-scripts/trunk/osd-analysis/osd-pre-processing/)

A graphical overview is shown above in short the steps of each pre-processing pipeline:

### 16S/18S rDNA Amplicon Data

1. demultiplexing 

    Sequence data from all sequencing centers were already de-multiplexed.
1. sort reads  (cutadapt)

     Already done by LifeWatch.
1. clip adapters (Only done on LGC sequence reads, trimmomatic)
1. clip primers (cutadapt)

     Submitted to ENA
1. merge reads
1. trim by quality
1. filter by length
1. final QC 

     Submitted to ENA.

### Metagenome (shotgun) data

1. demultiplexing 
   
     Sequence data from all sequencing centers were already de-multiplexed.

1. clip adapters (Trimmomatic)

     Submitted to ENA.

1. trim by quality

1. filter by length

1. final QC

## Output

### ‘raw’ and ‘workable’ data sets 

We provide two versions for both amplicon and metagenome data sets:

1.  **‘raw’** version only includes initial Quality Control (QC) and demultiplexing
The ‘raw’ version is intended for advanced users who might (1) have their own pre-processing pipelines or (2) prefer to use different tools and parameters than the ones chosen by the OSD Analysis Team.

1. **‘workable’** version is the one resulting at the end of the pre-processing workflow. The ‘workable’ version will be used for all further analyses in the consortium. This version should be recommended as it guarantees comparability results.

The output of the pre-processing workflow are quality-controlled data sets, ready for analysis (e.g. SILVAngs, MG-Traits, EMG (MG-Portal) among others).

* For amplicon data the output files per sample are:
  * raw: non-merged
  * workable: merged 
* For shotgun data the output files per sample are:
  * raw: non-merged (used e.g. for EMG)
  * workable output files
    * merged (used e.g. by mg-traits) 
    * non-merged (used e.g. for assemblies)

[All workable data sets are downloadable here](http://mb3is.megx.net/osd-files?path=/2014/datasets/workable/)

## Background

We chose [PEAR](http://bioinformatics.oxfordjournals.org/content/30/5/614.long) for merging reads. Antonio did an extensive comparison of [FLASH](http://ccb.jhu.edu/software/FLASH/), [BBMerge](http://sourceforge.net/projects/bbmap/) and [PEAR](http://bioinformatics.oxfordjournals.org/content/30/5/614.long). In a nutshell, FLASH produces weird results, whereas BBMerge, SeqPrep and PEAR have comparable outputs. [PEAR](http://bioinformatics.oxfordjournals.org/content/30/5/614.long) was chosen because it is already published and thus citable. [Detailed results and discussion of Antonio's test can be found here](https://colab.mpi-bremen.de/wiki/display/microb3/OSD+LGC+TestRun+Sept+2014+merging+comparison).  [Another detailed forum discussion on the different tools and their performance.](http://seqanswers.com/forums/showthread.php?t=43906)
