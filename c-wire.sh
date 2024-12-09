#!/bin/bash
#filter the line with one line 
# tr trasform 
# check nb args wich need an adjustment
if [ "$#" -ne 4 ] && [ "$#" -ne 3 ]; then
    echo "Bad number of arguments!"
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
    echo "first type the path of your "
    echo" choose the type of statio \n type <hvb> or <hva> or <lv>"
    echo " wich kind  you want"
    case 
}


function compile(){
if ! [ -d "$1" ] ; then
	echo"'$1' is not a directory"
	exit 2
fi

# store directory

PATH="$1" # take value of $1 and apply it to PATH
STATION=$2
CONSUMER=$3
POWER_PLANT_ID=$4

# Checking all the parameters
if [ $STATION != "hva" ] && [ $STATION != "hvb" ] && [ $STATION != "lv" ]; then
    echo "Error : station type must be : hva, hvb, lv"
    exit 1
fi

if  [ $CONSUMER != "all" ] && [ $CONSUMER != "indiv" ] &&  [ $CONSUMER != "comp" ]; then
    echo "Error : consummer type must be : all, indiv, comp"
    exit 1
fi

if  [ ${STATION,,} == "hva" ] && { [[ ${CONSUMER,,} == "indiv" ]] || [[ ${CONSUMER,,} == "all" ]] }; then
    echo "Error : you can't have hva AND indiv or all"
    exit 1
fi

if  [ ${STATION,,} == "hvb" ] && { [[ ${CONSUMER,,} == "indiv" ]] || [[ ${CONSUMER,,} == "all" ]] }; then
    echo "Error : you can't have hvb AND indiv or all"
    exit 1
fi



if [! -f CSV_FILE
#we need max 4 args  min 3 

#make before differant function for each
#use cut to only have the column needed
#use tail -n+1 to cut the first line
case $STATION in 
hvb) ;;
hva);;
lv);;
esac


