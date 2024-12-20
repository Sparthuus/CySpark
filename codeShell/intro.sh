#!/bin/bash

speed=0.2
p="
  ██████╗██╗   ██╗    ███████╗██████╗  █████╗ ██████╗ ██╗  ██╗ 
 ██╔════╝╚██╗ ██╔╝    ██╔════╝██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝
 ██║      ╚████╔╝     ███████╗██████╔╝███████║██████╔╝█████╔╝ 
 ██║       ╚██╔╝      ╚════██║██╔═══╝ ██╔══██║██╔══██╗██╔═██╗ 
 ╚██████╗   ██║       ███████║██║     ██║  ██║██║  ██║██║  ██╗
  ╚═════╝   ╚═╝       ╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝"
                      
for i in {1..2}; do

           echo "$p"
           echo "                   	   █▒▒▒▒▒▒▒▒▒                    "
           sleep $speed
           clear 

           echo "$p"
           echo "                   	   ███▒▒▒▒▒▒▒                    "
           sleep $speed
           clear

           echo "$p"
           echo "                   	   ▒▒██▒▒▒▒▒▒                    " 
           sleep $speed
           clear   

           echo "$p"
           echo "                   	   ▒▒▒███▒▒▒▒                    "
           sleep $speed
           clear  

           echo "$p"
           echo "                   	   ▒▒▒▒▒███▒▒                    "
           sleep $speed
           clear

           echo "$p"
           echo "                   	   ▒▒▒▒▒▒▒███                    "
           sleep $speed
           clear
   done
   echo "$p"
