count_files <- list.files("data", pattern=".count", full.names=T)

count_table.df <- read.table(count_files[1], header=T, sep="\t")

for (n in 2:length(count_files)) {

temp.df <- read.table(count_files[n], header=T, sep="\t")

count_table.df <- merge(count_table.df, temp.df, by="sequence_name")

}

write.table(count_table.df, "results/count_table.tsv.build", append=F, quote=F, sep="\t", row.names=F)
