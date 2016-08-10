import csv
import logging
import sys

logging.basicConfig(level=logging.DEBUG)
usage = "No usage help at this point."


# SAMPLES
logging.debug("Reading samples...")
with open(sys.argv[1], "r") as f:
    reader = csv.reader(f, delimiter="\t", )
    next(reader)  # skip header
    sample_labels = {str(row[0]): str(row[1]) for row in reader}
logging.debug("...done.")

# OM
logging.debug("Reading otu mapping...")
otu_refs = []
with open(sys.argv[2], "r") as f:
    reader = csv.reader(f, delimiter="\t", )
    next(reader)  # skip header
    for row in reader:
        otu_refs.append(str(row[2]))
logging.debug("DONE.")

# OSM
logging.debug("Reading otu sample mapping...")
otu_samples = {}
otu_counts = {}

with open(sys.argv[3], "r") as f:
    reader = csv.reader(f, delimiter="\t", )
    next(reader)  # skip header
    for row in reader:
        otu_samples[str(row[0])] = str(row[2])
        otu_counts[str(row[0])] = str(row[3])
logging.debug("...done.")

logging.debug("Writing OTU table")
with open('otutab.csv', 'w') as otutab:
    labels = [str("otu_id")]
    labels.extend(sample_labels.values())

    writer = csv.DictWriter(otutab, fieldnames=labels, restval=0,
                             quotechar='"', quoting=csv.QUOTE_NONNUMERIC, lineterminator='\n')
    writer.writeheader()

    for otu in otu_refs:
        ss = {"otu_id": str(otu)}
        samples = str(otu_samples[str(otu)]).split(",")
        counts = str(otu_counts[str(otu)]).split(",")

        for idx, sid in enumerate(samples):
            sample = str(sample_labels[sid])
            abu = int(counts[idx])

            if (sample in ss):
                ss[sample] += abu
            else:
                ss[sample] = abu

        writer.writerow(ss)
logging.debug("...done.")
logging.debug("Exiting successfully!")