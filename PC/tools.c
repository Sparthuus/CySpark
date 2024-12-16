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

void waiting_scene(){
    int i = rand() % 3;
    switch (i){
        case 1 :
            printf("Almost finish...\n");
            break
        case 2 :
            printf("Does the time has time for the time ?\n");
            break
        case 3 :
            printf("I think it's finish... right ?\n");
            break
    }
}

void finish(){
  printf(" Finish !\n");
}



  
