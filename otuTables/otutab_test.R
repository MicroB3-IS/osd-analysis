orig<-read.csv("osd2014_18s_v4_lifewatch_otu_by_sample.csv",row.names=1,check.names=FALSE,fill=FALSE)
otutab<-read.csv("otutab.csv",row.names=1,check.names=FALSE,fill=FALSE)

otutab<-otutab[match(rownames(orig), rownames(otutab)),]

orig.t<-as.data.frame(t(orig))
otutab.t<-as.data.frame(t(otutab))

otutab.t<-otutab.t[match(rownames(orig.t), rownames(otutab.t)),]

table(rownames(orig.t) == rownames(otutab.t))
table(colnames(orig.t) == colnames(otutab.t))

all(orig.t == otutab.t)

table(rowSums(orig.t) == rowSums(otutab.t))
table(colSums(orig.t) == colSums(otutab.t))
    