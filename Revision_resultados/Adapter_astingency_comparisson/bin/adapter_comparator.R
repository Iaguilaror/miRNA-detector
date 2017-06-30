library(ggplot2)
library(scales)
options(scipen=10000000)

##set.seed(666) ##For simulation of data

##Graphics for filtered reads
wg.preprocessing_file_names <- list.files("data/", pattern = ".preprocessing_summary.tsv", full.names = T)

wg.preprocessing_stats.df <- data.frame(wg.preprocessing_file_names)
wg.preprocessing_stats.df$wg.preprocessing_file_names <- gsub("data/","",wg.preprocessing_stats.df$wg.preprocessing_file_names)

colnames(wg.preprocessing_stats.df)[1] <- "File_names"

wg.preprocessing_stats.df$original_reads <- 0
wg.preprocessing_stats.df$reads_passing_filters <- 0
wg.preprocessing_stats.df$filter <- gsub(".preprocessing_summary.tsv","",wg.preprocessing_stats.df$File_names)

for (i in 1:length(wg.preprocessing_file_names)) {
    wg.filter <- unlist(strsplit(wg.preprocessing_file_names[i], split = "/"))[2]
    wg.filter <- unlist(strsplit(wg.filter, split = "\\."))[1]

    wg.df <- read.table(wg.preprocessing_file_names[i], header = T, sep = "\t", stringsAsFactors = F)

    ##Prepare data frame for percentage comparison
    wg.df$Filter_type <- wg.filter

    if ( i == 1 ) {
        wg.adapter_percentages.df <- wg.df[0,c(1,7,11,21)]
    }

    wg.adapter_percentages.df <- rbind(wg.adapter_percentages.df,wg.df[,c(1,7,11,21)])
    #####

    assign(paste0("wg.",wg.filter,".df"), wg.df)

    wg.preprocessing_stats.df$original_reads[i] <- sum(wg.df$original_reads)
    wg.preprocessing_stats.df$reads_passing_filters[i] <- sum(wg.df$minimized_reads)
}

##BOXPLOT for adapter percentage

means <- aggregate(adapter_percentage_in_slice ~  Filter_type, wg.adapter_percentages.df, mean)

wg.adapter_percentages.df$Filter_type <- factor(wg.adapter_percentages.df$Filter_type, levels=c("permisive", "half_adapter", "strict"))

wg.plot1 <- ggplot(wg.adapter_percentages.df, aes(x = Filter_type, y = adapter_percentage_in_slice, fill = Filter_type)) +
    geom_boxplot() +
    geom_text(data = means, aes(label = paste0(adapter_percentage_in_slice, " %"), y = adapter_percentage_in_slice + 1)) +
    scale_y_continuous(
        limits = c(0,100),
        breaks = c(seq(0,100,by = 5))
        ) +
    labs(
        title = " Effect of cutadapt astringency on percentage of reads with adapter in select SRR-archive \n",
        x = "\nFilter type",
        y = "% of reads with adapter\n"
    ) +
    scale_fill_discrete(name = "Filter Type") +
    theme_light() +
    theme(
        plot.title = element_text(size = rel(1)),
        axis.title = element_text(size = rel(1)),
##        legend.title = element_text(size = rel(1)),
##        legend.text = element_text(size = rel(1)),
        axis.text.y = element_text(size = rel(1))
    )


###

wg.preprocessing_stats.df$filter <- factor(wg.preprocessing_stats.df$filter, levels=c("permisive", "half_adapter", "strict"))

wg.plot2 <- ggplot(wg.preprocessing_stats.df, aes(filter, reads_passing_filters, fill = filter)) +
    geom_col(position = 'dodge') +
    geom_text(aes(label=reads_passing_filters), position=position_dodge(width=0.9), vjust=-0.25) +
    scale_y_continuous( label = unit_format("\nreads") ) +
    labs(
        title = " Effect of cutadapt astringency on Filtered Reads in select SRR-archive \n",
        x = "\nTable names",
        y = "Reads passing trimming filters\n"
    ) +
    scale_fill_discrete(name = "Filter Type") +
    theme_light() +
    theme(
        plot.title = element_text(size = rel(1)),
        axis.title = element_text(size = rel(1)),
        legend.title = element_text(size = rel(1)),
        legend.text = element_text(size = rel(1)),
        axis.text.y = element_text(size = rel(1))
    )

### Graphics for adapter percentage in SRA files


##Graphics for Total counts
wg.count_file_names <- list.files("data/", pattern = ".count_table.tsv", full.names = T)

wg.stats.df <- data.frame(wg.count_file_names)
wg.stats.df$wg.count_file_names <- gsub("data/","",wg.stats.df$wg.count_file_names)

colnames(wg.stats.df)[1] <- "File_names"

wg.stats.df$total_counts <- 0
wg.stats.df$filter <- gsub(".count_table.tsv","",wg.stats.df$File_names)

wg.stats.df$filter <- factor(wg.stats.df$filter, levels=c("permisive", "half_adapter", "strict"))

for (i in 1:length(wg.count_file_names)) {
    wg.filter <- unlist(strsplit(wg.count_file_names[i], split = "/"))[2]
    wg.filter <- unlist(strsplit(wg.filter, split = "\\."))[1]

    wg.df <- read.table(wg.count_file_names[i], header = T, sep = "\t", stringsAsFactors = F, row.names = 1)

    assign(paste0("wg.",wg.filter,".df"), wg.df)

    wg.stats.df$total_counts[i] <- sum(wg.df)
}

wg.plot3 <- ggplot(wg.stats.df, aes(filter, total_counts, fill = filter)) +
    geom_col(position = 'dodge') +
    geom_text(aes(label=total_counts), position=position_dodge(width=0.9), vjust=-0.25) +
    scale_y_continuous( label = unit_format("\nreads") ) +
    labs(
        title = " Effect of cutadapt astringency on Sequence counts in select SRR-archive \n",
        x = "\nTable names",
        y = "Total Counts\n"
    ) +
    scale_fill_discrete(name = "Filter Type") +
    theme_light() +
    theme(
        plot.title = element_text(size = rel(1)),
        axis.title = element_text(size = rel(1)),
        legend.title = element_text(size = rel(1)),
        legend.text = element_text(size = rel(1)),
        axis.text.y = element_text(size = rel(1))
    )


####Memory_checkpoint

###SCATTER plot to see how adapter% affects counts

for (i in 1:length(wg.count_file_names)) {
    message( paste0("[DEBUGGING]doing scatterplot for ",wg.count_file_names[i]) )

    wg.count.df <- read.table(wg.count_file_names[i], header = T, sep = "\t", stringsAsFactors = F, row.names = 1)
    wg.summary.df <- read.table(wg.preprocessing_file_names[i], header = T, sep = "\t", stringsAsFactors = F)

    wg.SRRid.vec <- colnames(wg.count.df)
    wg.scatter_filter <- unlist( strsplit( unlist( strsplit(wg.count_file_names[i], split = "/") )[2], split = "\\.") )[1]

    wg.scatter.df <- data.frame(wg.SRRid.vec,
                                Total_counts=numeric( length(wg.SRRid.vec) ),
                                Adapter_percentage=numeric( length(wg.SRRid.vec) ),
                                Original_reads=numeric( length(wg.SRRid.vec) ),
                                RPM=numeric( length(wg.SRRid.vec) ),
                                stringsAsFactors = F)
    wg.scatter.df$filter_type <- wg.scatter_filter

    if ( i == 1 ) {
        wg.conjunct_scatter.df <- wg.scatter.df[0,]
    }

    for (wg in 1:nrow(wg.scatter.df)) {
        message( paste0("[DEBUGGING]counting data for ", wg.scatter.df$wg.SRRid.vec[i]) )

        wg.count_col <- grep(wg.scatter.df$wg.SRRid.vec[wg], wg.SRRid.vec)
        wg.adap <- wg.summary.df[grep(wg.scatter.df$wg.SRRid.vec[wg], wg.summary.df$SRR_id), "adapter_percentage_in_slice"]
        wg.ori_reads <- wg.summary.df[grep(wg.scatter.df$wg.SRRid.vec[wg], wg.summary.df$SRR_id), "original_reads"]

        wg.scatter.df$Total_counts[wg] <- sum(wg.count.df[,wg.count_col])
        wg.scatter.df$Adapter_percentage[wg] <- wg.adap
        wg.scatter.df$Original_reads[wg] <- wg.ori_reads
        wg.scatter.df$RPM[wg] <- wg.scatter.df$Total_counts[wg] / wg.ori_reads * 1e6
    }

    wg.conjunct_scatter.df <- rbind(wg.conjunct_scatter.df,wg.scatter.df)

    ###PLOTTING SCATTER
wg.plot4 <- ggplot(wg.scatter.df, aes(Adapter_percentage, Total_counts)) +
    geom_point() +
    scale_y_continuous( label = unit_format("\nreads") ) +
    labs(
        title = paste0("Percentage of reads with adapter, and total RNA counts \n",
                       "Filter type:",wg.scatter_filter,"\n"),
        x = "\nAdapter Percentage",
        y = "RNA Total Counts\n"
    ) +
    ##scale_fill_discrete(name = "Filter Type") +
    theme_light() +
    theme(
        plot.title = element_text(size = rel(1)),
        axis.title = element_text(size = rel(1)),
      ##  legend.title = element_text(size = rel(1)),
    ##    legend.text = element_text(size = rel(1)),
        axis.text.y = element_text(size = rel(1))
    )

assign( paste0("wg.plot4.",i) , wg.plot4)

rm(wg.plot4)

}

###Ploting conjunct scatter

wg.plot5 <- ggplot(wg.conjunct_scatter.df, aes(Adapter_percentage, Total_counts, color = filter_type)) +
    geom_point( size = 2, alpha = 0.5) +
    scale_y_continuous( label = unit_format("\nreads") ) +
    scale_fill_discrete(name = "Filter Type") +
    labs(
        title = paste0("Percentage of reads with adapter, and total RNA counts \n"),
        x = "\nAdapter Percentage",
        y = "RNA Total Counts\n"
    ) +
    theme_light() +
    theme(
        plot.title = element_text(size = rel(1)),
        axis.title = element_text(size = rel(1)),
        legend.title = element_text(size = rel(1)),
        legend.text = element_text(size = rel(1)),
        axis.text.y = element_text(size = rel(1))
    )

wg.plot6 <- ggplot(wg.conjunct_scatter.df, aes(Adapter_percentage, RPM, color = filter_type)) +
    geom_point( size = 2, alpha = 0.5) +
    scale_y_continuous( label = unit_format("\nrpm") ) +
    scale_fill_discrete(name = "Filter Type") +
    labs(
        title = paste0("Percentage of reads with adapter, and total RNA counts \n"),
        x = "\nAdapter Percentage",
        y = "Detected RPM\n"
    ) +
    theme_light() +
    theme(
        plot.title = element_text(size = rel(1)),
        axis.title = element_text(size = rel(1)),
        legend.title = element_text(size = rel(1)),
        legend.text = element_text(size = rel(1)),
        axis.text.y = element_text(size = rel(1))
    )

date <- gsub(":",".",gsub(" ","_", Sys.time()))

plot_names <- ls(pattern = "wg.plot")

pdf(paste0("results//",date,".pdf"))
    print(wg.plot1)
    print(wg.plot2)
    print(wg.plot3)
    print(wg.plot4.1)
    print(wg.plot4.2)
    print(wg.plot4.3)
    print(wg.plot5)
    print(wg.plot6)
dev.off()
