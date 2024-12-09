#include "avl.h"

int main(){
  int i,c,l; //v1 = id, v2 = 
  int sum2 = 0;
  int sum3 = 0;
  while( scanf("%d,%d,%d\n", &i, &c, &l, ) == 3){
      AVL *pRoot = createAVL(i,c,l);
      if(pRoot == NULL){
        exit(1);      
      }

    
  }
  

  
  return 0;
}
