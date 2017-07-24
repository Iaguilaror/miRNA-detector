library(ggplot2)
library(reshape2)

wg.summary.df <- read.table("results/preprocessing_summary.tsv", header = T, sep = "\t", stringsAsFactors = F)

DISK_SPACE.sra <- c("SRA_files", sum(wg.summary.df$sra_file_size.MB))
DISK_SPACE.fastq.gz <- c("fastq.gz_files",sum(wg.summary.df$fastq_gz_size.MB))
DISK_SPACE.intermediate <- c("intermediate_files",sum(wg.summary.df$intermediate_files_size.MB, na.rm = T))
DISK_SPACE.filtered.fasta <- c("filtered.fasta_files",sum(wg.summary.df$filtered_fasta_size.MB, na.rm = T))

wg.pie_data <- data.frame(Group=character(4),
                          USED_DISK_SPACE=integer(4),
                          stringsAsFactors = F)

wg.pie_data[1,] <- DISK_SPACE.sra
wg.pie_data[2,] <- DISK_SPACE.fastq.gz
wg.pie_data[3,] <- DISK_SPACE.intermediate
wg.pie_data[4,] <- DISK_SPACE.filtered.fasta

wg.pie_data$Group <- as.factor(wg.pie_data$Group)
wg.pie_data$USED_DISK_SPACE <- as.integer(wg.pie_data$USED_DISK_SPACE)
wg.pie_data$USED_DISK_SPACE <- wg.pie_data$USED_DISK_SPACE / 1000

DF1 <- melt(wg.pie_data, id.var="Group")

ggplot(DF1, aes(x = Group, y = value, fill = variable)) +
    geom_bar(stat = "identity")

pie <- ggplot(wg.pie_data, aes(x = USED_DISK_SPACE, fill = factor(Group))) +
    geom_bar(width = 1)

pie

####
##OLD CODE BELLOW
###
# wg.summary.df <- read.table("results/preprocessing_summary.tsv", header = T, sep = "\t", stringsAsFactors = F)
#
# wg.summary.df$trimming_time <- wg.summary.df$cutadapt_time.SEC +
#     wg.summary.df$trimming_time.SEC +
#     wg.summary.df$minimizing_time.SEC +
#     wg.summary.df$fasta_conversion_time.SEC
#
# wg.summary.df$trimming_speed.MBperSEC <- wg.summary.df$fastq_gz_size.MB / wg.summary.df$trimming_time
#
# wg.completed_SRA <- wg.summary.df[!is.na(wg.summary.df$trimming_speed.MBperSEC),]
#
# N_OF_SAMPLES <- nrow(wg.completed_SRA)
#
# generation_speed = data.frame(wg.summary.df$trimming_speed.MBperSEC)
#
# wg.speed_plot <-    ggplot(data = generation_speed, aes(x = "", y = generation_speed)) +
#     geom_boxplot(varwidth=T) +
#     labs(
#         title = "fastq.gz to fasta processing speed",
#         x = "SRA samples",
#         y = "MB/sec",
#         caption = paste0("* based on data from ",N_OF_SAMPLES," SRA files for miRNA experiments")
#     ) +
#     theme(
#         plot.title = element_text(size = 20, hjust = 0.5, face="bold"),
#         plot.caption = element_text(hjust = 1, face="bold"),
#         axis.title = element_text(size = 15, hjust = 0.5)
#     )
#
# wg.speed_plot
#
# # pdf(paste0("results/fasq_generation_speed.pdf"))
# # print(wg.speed_plot)
# # dev.off()
