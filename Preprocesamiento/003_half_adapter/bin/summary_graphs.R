library(ggplot2)

wg.summary.df <- read.table("results/preprocessing_summary.tsv", header = T, sep = "\t", stringsAsFactors = F)

wg.summary.df$trimming_time <- wg.summary.df$cutadapt_time.SEC +
    wg.summary.df$trimming_time.SEC +
    wg.summary.df$minimizing_time.SEC +
    wg.summary.df$fasta_conversion_time.SEC

wg.summary.df$trimming_speed.MBperSEC <- wg.summary.df$fastq_gz_size.MB / wg.summary.df$trimming_time

wg.completed_SRA <- wg.summary.df[!is.na(wg.summary.df$trimming_speed.MBperSEC),]

N_OF_SAMPLES <- nrow(wg.completed_SRA)

generation_speed = data.frame(wg.summary.df$trimming_speed.MBperSEC)

wg.speed_plot <-    ggplot(data = generation_speed, aes(x = "", y = generation_speed)) +
    geom_boxplot(varwidth=T) +
    labs(
        title = "fastq.gz to fasta processing speed",
        x = "SRA samples",
        y = "MB/sec",
        caption = paste0("* based on data from ",N_OF_SAMPLES," SRA files for miRNA experiments")
    ) +
    theme(
        plot.title = element_text(size = 20, hjust = 0.5, face="bold"),
        plot.caption = element_text(hjust = 1, face="bold"),
        axis.title = element_text(size = 15, hjust = 0.5)
    )

wg.speed_plot

# pdf(paste0("results/fasq_generation_speed.pdf"))
# print(wg.speed_plot)
# dev.off()
