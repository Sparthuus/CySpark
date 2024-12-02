#include "wire.h"

Tree* createAVL(int v){
    Tree* pNew = malloc(sizeof(Tree));
    if(pNew == NULL){
        exit(10);
    }
    pNew->value  = v;
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

Tree* rotateLeft(Tree* pRoot){
    if(pRoot==NULL || pRoot->pRight == NULL){
        exit(200);
    }
    // update pointeurs
    Tree* pPivot  = pRoot->pRight;
    pRoot->pRight = pPivot->pLeft;
    pPivot->pLeft = pRoot;
    // update balance values
    int eqa = pRoot->balance;        
    int eqp = pPivot->balance;        
    pRoot->balance  = eqa - max2(eqp, 0) - 1;
    pPivot->balance = min3(eqa-2, eqa+eqp-2, eqp-1); 
    // return new root
    pRoot = pPivot;
    return pRoot;
}
Tree* rotateRight(Tree* pRoot){
    if(pRoot==NULL || pRoot->pLeft == NULL){
        exit(201);
    }
    // update pointeurs
    Tree* pPivot  = pRoot->pLeft;
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

Tree* doubleRotateLeft(Tree* pRoot){
    if(pRoot==NULL || pRoot->pRight == NULL){
        exit(202);
    }
    pRoot->pRight = rotateRight(pRoot->pRight);
    return rotateLeft(pRoot);
}
Tree* doubleRotateRight(Tree* pRoot){
    if(pRoot==NULL || pRoot->pLeft == NULL){
        exit(203);
    }
    pRoot->pLeft = rotateLeft(pRoot->pLeft);
    return rotateRight(pRoot);
}
Tree* balanceAVL(Tree* pRoot){
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
            pRoot = rotateLeft(pRoot);
        }        
        else{
            // RIGHT DOUBLE
            pRoot = doubleRotateRight(pRoot);                        
        }
    }
    return pRoot;
}



Tree* createAVL(int v){
    Tree* pNew = malloc(sizeof(Tree));
    if(pNew == NULL){
        exit(10);
    }
    pNew->value  = v;
    pNew->pLeft  = NULL;
    pNew->pRight = NULL;
    pNew->balance= 0;
    return pNew;
}

int searchAVL(Tree* pTree, int v){
    if(pTree == NULL){
        return 0;
    }
    else if(pTree->value == v){
        return 1;
    }
    else if(v > pTree->value){
        return searchAVL(pTree->pRight, v);
    }
    else{
        return searchAVL(pTree->pLeft, v);
    }
}

Tree* insertAVL(Tree* pTree, int v){
    if(pTree == NULL){
        // insert
        pTree = createAVL(v);
        if(pTree == NULL){
            exit(15);
        }
    }    
    else if(v < pTree->value){
        pTree->pLeft = insertAVL(pTree->pLeft, v);
    }
    else if(v > pTree->value){
        pTree->pRight = insertAVL(pTree->pRight, v);
    }
    else{
        // do nothing when duplicated !!
    }
    return pTree;
}

void infix(Tree* p){
    if(p!=NULL){
        infix(p->pLeft);
        printf("[%02d(%2d)]", p->value, p->balance);
        infix(p->pRight);
    }
}

void prefix(Tree* p){
    if(p!=NULL){
        printf("[%02d(%2d)]", p->value, p->balance);
        prefix(p->pLeft);
        prefix(p->pRight);
    }
}

Tree* suppMax(Tree* pTree, int* pValue ){
    if(pTree == NULL || pValue == NULL){
        exit(100);
    }
    if(pTree->pRight != NULL){
        pTree->pRight = suppMax(pTree->pRight, pValue);
    }
    else{
        // Store address to free
        Tree* pRemove = pTree;
        // exchange number values
        *pValue = pTree->value;
        // link left child
        pTree = pTree->pLeft;
        // free
        free(pRemove);
    }
    return pTree;
}

Tree* removeAVL(Tree* pTree, int v){
    if(pTree != NULL){
        if(v < pTree->value){
            pTree->pLeft = removeAVL(pTree->pLeft, v);
        }
        else if(v > pTree->value){
            pTree->pRight = removeAVL(pTree->pRight, v);
        }
        else{
            if(pTree->pLeft != NULL && pTree->pRight != NULL){
                // suppmin / suppmax
                pTree->pLeft = suppMax(pTree->pLeft, &(pTree->value) );
            }
            else{
                // remove directly                
                // send child back
                Tree* pChild = pTree->pLeft;
                if(pChild == NULL){
                    pChild = pTree->pRight;
                }
                free(pTree);
                pTree = pChild;
            }
        }    
    }
    return pTree;
}


int main(){

    Tree* pAVL1 = NULL;
    Tree* pAVL2 = NULL;

    // set the seed value 
    srand(0);

    pAVL1 = insertAVL(pAVL1, 1);
    pAVL1 = insertAVL(pAVL1, 2);
    pAVL1 = insertAVL(pAVL1, 3);

    pAVL1 = rotateLeft(pAVL1);

    pAVL2 = insertAVL(pAVL2, 3);
    pAVL2 = insertAVL(pAVL2, 2);
    pAVL2 = insertAVL(pAVL2, 1);

    pAVL2 = rotateRight(pAVL2);


    printf("INFIX1 : ");
    infix(pAVL1);
    printf("\n");

    printf("PREFIX1 : ");
    prefix(pAVL1);
    printf("\n");

    printf("INFIX2 : ");
    infix(pAVL2);
    printf("\n");

    printf("PREFIX2 : ");
    prefix(pAVL2);
    printf("\n");


    
    
    
    return 0;
}













