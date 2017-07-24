#!/bin/bash

for f in tmp/cutadapt/*.report
do
	echo "[DEBUGGING]processing $f"
	sed -i "s#^Processed# Processed#g" $f
	sed -i "s#^Trimmed# Trimmed#g" $f
done
