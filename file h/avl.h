/*Library*/
  #include <stdio.h>
  #include <stdlib.h>

  typedef struct _avl{
    int id;
    int load;
    int capacity;
    struct _avl* pLeft;
    struct _avl* pRight;
    int balance;
} AVL;

  AVL* createAVL(int i, long long c, long long l);
  AVL* rotateLeft(AVL* pRoot);
  AVL* rotateRight(AVL* pRoot);
  AVL* doublerotateLeft(AVL* pRoot);
  AVL* doublerotateRight(AVL* pRoot);
  AVL* balanceAVL(AVL* pRoot);
  AVL* insertAVL(AVL* pAVL, int i, long long c, long long l, int* h);
  int searchAVL(AVL* pAVL, int i, long long c, long long l);