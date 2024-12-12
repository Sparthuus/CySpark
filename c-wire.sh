#!/bin/bash
#filter the line with one line 
# tr trasform 
# for the case of an 4 argument to treat
#

echo "Welcome user ! Feel free to use our programm. If you need any help you can type "-h"."

if [ $1 == "-h"]; then
    cat HelpShell.txt
fi

if [ "$#" -ne 4 ] && [ "$#" -ne 3 ]; then
    echo "Bad number of arguments!"
    cat HelpShell.txt
    exit 1
fi





if ! [ -f "$1" ] ; then
    echo "$1 does not exist !"
    cat HelpShell.txt
    exit 1
fi

function compile(){
if ! [ -d "$1" ] ; then
	echo"'$1' is not a directory"
	exit 2
fi

# store directory

PATH="$1" # take value of $1 and apply it to PATH
STATION=$2
CONSUMER=$3
POWER_PLANT_ID=$4 # qu'il faudra raouter dans le ficher créé

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



##grep  filtre pr lesligne hvb et comp ex puis si on a - metrtre 0 puis finir par faire la somme des capa et des conoso finir avezc |./exec




#make before differant function for each
#use cut to only have the column needed
#use tail -n+1 to cut the first line
#tail -n+1
if 
fi
case $STATION in 
'hvb') cat $PATH | tail -n+2 | tr - 0 | cut -d ';' -f 2,7,8;;
'hva') cat $PATH | tail -n+2 | tr - 0 | cut -d ';' -f 3,7,8;;
'lv') case $CONSUMER in
        indiv) cat $PATH | tail -n+2 | tr - 0 | cut -d ';' -f 4,7,8;;
	comp);;
        all);;
;;

esac
