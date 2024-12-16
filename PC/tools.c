#include <stdio.h>
#include <stdlib.h>

void effacer(){
    //Clear terminal 
    printf("\033[2J\033[H");
}

void continue(){
    /*Fonction qui permet de faire une pause*/
    printf("\033[1;30mPress \033[4mEnter\033[0m \033[1;30mto continue\033[0m\n");
    #elif __linux__
        int ch;
        //initscr();
        //cbreak();
        //noecho();  
        while((ch=getch())!='\n'); 
        //endwin();         
    #endif
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

  
