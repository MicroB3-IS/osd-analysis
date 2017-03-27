# -*- coding: utf-8 -*-
"""
Created on Mon Mar 20 14:46:41 2017
Aim of code: from csv file with multiple MyOSD samples with microbial group counts 
(per column) create single csv file with counts and microbial taxa.
These can then be fed into Krona taxonomic pie charts.
Single csv files cannot contain lines with zero counts as these would appear in Krona chart.

@author: jbusch
"""

import csv
# insert csv with all microbial counts of MyOSD
fname = ("D:/Arbeit/Projekte/Projekte_in_Arbeit/2016_MyOSD/Data_Metadata/Microbes/myosd2015_alma-alma---ssu---fingerprint----Total---sim_93---tax_silva---td_20_nochloroplastnotecs.csv")
# Create a csv reader object.
data = csv.reader(open(fname), delimiter = ';')#,lineterminator='\n',)
#Skip the 1st header row.
header=data.next()

for i in range (len(header)-1):#loop over all columns (all except last columns contain individual samples)
    data = csv.reader(open(fname), delimiter = ';')# alternatively work with ,lineterminator='\n',)
    data.next() #skip header row
    f = open('D:/Arbeit/Projekte/Projekte_in_Arbeit/2016_MyOSD/Data_Metadata/Microbes/Krona/'+header[i]+'.csv', 'w')#open new file to write to
    for row in data: #for each column
        if float(row[i])>0: 
            f.write(""+ str(row[i]) +";"+ str(row[167]) +"\n")
        else:
            pass #omit values with zero as these would be integrated in Krona Chart
f.close()  
