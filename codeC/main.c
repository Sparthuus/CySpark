#include "avl.h"
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>


int main(){
  int id, c, l; //id, capacity, load/consumption
  int heightChanged = 0;  // To track height changes during AVL insertions
  
  AVL* pRoot = NULL;
      // Load data
     while(scanf("%d;%lld;%lld\n", &id, &c, &l) == 3){
      if (id < 0 || c < 0 || l < 0){
          printf("Incorrect values");
      }
      else {
        pRoot = insertAVL(pRoot, id, c, l, &heightChanged);
    	}
    } 
  
    infix(pRoot); // Display the AVL tree in order
    
    freeAVL(pRoot); //Free up memory
       
  return 0;
}
