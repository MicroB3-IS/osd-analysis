

standf<-function(x) x/sum(x)
osd.physeq.filtered.transf <- transform_sample_counts(osd.physeq.filtered, standf)
#gps = transform_sample_counts(GP, function(x) x/sum(x))

#TODO:make options for total read count or total feature count (i.e. annotated reads)
