#!/bin/bash
#filter the line with one line 
# tr trasform 
# check nb args wich need an adjustment
if [ "$#" -ne 1 ] ; then
    echo "Bad nb args !"
    exit 1
fi

# check arg is a directory( if needed )
if ! [ -d "$1" ] ; then
    echo "'$1' is not a directory !"
    exit 2
fi

file1=$1

if ! [ -f "$file1" ] ; then
    echo "$file1 does not exist !"
    exit 1
fi

echo "Hello !"
echo "Welcome user ! Feel free to use our programm. If you need any help you can type "-h"."

function help(){
    echo "blablba"
    case 
}


function compile(){
POWER_PLANT_ID=$1
STATION_TYPE=$2
CONSUMER_TYPE=$3
CSV_FILE=$4

if [ $STATION_TYPE != "hva" ] && [ $STATION_TYPE != "hvb" ] && [ $STATION_TYPE != "lv" ]; then
    echo "Error : station type must be : hva, hvb, lv"
    exit 1
fi

if  [ $CONSUMER_TYPE != "indiv" ] && [ $CONSUMER_TYPE != "all" ] && [ $CONSUMER_TYPE != "comp" ]; then
    echo "Error : consummer type must be : all, indiv, comp"
    exit 1
fi

if  { [[ ${CONSUMER_TYPE,,} == "indiv" ]] || [[ ${CONSUMER_TYPE,,} == "all" ]] } && [ ${STATION_TYPE,,} == "hvb" ]; then
    echo "Error : you can't have indiv or all AND hvb"
    exit 1
fi

if  { [[ ${CONSUMER_TYPE,,} == "indiv" ]] || [[ ${CONSUMER_TYPE,,} == "all" ]] } && [ ${STATION_TYPE,,} == "hva" ]; then
    echo "Error : you can't have indiv or all AND hva"
    exit 1
fi

if [! -f CSV_FILE
