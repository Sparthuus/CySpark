#!/bin/bash
# do in the terminal to execute chmod +x chrono_traitement.sh
# Check if a command was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <command to execute>"
    exit 1
fi

# Store the command to execute
COMMAND="$@"
echo
# Preparation phase
echo "Preparing resources..."
# Add any necessary commands for compilation or folder creation here
# For example:
# gcc -o program program.c
# mkdir -p output

echo "Data processing phase..."

# Measure only the processing phase
START=$(date +%s.%N)
$COMMAND
EXIT_STATUS=$?  # Capture the exit status of the command
END=$(date +%s.%N)

# Calculate the duration
if [ $EXIT_STATUS -eq 0 ]; then
    DURATION=$(echo "$END - $START" | bc)
else
    DURATION=0.0
fi

# Display the results
if [ $EXIT_STATUS -eq 0 ]; then
    echo
    echo "Processing completed successfully."
else
    echo "Processing failed (error in program or parameters)."
fi
echo
echo "Useful processing time: $DURATION seconds"
