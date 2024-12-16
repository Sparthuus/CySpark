#include <stdio.h>
#include <stdlib.h>

void clear(){
    //Clear terminal 
    printf("\033[2J\033[H");
}
void intro(){
  printf("  ██████╗██╗   ██╗    ███████╗██████╗ ███████╗\n"
         " ██╔════╝╚██╗ ██╔╝    ██╔════╝██╔══██╗██╔════╝\n"
         " ██║      ╚████╔╝     █████╗  ██║  ██║█████╗\n"  
         " ██║       ╚██╔╝      ██╔══╝  ██║  ██║██╔══╝\n"  
         " ╚██████╗   ██║       ███████╗██████╔╝██║\n"     
         "  ╚═════╝   ╚═╝       ╚══════╝╚═════╝ ╚═╝\n");
  printf("\nWelcome to our programm Cy EDF !\n"
         " Please wait patiently\n");
}
                                                  
void finish(){
  printf(" Finish !\n");
}

  
