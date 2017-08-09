#!/bin/bash
source ../config.mk

mkdir -p tmp/

##echo "[DEBUGGING] adapter cuttoff is $ADAPTER_CUTTOF"
SUMMARY_FILE="../003_half_adapter/results/$(basename $SRR_FILE .txt).preprocessing_summary.tsv"

##awk -v ADP_CUTOFF="$ADAPTER_CUTTOF" 'BEGIN {FS="\t"; OFS="\t"} $8=="NA" && $7 > ADP_CUTOFF {print $1}' $SUMMARY_FILE > tmp/SRR_bad_cutadapt_report.list

awk 'BEGIN {FS="\t"; OFS="\t"} $8=="NA" {print $1}' $SUMMARY_FILE > tmp/SRR_bad_cutadapt_report.list

while read p
do
	echo "[DEBUGGING] removing results and tmp files for $p"
	find -L . -type f -name "$p*" | grep -v "data/" | xargs rm
done < tmp/SRR_bad_cutadapt_report.list
