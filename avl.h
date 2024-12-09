/*Library*/
  #include <stdio.h>
  #include <stdlib.h>

  typedef struct _avl{
    int id;
    int load;
    int capacity;
    struct _tree* pLeft;
    struct _tree* pRight;
    int           balance;
} Tree;

/*Function TreeAVL*/
  Tree* createAVL(int v);
  Tree* rotateLeft(Tree* pRoot);
  Tree* rotateRight(Tree* pRoot);
  Tree* doublerotateLeft(Tree* pRoot);
  Tree* doublerotateRight(Tree* pRoot);
  Tree* balanceAVL(Tree* pRoot);
  Tree* insertAVL(Tree* pRoot);
  int searchAVL(Tree* pRoot, int v);
