#General
The `create_otu_table.py` generates a sample-by-otu table from SILVAngs statistics files.

# Usage

In its current (very rudimentary) form, this script takes three input files, which can be found in the `stats/data` subfolder of the SILVAngs results folder.

```
python create_otutab.py <sample_list> <otu_mapping> <otu_sample_map>
```

## Example

1. Download one of the existing `stats/data` folders, e.g. https://owncloud.mpi-bremen.de/index.php/s/RDB4Jo0PAayg3qx?path=%2F2014%2Fsilva-ngs%2F18s%2Flifewatch%2Fv4%2Fstats

```
python create_otu_table.py data/osd2014_18s_v4_lifewatch---ssu---samples.stats \
  data/osd2014_18s_v4_lifewatch---ssu---otu_mapping.stats \
  data/osd2014_18s_v4_lifewatch---ssu---otu_sample_map.stat
```

The output is a file named `otutab.csv` in the folder where the script is invoked.

1. You can download the existing otu table, e.g. https://owncloud.mpi-bremen.de/index.php/s/RDB4Jo0PAayg3qx?path=%2F2014%2Fsilva-ngs%2F18s%2Flifewatch%2Fv4%2Fotu_table# and use the `otutab_test.R` to compare the two.

## Running with Docker
In case you don't have Python >=2.7, you can run the script in a [Docker Container](https://docs.docker.com/engine/tutorials/usingdocker/) (e.g. with [python:alpine](https://hub.docker.com/_/python/)) like this:
```
docker run -it --rm --name osd-otu -v "$PWD":/data -w /data python:alpine python create_otu_table.py myosd2015_alma-alma---ssu---samples.stats myosd2015_alma-alma---ssu---otu_mapping.stats myosd2015_alma-alma---ssu---otu_sample_map.stats
```
[Docker Installation Instructions](https://docker.github.io/engine/installation/)
