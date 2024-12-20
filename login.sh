#!/bin/bash

speed=0.2
p="
  ██████╗██╗   ██╗    ███████╗██████╗  █████╗ ██████╗ ██╗  ██╗ 
 ██╔════╝╚██╗ ██╔╝    ██╔════╝██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝
 ██║      ╚████╔╝     ███████╗██████╔╝███████║██████╔╝█████╔╝ 
 ██║       ╚██╔╝      ╚════██║██╔═══╝ ██╔══██║██╔══██╗██╔═██╗ 
 ╚██████╗   ██║       ███████║██║     ██║  ██║██║  ██║██║  ██╗
  ╚═════╝   ╚═╝       ╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝"
                      
while true; in
           echo "$p"
           echo "                   █▒▒▒▒▒▒▒▒▒                    "
           sleep$speed
           clear 

           echo "$p"
           echo "                   ███▒▒▒▒▒▒▒                    "
           sleep$speed
           clear

           echo "$p"
           echo "                   ▒▒██▒▒▒▒▒▒                    " 
           sleep$speed
           clear   

           echo "$p"
           echo "                   ▒▒▒███▒▒▒▒                    "
           sleep$speed
           clear  

           echo "$p"
           echo "                   ▒▒▒▒▒███▒▒                    "
           sleep$speed
           clear

           echo "$p"
           echo "                   ▒▒▒▒▒▒▒███                    "
           sleep$speed
           clear
  esac
