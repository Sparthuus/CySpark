#include "wire.h"

AVL* createAVL(ConsumerType a, int i, long long c){
    AVL* pNew = malloc(sizeof(AVL));
    if(pNew == NULL){
        exit(10);
    }
    pNew->ConsumerType = a;
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

int searchAVL(AVL* pAVL, int i, long long c){
    if(pAVL == NULL){
        return 0;
    }
    else if(pAVL->id == i){
        return 1;
    }
    else if(i > pAVL->id){
        return searchAVL(pAVL->pRight, i, c);
    }
    else{
        return searchAVL(pAVL->pLeft, i, c);
    }
}

AVL* insertAVL(AVL* pAVL, int i, long long c, int *h){
    if(pAVL == NULL){
        // insert
        *h = 1;
        return createAVL(ConsumerType a, int i, long long c);
    }    
    if (i < pAVL->id){
        pAVL->pLeft = insertAVL(pAVL->pLeft, i, c, h);
        *h = -*h;
    }
    else if(i > pAVL->id){
        pAVL->pRight = insertAVL(pAVL->pRight, i, c, h);
    }
    else{
        *h = 0:
        return pAVL;
    }
    return pAVL;
}

void infix(AVL* p){
    if(p!=NULL){
        infix(p->pLeft);
        printf("[%02d(%2d)]", p->value, p->balance);
        infix(p->pRight);
    }
}

int comsumption(){
    int result = 0;
    return result;
}

void result(){
    int comsumption();
    printf("The comsumption is %d", result);
}
