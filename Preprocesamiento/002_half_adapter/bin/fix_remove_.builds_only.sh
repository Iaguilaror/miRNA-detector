#!/bin/bash

find tmp/*/* | grep ".build" > tmp/build_removables.list

while read p
do
	echo "[DEBUGGING]Removing $p"
	echo "rm $p"
	rm $p
done < tmp/build_removables.list
