#include <stdio.h>
#include <stdlib.h>

//Function to clear terminal 
void clear(){
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
    int i = 1 + rand() % 3;
    switch (i){
        case 1 :
            printf("Almost finished...\n");
            break;
        case 2 :
            printf("Does time has time for time ?\n");
            break;
        case 3 :
            printf("I think it's finished... right ?\n");
            break;
    }
}

void finish(){
  printf(" Finished !\n");
}



  
