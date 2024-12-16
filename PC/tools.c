#include <stdio.h>
#include <stdlib.h>

void effacer(){
    //Clear terminal 
    printf("\033[2J\033[H");
}

void continue(){
    //to make a break
    printf("\033[1;30mPress \033[4mEnter\033[0m \033[1;30mto continue\033[0m\n");
    while((ch=getch())!='\n'); 
       
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
  effacer();
  printf(" Finish !\n");
  continue();
}

  
