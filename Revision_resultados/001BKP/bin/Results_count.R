counts.df <- read.csv("data/conteo_miRNAs.csv", header = T, stringsAsFactors = F)

total_counts.df <- data.frame(SRR_id=character(nrow(counts.df)),
                              reads_in_SRA_archive=numeric(nrow(counts.df)), stringsAsFactors = F
                              )

for (i in 1:nrow(counts.df))    {
    total_counts.df$SRR_id[i] <- counts.df[i,1]
    total_counts.df$reads_in_SRA_archive[i] <- sum(counts.df[i,-1])
}

# summary(total_counts.df$reads_in_SRA_archive)

# hist(total_counts.df[total_counts.df$reads_in_SRA_archive < 1000, ]$reads_in_SRA_archive,
#      main="Reads in SRA archive",
#      xlab="Reads",
#      border="blue",
#      col="green",
#      xlim=c(0,1000),
#      las=1,
#      breaks=5)

SRA_low_counts <- total_counts.df[total_counts.df$reads_in_SRA_archive < quantile(total_counts.df$reads_in_SRA_archive, 0.25), ]   ##get id's belonging to the firs quartile (SRA files with low read counts)

write.table(SRA_low_counts[,1], "tmp/SRAids_with_low_counts", quote = F, sep = "\t", col.names = F, row.names = F)
