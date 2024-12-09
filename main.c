#include "avl.h"
//finish with photo
int main(){
  int i,c,l; //v1 = id, v2 = capacity, v3= load
  int sum2 = 0;
  int sum3 = 0;
  int v1 = 0;
  while( scanf("%d,%d,%d\n", &i, &c, &l, ) == 3){
      if(v1 !=i){
        v1 = i;
      }
    
    
      AVL *pRoot = createAVL(i,c,l);
      if(pRoot == NULL){
        exit(1);      
      }
      while 
    
  }
  

  
  return 0;
}
