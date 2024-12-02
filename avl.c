#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct _tree{
    int           value;
    struct _tree* pLeft;
    struct _tree* pRight;
} Tree;

Tree* createAVL(int v){
    Tree* pNew = malloc(sizeof(Tree));
    if(pNew == NULL){
        exit(10);
    }
    pNew->value  = v;
    pNew->pLeft  = NULL;
    pNew->pRight = NULL;
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
        printf("[%02d]", p->value);
        infix(p->pRight);
    }
}

void prefix(Tree* p){
    if(p!=NULL){
        printf("[%02d]", p->value);
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

int isBST_rec(Tree* p, int* pPrevious){
    if(p != NULL){
        // check left child
        if( isBST_rec(p->pLeft, pPrevious) ){
            // check current node value
            if( p->value < *pPrevious ){
                return 0;
            }
            // if correct until now...
            // ...update previous node value 
            *pPrevious = p->value;
            // check right child
            return isBST_rec(p->pRight, pPrevious);
        }
    }    
    else{
        return 1;
    }
}

int isBST(Tree* p){
    int value = -1;
    if(p == NULL){
        return 0;
    }
    else{    
        return isBST_rec(p, &value);
    }
}


int main(){

    Tree* pAVL = NULL;

    // set the seed value 
    srand(0);

    for(int i=0;i<15;i++){
        int v = rand()%100 + 1;
        printf("Insert %d \n", v);
        pAVL  = insertAVL(pAVL, v);
    }

    infix(pAVL);
    printf("\n");

    printf("root = [%02d] \n", pAVL->value);
    printf("%d\n", isBST(pAVL) );

    pAVL->value = 77;
    printf("root = [%02d] \n", pAVL->value);
    printf("%d\n", isBST(pAVL) );

    pAVL->value = 88;
    printf("root = [%02d] \n", pAVL->value);
    printf("%d\n", isBST(pAVL) );



/*
    printf("%d \n", searchAVL(pAVL, 36) );
    printf("%d \n", searchAVL(pAVL, 63) );
    printf("%d \n", searchAVL(pAVL, 44) );
*/
    
    
    
    return 0;
}














