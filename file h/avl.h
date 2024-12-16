#ifndef avl_h
#define avl_h


  typedef struct _avl{
    int id;
    int load;
    int capacity;
    struct _avl* pLeft;
    struct _avl* pRight;
    int balance;
} AVL;

  AVL* createAVL(int i, int c, int l);
  AVL* rotateLeft(AVL* pRoot);
  AVL* rotateRight(AVL* pRoot);
  AVL* doublerotateLeft(AVL* pRoot);
  AVL* doublerotateRight(AVL* pRoot);
  AVL* balanceAVL(AVL* pRoot);
  AVL* insertAVL(AVL* pRoot, int i, int c, int l, int* h);
  int searchAVL(AVL* pRoot, int i);
  freeAVL(AVL* pRoot);

#endif
