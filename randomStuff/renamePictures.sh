#!/bin/bash
#
#sourceDiretory="./"
#if [ -z "$1" ]
#	then
#		echo "No argument supplied. Using ./"
#	else
#		sourceDiretory=$1
#fi
#
#echo $sourceDiretory
#echo ""
#
#for sourcePath in $(find $sourceDiretory -maxdepth 1 -type f); do
##	echo $sourcePath
#    timeStamp=$(exiftool -CreateDate -FileModifyDate -DateTimeOriginal $sourcePath | awk -F: '{ print $2 ":" $3 ":" $4 ":" $5 ":" $6 }' | sed 's/+[0-9]*//' | sort | grep -v 1970: | cut -d: -f1-6 | tr ':' '_' | head -1 | tr -d ' ')
#    extension="${sourcePath##*.}"
#
#	counter=""
#	counterS=""
#	duplicate=""
#    sourcePathSum=$(md5sum $sourcePath | cut -d ' ' -f 1)
#
#	destFile=$timeStamp$counterS$counter$duplicate"."$extension; destPath=$sourceDiretory$destFile
#
#    while true; do
#        if [ -e $destPath ]; then
#			destPathSum=$(md5sum $destPath | cut -d ' ' -f 1)
#            if [ "$sourcePathSum" == "$destPathSum" ]; then
#                duplicate="_duplicate"
#            fi
#
#
#			if [ -z $counter ]; then
#				counter="1"
#				counterS="_"
#			else
#            	counter=$((counter+1))
#			fi
#
#			destFile=$timeStamp$counterS$counter$duplicate"."$extension; destPath=$sourceDiretory$destFile
#
#        else
#            break
#        fi
#	done
#
#	mv $sourcePath $destPath
#        echo $sourcePath "->" $destPath
#
#done
#
#exit

for i in $(ls $1); do
    sourceFileName=$1/$i
    timeStamp=$(exiftool -CreateDate -FileModifyDate -DateTimeOriginal $sourceFileName | awk -F: '{ print $2 ":" $3 ":" $4 ":" $5 ":" $6 }' | sed 's/+[0-9]*//' | sort | grep -v 1970: | cut -d: -f1-6 | tr ':' '_' | sed 's/ //' | tr ' ' '_' | tr -d ' ' | head -1)
#    timeStamp=$(exiftool -CreateDate -FileModifyDate -DateTimeOriginal $sourceFileName | awk -F: '{ print $2 ":" $3 ":" $4 ":" $5 ":" $6 }' | sed 's/+[0-9]*//' | sort | grep -v 1970: | cut -d: -f1-6 | tr ':' '_' | head -1 | tr -d ' ')
    extension="${sourceFileName##*.}"

    destFileName="$1$timeStamp.$extension"

    if [ -e $destFileName ]; then
        counter=1
        remove=""
        while true; do
            sum1=$(md5sum $sourceFileName | cut -d ' ' -f 1)
            sum2=$(md5sum $destFileName | cut -d ' ' -f 1)

            if [ "$sum1" == "$sum2" ]; then
                remove="D"
            fi


            destFileName="$1$timeStamp"_"$remove$counter.$extension"
            if [ -e $destFileName ]; then
                counter=$((counter+1))
            else
                break
            fi
        done
    fi

    mv $sourceFileName $destFileName



    echo $i $timeStamp $extension "->" $destFileName
done
