#include "avl.h"
#include "tools.h"
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>


int main(){
  intro();
  int id, c, l; //id, capacity, load
  int heightChanged = 0;  // To track height changes during AVL insertions
  
  AVL* pRoot = NULL;
      // Load data from the terminal
  printf("Loading data from the terminal...\n");
    while(scanf("%d;%d;%d\n", &id, &c, &l) == 3){
      if (id < 0 || c < 0 || l < 0){
          printf("Incorrect values");
      }
      else {
        pRoot = insertAVL(pRoot, id, c, l, &heightChanged);
    	}
    } 
    
    infix(pRoot); // Display the AVL tree in order
    
    freeAVL(pRoot);
       
  return 0;
}
