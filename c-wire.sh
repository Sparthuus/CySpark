#!/bin/bash 
# make for lv all special treat at (the end 10 highest (capcity - load) and 10 lowest do the same but at the end sort by capacity or load 
#do we need to add helpshell at every error
# i need to add the csv name file and put that in the temp directory for lv only
# check if the input file is realy needed
# if to file hvb comp with diferant data make sur to mouve the first on your personal desktup ( add to read me)


#temp should be cleared at the start
make

bash login.sh
          
echo
echo "Welcome user ! Feel free to use our programm. If you need any help you can type "-h"."
echo



for arg in "$@"; do
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

if ! [ -d tmp ] ; then
    mkdir tmp
fi
if ! [ -d input ] ; then
	mkdir input
fi




if ! [ -f "$1" ] ; then
    echo "$1 does not exist !"
    echo
    cat HelpShell.txt
    echo
    exit 2
fi

if ! [ -x "./exec" ]; then
    echo "error exec doesn't exit !"
    echo
    exit 32
fi

# store directory

FILEPATH="$1" 
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
			
			touch "hvb_comp.csv"
			echo "Station: hvb Capacité: Comsommateurs (entreprises) " > hvb_comp.csv
			cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;[0-9]+;-;-;" | tr '-' '0' | cut -d ';' -f 2,7,8 | ./exec | sort -t ':' -k2 -n >> hvb_comp.csv
			;;
		'hva') 
			touch "hva_comp.csv"
			echo "Station: hva Capacité: Comsommateurs (entreprises) " > hva_comp.csv
			cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;[0-9-]+;[0-9]+;-;" | tr '-' '0' | cut -d ';' -f 3,7,8 | ./exec | sort -t ':' -k2 -n >> hva_comp.csv
			;;
		*) 
			case $CONSUMER in  
				indiv) 
					touch "lv_indiv.csv"
					echo "Station: lv Capacité: Comsommateurs (individuel) " > lv_indiv.csv
					cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;-;-;[0-9]+;-;" | tr '-' '0' | cut -d ';' -f 4,7,8 | ./exec | sort -t ':' -k2 -n >> lv_indiv.csv
					;;
				comp) 
					touch "lv_comp.csv"
					echo "Station: lv Capacité: Comsommateurs (entreprises) " > lv_comp.csv
					cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;-;[0-9-]+;[0-9]+;[0-9-]+;-;" | tr '-' '0' | cut -d ';' -f 4,7,8 | ./exec | sort -t ':' -k2 -n >> lv_comp.csv
					;;
				*) 
                    temp="lv_all.csv"
					echo "Station: lv Capacité: Comsommateurs (tous) " > "$temp"
    				touch "$temp" | mv "$temp" temp
					cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;-;-;[0-9]+;" | tr '-' '0' | cut -d ';' -f 4,7,8 | ./exec  >> /temp/"$temp"
                       
					
					;;
			esac
			;;
	esac
 
	
else
	case "$STATION" in 
	        'hvb') 
				touch "hvb_comp_$POWER.csv"
				echo "Station: hvb Capacité: Comsommateurs (entreprises) " > hvb_comp_$POWER.csv
		        cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;[0-9]+;-+;-;" | tr '-' '0' | cut -d ';' -f 2,7,8 | ./exec | sort -t ':' -k2 -n >> hvb_comp_$POWER.csv
		        ;;
	        'hva') 
	 			touch "hva_comp_$POWER.csv"
				echo "Station: hva Capacité: Comsommateurs (entreprises) " > hva_comp_$POWER.csv
		        cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;[0-9-]+;[0-9]+;-;" | tr '-' '0' | cut -d ';' -f 3,7,8 | ./exec | sort -t ':' -k2 -n >> hva_comp_$POWER.csv
		        ;;
	        *)     
				case $CONSUMER in  
                                'indiv') 
									touch "lv_indiv_$POWER.csv"
									echo "Station: lv Capacité: Comsommateurs (individuels) " > lv_indiv_$POWER.csv
									cat $FILEPATH | tail -n+2 | grep -E "^$POWER;-;-;[0-9]+;-;" | tr - 0 | cut -d ';' -f 4,7,8 | ./exec | sort -t -k3 -n >> lv_indiv_$POWER.csv
									;;
	                       		 'comp')
									touch "lv_comp_$POWER.csv"
									echo "Station: lv Capacité: Comsommateurs (individuels) " > lv_comp_$POWER.csv
			 						cat $FILEPATH | tail -n+2 | grep -E "^$POWER;-;-;[0-9]+;[0-9]+;-;" | tr - 0 | cut -d ';' -f 4,7,8 | ./exec | sort -t -k3 -n >> lv_comp_$POWER.csv
									;;
                                *) 
                                    var="lv_all_$POWER.csv"
									echo "Station: lv Capacité: Comsommateurs (tous)) " > "$var"
									touch "$var" | mv "$var" temp 
									cat $FILEPATH | tail -n+2 | grep -E "^$POWER;-;-;[0-9]+;" | tr - 0 | cut -d ';' -f 4,7,8 | ./exec >> /temp/"$var"
    								;;
                       esac
		        
		        ;;
	esac

fi


echo "You can find your sorted data in the program directory"
make clean
