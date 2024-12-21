#!/bin/bash

#creation of the executable file
clear
cd codeC
make
cd ..

# displaying the logo
bash codeShell/intro.sh
          

# Check if any argument matches "-h" and display the help
for arg in "$@"; do
    if [[ "$arg" == "-h" ]]; then
        cat HelpShell.txt
        exit 1
    fi
done



# Check if the number of arguments passed are different than 4 or 3
if [ $# -ne 4 ] && [ $# -ne 3 ]; then
    echo "Bad number of arguments!"
    echo
    cat HelpShell.txt
    echo
    exit 2
fi

# Check if the directory 'input' does not exist
if ! [ -d input ] ; then
    mkdir input
fi




# Check if the first argument is a file or not
if ! [ -f "$1" ] ; then
    echo "$1 does not exist !"
    echo
    cat HelpShell.txt
    echo
    exit 3
fi

# Check if the file 'exec' is not executable (or doesn't exist)
if ! [ -x "./codeC/exec" ]; then
    echo "error exec doesn't exist !"
    echo
    cd codeC
    make
    cd ..
fi


# store arguments
FILEPATH="$1"
COMMAND="$@"
STATION=$2
CONSUMER=$3
POWER=$4

#Convert into lowercase caracters
STATION=${STATION,,}
CONSUMER=${CONSUMER,,}


# Check if the value of the STATION variable is not "hva", "hvb", or "lv"
if [ "$STATION" != "hva" ] && [ "$STATION" != "hvb" ] && [ "$STATION" != "lv" ]; then
    echo "Error: station type must be one of: hva, hvb, lv"
    echo
    exit 4
fi

# Check if the value of the CONSUMER variable is not "all", "indiv", or "comp"
if [ "$CONSUMER" != "all" ] && [ "$CONSUMER" != "indiv" ] && [ "$CONSUMER" != "comp" ]; then
    echo "Error: consumer type must be one of: all, indiv, comp"
    echo
    exit 5
fi

# Check if the STATION is "hva" and CONSUMER is either "indiv" or "all"
if [[ "$STATION" == "hva" && ( "$CONSUMER" == "indiv" || "$CONSUMER" == "all" ) ]]; then
    echo "Error: you can't have hva AND indiv or all"
    echo
    exit 6
fi

# Check if the STATION is "hvb" and CONSUMER is either "indiv" or "all"
if [[ "$STATION" == "hvb" && ( "$CONSUMER" == "indiv" || "$CONSUMER" == "all" ) ]]; then
    echo "Error: you can't have hvb AND indiv or all"
    echo
    exit 7
fi
# Check if the last argument is a number
if [ -n "$POWER" ]; then
    if ! [[ "$POWER" =~ ^-?[0-9]+$ ]] || [ "$POWER" -le 0 ]; then
        echo "4th parameter is incorrect!"
        cat HelpShell.txt
        echo
        exit 8
    fi
fi

echo
echo "All parameters are valid."

cp $FILEPATH input
FILEPATH="input/$1"


if [ -z "$POWER" ]; then
   START_SEC=$(date +%s)         # Time in seconds
    START_NANO=$(date +%N)        # Time in nanoseconds

# Thz switch case checks depending on the values of the STATION and CONSUMER variables, it generates different CSV files that summarize consumer capacity data.
    case "$STATION" in
        'hvb')
            
            touch "hvb_comp.csv"
            echo "Station hvb: Capacity: Consumers (companies) " > hvb_comp.csv
            cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;[0-9]+;-;-;" | tr '-' '0' | cut -d ';' -f 2,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> hvb_comp.csv
            ;;
        'hva')
            touch "hva_comp.csv"
            echo "Station hva: Capacity: Consumers (companies) " > hva_comp.csv
            cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;[0-9-]+;[0-9]+;-;" | tr '-' '0' | cut -d ';' -f 3,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> hva_comp.csv
            ;;
        *)
            case $CONSUMER in
                indiv)
                    touch "lv_indiv.csv"
                    echo "Station lv : Capacity: Consumers (individual) " > lv_indiv.csv
                    cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;-;[0-9-]+;[0-9]+;-;[0-9-]+" | tr '-' '0' | cut -d ';' -f 4,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> lv_indiv.csv
                    ;;
                comp)
                    touch "lv_comp.csv"
                    echo "Station lv: Capacity: Consumers (companies) " > lv_comp.csv
                    cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;-;[0-9-]+;[0-9]+;[0-9-]+;-;" | tr '-' '0' | cut -d ';' -f 4,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> lv_comp.csv
                    ;;
                *)
                    temp="lv_all.csv"
                    echo "Station lv: Capacity: Consumers (all) " > "$temp"
                    touch "$temp"
                    cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;-;[0-9-]+;[0-9]+;" | tr '-' '0' | cut -d ';' -f 4,7,8 | ./codeC/exec  >> "$temp"
                    awk -F ':' '{print $1 ":" $2 ":" $3 ":" ($3 - $2)}' "$temp" | sort -t ':' -k4 -n |  head -n 10 | cut -d ':' -f 1,2,3 > lv_all_minmax.csv
                    awk -F ':' '{print $1 ":" $2 ":" $3 ":" ($3 - $2)}' "$temp" | sort -t ':' -k4 -n |  tail -n 10 | cut -d ':' -f 1,2,3 >> lv_all_minmax.csv
                    
                                           
                    
                    ;;
            esac
            ;;
    esac
    END_SEC=$(date +%s)           # Time in seconds at the end
    END_NANO=$(date +%N)          # Nanoseconds at the end

    # Calculate the duration in seconds with correct precision
    DURATION_SEC=$((END_SEC - START_SEC))
    DURATION_NANO=$((END_NANO - START_NANO))

    # Adjust if the nanoseconds difference is negative (indicating the second has passed)
    if [ "$DURATION_NANO" -lt 0 ]; then
        DURATION_SEC=$((DURATION_SEC - 1))
        DURATION_NANO=$((DURATION_NANO + 1000000000))
    fi

    # Convert nanoseconds to seconds
    DURATION=$(echo "$DURATION_SEC + $DURATION_NANO / 1000000000" | bc)

    echo "Processing time: $DURATION seconds"

 
    
else
    START_SEC=$(date +%s)         # Time in seconds
    START_NANO=$(date +%N)        # Time in nanoseconds

    case "$STATION" in
            'hvb')
                touch "hvb_comp_$POWER.csv"
                echo "Station hvb: Capacity: Consumers (companies) " > hvb_comp_$POWER.csv
                cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;[0-9]+;-+;-;" | tr '-' '0' | cut -d ';' -f 2,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> hvb_comp_$POWER.csv
                ;;
            'hva')
                 touch "hva_comp_$POWER.csv"
                echo "Station hva: Capacity: Consumers (companies) " > hva_comp_$POWER.csv
                cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;[0-9-]+;[0-9]+;-;" | tr '-' '0' | cut -d ';' -f 3,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> hva_comp_$POWER.csv
                ;;
            *)
                case $CONSUMER in
                                'indiv')
                                    touch "lv_indiv_$POWER.csv"
                                    echo "Station lv: Capacity: Consumers (individuals) " > lv_indiv_$POWER.csv
                                    cat $FILEPATH | tail -n+2 | grep -E "^$POWER;-;[0-9-]+;[0-9]+;-;[0-9-]+" | tr - 0 | cut -d ';' -f 4,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> lv_indiv_$POWER.csv
                                    ;;
                                    'comp')
                                    touch "lv_comp_$POWER.csv"
                                    echo "Station lv: Capacity: Consumers (individuals) " > lv_comp_$POWER.csv # grep -E "^[0-9]+;-;[0-9-]+;[0-9]+;[0-9-]+;-;"
                                     cat $FILEPATH | tail -n+2 | grep -E "^$POWER;-;[0-9-]+;[0-9]+;[0-9-]+;-;" | tr - 0 | cut -d ';' -f 4,7,8 | ./codeC/exec |  sort -t ':' -k2 -n >> lv_comp_$POWER.csv
                                    ;;
                                *)
                                    var="lv_all_$POWER.csv"
                                    echo "Station lv: Capacity: Consumerss (all)) " > "$var"
                                    touch "$var" | mv "$var" temp
                                    cat $FILEPATH | tail -n+2 | grep -E "^$POWER;-;[0-9-]+;[0-9]+;"| tr - 0 | cut -d ';' -f 4,7,8 | ./codeC/exec>> "$var"
                                    awk -F ':' '{print $1 ":" $2 ":" $3 ":" ($3 - $2)}' "$var" | sort -t ':' -k4 -n |  head -n 10 | cut -d ':' -f 1,2,3 > lv_all_minmax_$POWER.csv
                                    awk -F ':' '{print $1 ":" $2 ":" $3 ":" ($3 - $2)}' "$var" | sort -t ':' -k4 -n |  tail -n 10 | cut -d ':' -f 1,2,3 >> lv_all_minmax_$POWER.csv
                                    ;;
                       esac
                
                ;;
    esac
    END_SEC=$(date +%s)           # Time in seconds at the end
    END_NANO=$(date +%N)          # Nanoseconds at the end

    # Calculate the duration in seconds with correct precision
    DURATION_SEC=$((END_SEC - START_SEC))
    DURATION_NANO=$((END_NANO - START_NANO))

    # Adjust if the nanoseconds difference is negative (indicating the second has passed)
    if [ "$DURATION_NANO" -lt 0 ]; then
        DURATION_SEC=$((DURATION_SEC - 1))
        DURATION_NANO=$((DURATION_NANO + 1000000000))
    fi

    # Convert nanoseconds to seconds
    DURATION=$(echo "$DURATION_SEC + $DURATION_NANO / 1000000000" | bc)

    echo "Processing time: $DURATION seconds"


fi

if [ $? -ne 0 ]; then
    echo "Processing failed. Useful time: 0.0 seconds"
fi

echo "You can find your sorted data in the program directory"
cd codeC
make clean
cd ..
