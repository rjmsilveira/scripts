#!/bin/bash


DIR2CONV=$1
CONVDIRNAME="converted"

if [ ! -d "${DIR2CONV}" ];then
        echo "Cannot find specified folder"
        exit 1
fi

if [ ! -d "${DIR2CONV}/converted" ];then
        echo "Creating destination folder for jpg's"
        mkdir -p "${DIR2CONV}/converted"
fi

IFS=$'\n'

echo "Finding CR2 files in ${DIRCONV}"
FOUNDFILES=($(find "${DIR2CONV}" -type f -iname *.cr2))
TOTALFILES=${#FOUNDFILES[@]}

#IFS=

if [ ${TOTALFILES} -eq 0 ];then
        echo "Could not find CR2 files in ${DIR2CONV}"
        exit 1
fi
#exit

COUNT=1
for ORIGPHOTO in ${FOUNDFILES[@]}; do
        echo "[${COUNT} of ${TOTALFILES}] - Converting ${ORIGPHOTO}";
        NEWPATH=$(dirname "${ORIGPHOTO}")/converted/$(basename "${ORIGPHOTO}")
        dcraw -c -w "${ORIGPHOTO}" | ppmtojpeg --quality=80  > "${NEWPATH%.*}.jpg"
        let "COUNT++"
done
echo "Process finished"
