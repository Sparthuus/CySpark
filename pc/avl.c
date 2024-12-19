#include "avl.h"

#include <stdlib.h>
#include <stdio.h>

AVL* createAVL(int i, int c, int l){ //Function to create AVL
    AVL* pNew = malloc(sizeof(AVL));
    if(pNew == NULL){
        exit(10);
    }
    pNew->load = l;
    pNew->id= i;
    pNew->capacity = c;
    pNew->pLeft  = NULL;
    pNew->pRight = NULL;
    pNew->balance= 0;
    return pNew;
}

int min2(int a, int b){
    return a < b ? a : b;
}
int max2(int a, int b){
    return a > b ? a : b;
}
int min3(int a, int b, int c){
    return min2(a, min2(b, c));
}
int max3(int a, int b, int c){
    return max2(a, max2(b, c));
}

AVL* rotateLeft(AVL* pRoot){
    if(pRoot==NULL || pRoot->pRight == NULL){
        exit(200);
    }
    AVL* pPivot  = pRoot->pRight;
    pRoot->pRight = pPivot->pLeft;
    pPivot->pLeft = pRoot;      // update balance values
    int eqa = pRoot->balance;        
    int eqp = pPivot->balance;        
    pRoot->balance  = eqa - max2(eqp, 0) - 1;
    pPivot->balance = min3(eqa-2, eqa+eqp-2, eqp-1); 
    pRoot = pPivot;
    return pRoot;
}

AVL* rotateRight(AVL* pRoot){
    if(pRoot==NULL || pRoot->pLeft == NULL){
        exit(201);
    }
    // update pointeurs
    AVL* pPivot  = pRoot->pLeft;
    pRoot->pLeft = pPivot->pRight;
    pPivot->pRight = pRoot;
    // update balance values
    int eqa = pRoot->balance;        
    int eqp = pPivot->balance;        
    pRoot->balance  = eqa - min2(eqp, 0) + 1;
    pPivot->balance = max3(eqa+2, eqa+eqp+2, eqp+1); 
    // return new root
    pRoot = pPivot;
    return pRoot;
}

AVL* doubleRotateLeft(AVL* pRoot){
    if(pRoot==NULL || pRoot->pRight == NULL){
        exit(202);
    }
    pRoot->pRight = rotateRight(pRoot->pRight);
    return rotateLeft(pRoot);
}

AVL* doubleRotateRight(AVL* pRoot){
    if(pRoot==NULL || pRoot->pLeft == NULL){
        exit(203);
    }
    pRoot->pLeft = rotateLeft(pRoot->pLeft);
    return rotateRight(pRoot);
}

AVL* balanceAVL(AVL* pRoot){
    if(pRoot == NULL){
        exit(205);
    }
    
    if(pRoot->balance >= 2){
        if(pRoot->pRight == NULL){
            exit(206);
        }
        if(pRoot->pRight->balance >= 0){
            // LEFT SIMPLE
            pRoot = rotateLeft(pRoot);
        }        
        else{
            // LEFT DOUBLE
            pRoot = doubleRotateLeft(pRoot);
        }        
    }
    else if(pRoot->balance <= -2){
        if(pRoot->pLeft == NULL){
            exit(207);
        }
        if(pRoot->pLeft->balance <= 0){
            // RIGHT SIMPLE
           pRoot = rotateRight(pRoot);
        }        
        else{
            // RIGHT DOUBLE
            pRoot = doubleRotateRight(pRoot);                        
        }
    }
    return pRoot;
}

int searchAVL(AVL* pRoot, int i){
    if(pRoot == NULL){
        return 0;
    }
    if(pRoot->id == i){
        return 1;
    }
    else if(i > pRoot->id){
        return searchAVL(pRoot->pRight, i);
    }
    else{
        return searchAVL(pRoot->pLeft, i);
    }
}

AVL* insertAVL(AVL* pRoot, int i, int c, int l, int *h){
    if(pRoot == NULL){
        // insert
        *h = 1;
        return createAVL(i, c, l);
    }    
    if (i < pRoot->id){
        pRoot->pLeft = insertAVL(pRoot->pLeft, i, c, l, h);
        *h = -*h;
    }
    else if(i > pRoot->id){
        pRoot->pRight = insertAVL(pRoot->pRight, i, c, l, h);
    }
    else{
        if (pRoot->capacity + c < 0){
            printf("Error : capacity value is negative.\n");
            exit(100);
        }
        pRoot->capacity += c;
        pRoot->load += l;
        *h = 0;
        return pRoot;
    }
    if (h !=0){
    pRoot->balance += *h;      // Update the balance
    pRoot = balanceAVL(pRoot);
    *h = (pRoot->balance == 0) ? 0 : 1; // Update the height change
    }
    return pRoot;
}

void infix(AVL* pRoot){ 
    if(pRoot != NULL){
        infix(pRoot->pLeft);
        printf("%d;%d;%d\n", pRoot->id, pRoot->capacity, pRoot->load);
        infix(pRoot->pRight);
    }
}

void freeAVL(AVL* pRoot){ 
 if(pRoot != NULL){
    freeAVL(pRoot->pLeft);
    freeAVL(pRoot->pRight);
    free(pRoot);
    }
}
