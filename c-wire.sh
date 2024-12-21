#!/bin/bash

# if to file hvb comp with diferant data make sur to move the first on your personal desktup ( add to read me)
clear
cd codeC
make
cd ..

bash codeShell/intro.sh
          

# Iterate over all the arguments passed to the script
for arg in "$@"; do
    # Check if the current argument matches "-h"
    if [[ "$arg" == "-h" ]]; then
        # Display the contents of the HelpShell.txt file to provide help information
        cat HelpShell.txt
        # Exit the script after displaying the help message
        exit 0
    fi
done



# Check if the number of arguments passed to the script is not 4 or 3
if [ $# -ne 4 ] && [ $# -ne 3 ]; then
    # Display an error message indicating an incorrect number of arguments
    echo "Bad number of arguments!"
    echo
    # Display the help file (HelpShell.txt) to guide the user
    cat HelpShell.txt
    echo
    # Exit the script with a status code of 1, indicating an error
    exit 1
fi

# Check if the directory 'input' does not exist
if ! [ -d input ] ; then
    # If 'input' does not exist, create it
    mkdir input
fi




# Check if the file specified by the first command-line argument ($1) does not exist
if ! [ -f "$1" ] ; then
    # If the file doesn't exist, print an error message
    echo "$1 does not exist !"
    # Print a blank line
    echo
    # Display the contents of the HelpShell.txt file for further instructions or information
    cat HelpShell.txt
    # Print another blank line
    echo
    # Exit the script with status code 2 to indicate an error
    exit 2
fi

# Check if the file 'exec' is not executable (or doesn't exist)
if ! [ -x "./codeC/exec" ]; then
    # If 'exec' is not executable or doesn't exist, print an error message
    echo "error exec doesn't exist !"
    echo
    cd codeC
    make
    cd ..
fi


# store directory

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
    # If STATION is not one of the valid types, print an error message
    echo "Error: station type must be one of: hva, hvb, lv"
    # Print a blank line
    echo
    # Exit the script with status code 4 to indicate an invalid station type
    exit 4
fi

# Check if the value of the CONSUMER variable is not "all", "indiv", or "comp"
if [ "$CONSUMER" != "all" ] && [ "$CONSUMER" != "indiv" ] && [ "$CONSUMER" != "comp" ]; then
    # If CONSUMER is not one of the valid types, print an error message
    echo "Error: consumer type must be one of: all, indiv, comp"
    # Print a blank line
    echo
    # Exit the script with status code 5 to indicate an invalid consumer type
    exit 5
fi

# Check if the STATION is "hva" and CONSUMER is either "indiv" or "all"
if [[ "$STATION" == "hva" && ( "$CONSUMER" == "indiv" || "$CONSUMER" == "all" ) ]]; then
    # If STATION is "hva" and CONSUMER is "indiv" or "all", print an error message
    echo "Error: you can't have hva AND indiv or all"
    # Print a blank line
    echo
    # Exit the script with status code 6 to indicate an invalid combination of parameters
    exit 6
fi

# Check if the STATION is "hvb" and CONSUMER is either "indiv" or "all"
if [[ "$STATION" == "hvb" && ( "$CONSUMER" == "indiv" || "$CONSUMER" == "all" ) ]]; then
    # If STATION is "hvb" and CONSUMER is "indiv" or "all", print an error message
    echo "Error: you can't have hvb AND indiv or all"
    # Print a blank line
    echo
    # Exit the script with status code 7 to indicate an invalid combination of parameters
    exit 7
fi

# Check if the variable POWER is set (non-empty) and its value is less than or equal to 0
if [ -n "$POWER" ] && [ $POWER -le 0 ] || [[ ! "$POWER" =~ ^[0-9]+$ ]]; then
    # If POWER is set and less than or equal to 0, print an error message
    echo "4th parameter is incorrect!"
    # Display the contents of HelpShell.txt for further instructions or help
    cat HelpShell.txt
    # Print a blank line
    echo
    # Exit the script with status code 8 to indicate an invalid POWER value
    exit 8
fi

# Print a blank line to separate the output
echo

# If all checks pass, print that all parameters are valid
echo "All parameters are valid."

cp $FILEPATH input

FILEPATH="input/$1"



# Check if no command-line arguments are provided (i.e., $# equals 0)
if [ $# -eq 0 ]; then
    # If no arguments are provided, print usage instructions
    echo "Usage: $0 <command to execute>"
    # Exit the script with status code 1 to indicate a missing argument
    exit 1
fi

if [ -z "$POWER" ]; then
   START_SEC=$(date +%s)         # Time in seconds
    START_NANO=$(date +%N)        # Time in nanoseconds
    
    case "$STATION" in
        'hvb')
            
            touch "hvb_comp.csv"
            echo "Station: hvb Capacité: Comsommateurs (entreprises) " > hvb_comp.csv
            cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;[0-9]+;-;-;" | tr '-' '0' | cut -d ';' -f 2,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> hvb_comp.csv
            ;;
        'hva')
            touch "hva_comp.csv"
            echo "Station: hva Capacité: Comsommateurs (entreprises) " > hva_comp.csv
            cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;[0-9-]+;[0-9]+;-;" | tr '-' '0' | cut -d ';' -f 3,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> hva_comp.csv
            ;;
        *)
            case $CONSUMER in
                indiv)
                    touch "lv_indiv.csv"
                    echo "Station: lv Capacité: Comsommateurs (individuel) " > lv_indiv.csv
                    cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;-;[0-9-]+;[0-9]+;-;[0-9-]+" | tr '-' '0' | cut -d ';' -f 4,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> lv_indiv.csv
                    ;;
                comp)
                    touch "lv_comp.csv"
                    echo "Station: lv Capacité: Comsommateurs (entreprises) " > lv_comp.csv
                    cat "$FILEPATH" | tail -n+2 | grep -E "^[0-9]+;-;[0-9-]+;[0-9]+;[0-9-]+;-;" | tr '-' '0' | cut -d ';' -f 4,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> lv_comp.csv
                    ;;
                *)
                    temp="lv_all.csv"
                    echo "Station: lv Capacité: Comsommateurs (tous) " > "$temp"
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
                echo "Station: hvb Capacité: Comsommateurs (entreprises) " > hvb_comp_$POWER.csv
                cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;[0-9]+;-+;-;" | tr '-' '0' | cut -d ';' -f 2,7,8 | ./codeC | sort -t ':' -k2 -n >> hvb_comp_$POWER.csv
                ;;
            'hva')
                 touch "hva_comp_$POWER.csv"
                echo "Station: hva Capacité: Comsommateurs (entreprises) " > hva_comp_$POWER.csv
                cat "$FILEPATH" | tail -n+2 | grep -E "^$POWER;[0-9-]+;[0-9]+;-;" | tr '-' '0' | cut -d ';' -f 3,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> hva_comp_$POWER.csv
                ;;
            *)
                case $CONSUMER in
                                'indiv')
                                    touch "lv_indiv_$POWER.csv"
                                    echo "Station: lv Capacité: Comsommateurs (individuels) " > lv_indiv_$POWER.csv
                                    cat $FILEPATH | tail -n+2 | grep -E "^$POWER;-;[0-9-]+;[0-9]+;-;[0-9-]+" | tr - 0 | cut -d ';' -f 4,7,8 | ./codeC/exec | sort -t ':' -k2 -n >> lv_indiv_$POWER.csv
                                    ;;
                                    'comp')
                                    touch "lv_comp_$POWER.csv"
                                    echo "Station: lv Capacité: Comsommateurs (individuels) " > lv_comp_$POWER.csv # grep -E "^[0-9]+;-;[0-9-]+;[0-9]+;[0-9-]+;-;"
                                     cat $FILEPATH | tail -n+2 | grep -E "^$POWER;-;[0-9-]+;[0-9]+;[0-9-]+;-;" | tr - 0 | cut -d ';' -f 4,7,8 | ./codeC/exec |  sort -t ':' -k2 -n >> lv_comp_$POWER.csv
                                    ;;
                                *)
                                    var="lv_all_$POWER.csv"
                                    echo "Station: lv Capacité: Comsommateurs (tous)) " > "$var"
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
