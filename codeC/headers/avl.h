#ifndef AVL_H
#define AVL_H

typedef struct _avl {
    int id;
    long long load;
    long long capacity;
    struct _avl* pLeft;
    struct _avl* pRight;
    int balance;
} AVL;

AVL* createAVL(int i, long long c, long long l);
AVL* rotateLeft(AVL* pRoot);
AVL* rotateRight(AVL* pRoot);
AVL* doubleRotateLeft(AVL* pRoot);
AVL* doubleRotateRight(AVL* pRoot);
AVL* balanceAVL(AVL* pRoot);
int searchAVL(AVL* pRoot, int i);
AVL* insertAVL(AVL* pRoot, int i, long long c, long long l, int* h);
void infix(AVL* pRoot);
void freeAVL(AVL* pRoot);

#endif
