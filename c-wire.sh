#!/bin/bash
#filter the line with one line 
# tr trasform 
# for the case of an 4 argument to treat
# make for lv all special treat at (the end 10 highest (capcity - load) and 10 lowest
#!/bin/bash
#filter the line with one line 
# tr trasform 
# for the case of an 4 argument to treat
# make for lv all special treat at (the end 10 highest (capcity - load) and 10 lowest

clear
echo
echo "Welcome user ! Feel free to use our programm. If you need any help you can type "-h"."
echo

for arg in "$@"; doif [ -z "$POWER" ]; then
	case "$STATION" in 
		'hvb') 
			cat "$FILEPATH" | tail -n+2 | tr '-' '0' || cut -d ';' -f 2,7,8
			;;
		'hva') 
			cat "$FILEPATH" | tail -n+2 | tr '-' '0' || cut -d ';' -f 3,7,8
			;;
		*) 
			cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;" | tr '-' '0' | cut -d ';' -f 4,7,8
			;;
	esac
	
else
	case "$STATION" in 
	        'hvb') 
		        cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;" | tr '-' '0' | cut -d ';' -f 2,7,8
		        ;;
	        'hva') 
		        cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;" | tr '-' '0' | cut -d ';' -f 3,7,8
		        ;;
	        *)     case $CONSUMER in  
                                indiv) cat $FILEPATH | tail -n+2 | tr - 0 || cut -d ';' -f 4,7,8;;
	                        comp)cat $FILEPATH | tail -n+2 | tr - 0 | grep -E "^[0-9]+;[0]+;[0]+;[0-9]+;[0]+;" | cut -d ';' -f 4,7,8;;
                                all);;
                       esac
		        
		        ;;
	esac
fi
        if [[ "$arg" == "-h" ]]; then  
                cat HelpShell.txt
                exit 0 
        fi
done


if [ $# -ne 4 ] && [ $# -ne 3 ]; then
    echo "Bad number of arguments!"
    echo
    cat HelpShell.txt
    echo
    exit 1
fi





if ! [ -f "$1" ] ; then
    echo "$1 does not exist !"
    echo
    cat HelpShell.txt
    echo
    exit 2
fi

# store directory

FILEPATH="$1" # take value of $1 and apply it to FILEPATH
STATION=$2
CONSUMER=$3
POWER=$4 

#Convert into lowercase caracters
STATION=${STATION,,}
CONSUMER=${CONSUMER,,}


# Checking all the parameters
if [ "$STATION" != "hva" ] && [ "$STATION" != "hvb" ] && [ "$STATION" != "lv" ]; then
    echo "Error: station type must be one of: hva, hvb, lv"
    echo
    exit 4
fi


if [ "$CONSUMER" != "all" ] && [ "$CONSUMER" != "indiv" ] && [ "$CONSUMER" != "comp" ]; then
    echo "Error: consumer type must be one of: all, indiv, comp"
    echo
    exit 5
fi


if [[ "$STATION" == "hva" && ( "$CONSUMER" == "indiv" || "$CONSUMER" == "all" ) ]]; then
    echo "Error: you can't have hva AND indiv or all"
    echo
    exit 6
fi

if [[ "$STATION" == "hvb" && ( "$CONSUMER" == "indiv" || "$CONSUMER" == "all" ) ]]; then
    echo "Error: you can't have hvb AND indiv or all"
    echo
    exit 7
fi

echo "All parameters are valid."




##grep  filtre pr lesligne hvb et comp ex puis si on a - metrtre 0 puis finir par faire la somme des capa et des conoso finir avezc |./exec




#make before differant function for each
#use cut to only have the column needed
#use tail -n+1 to cut the first line
#tail -n+1
if [ -n "$POWER" ] && [ $POWER -le 0 ]; then
	echo "Parameter value is incorrect!"
 	cat HelpShell.txt
 	echo
 	exit 8

fi

if [ -z "$POWER" ]; then
	case "$STATION" in 
		'hvb') 
			cat "$FILEPATH" | tail -n+2 | tr '-' '0' || cut -d ';' -f 2,7,8
			;;
		'hva') 
			cat "$FILEPATH" | tail -n+2 | tr '-' '0' || cut -d ';' -f 3,7,8
			;;
		*) 
			cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;" | tr '-' '0' | cut -d ';' -f 4,7,8
			;;
	esac
	
else
	case "$STATION" in 
	        'hvb') 
		        cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;" | tr '-' '0' | cut -d ';' -f 2,7,8
		        ;;
	        'hva') 
		        cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;" | tr '-' '0' | cut -d ';' -f 3,7,8
		        ;;
	        *)     case $CONSUMER in  
                                indiv) cat $FILEPATH | tail -n+2 | tr - 0 || cut -d ';' -f 4,7,8;;
	                        comp)cat $FILEPATH | tail -n+2 | tr - 0 | grep -E "^[0-9]+;[0]+;[0]+;[0-9]+;[0]+;" | cut -d ';' -f 4,7,8;;
                                all);;
                       esac
		        
		        ;;
	esac
fi
