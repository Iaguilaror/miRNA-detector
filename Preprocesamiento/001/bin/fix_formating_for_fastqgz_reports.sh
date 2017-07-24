#!/bin/bash

mkdir -p tmp/fixes

##make a list of .fastqz.report files
##check if report contains the "Fastq size (M):	$(ls -l --block-size=M results/$SRR_id.fastq.gz | cut -d" " -f5 | tr -d \"M\")"
##IF it doesn't contain the line, add the corresponding value with echo.

ls results/*.fastq.gz.report > tmp/fixes/fasq.gz.reports.list
while read p
do
	##echo "[DEBUGGIN] checking report for $p"
	SIZE_LINE=$(grep "Fastq size (M):" $p)
	echo "[DEBUGGIN] size line is $SIZE_LINE"
	if [ "$SIZE_LINE" == "" ]; then
		echo "[WARNING] there is no Fastq size line in $p"
		FQ_FILE=$(echo $p | sed "s#.report##g")
		echo "[FIX] adding missing line into $p"
		echo "Fastq size (M):	$(ls -l --block-size=M $FQ_FILE | cut -d" " -f5 | tr -d \"M\")" >> $p
	fi
done < tmp/fixes/fasq.gz.reports.list
