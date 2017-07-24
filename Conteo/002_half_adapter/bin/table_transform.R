args = commandArgs(trailingOnly=TRUE)
data.df <- read.table(args[1], sep = "\t", stringsAsFactors = F)

colnames(data.df) <- data.df[1,]
data.df <- data.df[-1,]
rownames(data.df) <- data.df[,1]
data.df <- data.df[,-1]
data.df <- t(data.df)

o_file_name <- paste0(args[1],".tsv.build")

write.table(data.df, o_file_name, append = F, sep = "\t", quote = F, row.names = T, col.names = NA)
