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
    if (Computer
