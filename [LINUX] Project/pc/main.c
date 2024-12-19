#include "avl.h"
#include "total.h"
#include "csv.h"
#include "tools.h"
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>


int main(){
  intro();
  int v1, v2, v3;
  int stationType;
  int totalLoad;
  int heightChanged = 0;  // To track height changes during AVL insertions
  
  AVL* pRoot = NULL;
      // Load data from the terminal
  printf("Loading data from the terminal...\n");
    while(scanf("%d %d %d", &v1, &v2, &v3) == 3){
      if (v1 < 0 || v2 < 0 || v3 < 0){
          printf("Doesnt work");
      }
      else {
        pRoot = insertAVL(pRoot, v1, v2, v3, &heightChanged);
    	}
    } 
    printf("Displaying the AVL tree in order:\n");
    infix(pRoot); // Display the AVL tree in order
    finish();
      
    freeAVL(pRoot);
    int totalload = calculateLoadSum(pRoot, stationType);
   
    printf("The total load for stations of type %d is: %d\n", stationType, totalLoad);
     
    printf("Sum of consumption by type of station :\n");
   
  return 0;
}