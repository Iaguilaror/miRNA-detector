#!/bin/bash

echo "[FIX]number of .sra files: $(ls tmp/*.sra | wc -l |cut -d"," -f1)"
echo "[FIX]number of .sra.report files: $(ls tmp/*.sra.report | wc -l |cut -d"," -f1)"
echo "[FIX]number of .fastq.gz files: $(ls results/*.gz | wc -l |cut -d"," -f1)"
echo "[FIX]number of .fastq.gz.report files: $(ls results/*.fastq.gz.report | wc -l |cut -d"," -f1)"

##Find which fastq files have reports but not fastq.gz

ls results/*.fastq.gz.report | sed "s#.report##g" > w_report.tmp
ls results/*.fastq.gz > no_report.tmp