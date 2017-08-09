#!/bin/bash

find tmp/*/* | grep -v ".report" > tmp/removables.list

while read p
do
	echo "[DEBUGGING]Removing $p"
	echo "rm $p"
##	rm $p
done < tmp/removables.list
