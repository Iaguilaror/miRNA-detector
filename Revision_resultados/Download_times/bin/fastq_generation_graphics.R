library(ggplot2)

times.df <- read.table(file = "results/fastq_generation_timetable.tsv.build", sep = "\t", header = T, stringsAsFactors = F)

times.df$total_generation_time.seconds <- times.df$sra_download_time.seconds + times.df$fastq_dump_time.seconds

times.df$file_generation_speed.MBperSEC <- times.df$fastq.gz_size.MB / times.df$total_generation_time.seconds

generation_speed = data.frame(times.df$file_generation_speed.MBperSEC)
N_OF_SAMPLES <- nrow(times.df)

wg.speed_plot <-    ggplot(data = generation_speed, aes(x = "", y = generation_speed)) +
                    geom_boxplot(varwidth=T) +
                    labs(
                        title = "fastq.gz file generation speed",
                        x = "SRA samples",
                        y = "MB/sec",
                        caption = paste0("* based on data from ",N_OF_SAMPLES," SRA files for miRNA experiments")
                        ) +
                    theme(
                        plot.title = element_text(size = 20, hjust = 0.5, face="bold"),
                        plot.caption = element_text(hjust = 1, face="bold"),
                        axis.title = element_text(size = 15, hjust = 0.5)
                         )

pdf(paste0("results/fasq_generation_speed.pdf"))
print(wg.speed_plot)
dev.off()
