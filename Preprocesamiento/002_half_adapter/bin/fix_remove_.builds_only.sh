#!/bin/bash

find -L tmp/ results/ \
-type f \
-name "*.build" \
| cut -d"." -f1 \
| sort -u > tmp/build_removables.list

while read p
do
	echo "removing intermediate files for $p"
##	echo "[DEBUGGING]Removing $p"
	echo "rm $p*"
	rm $p*
done < tmp/build_removables.list
