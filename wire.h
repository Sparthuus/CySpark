/*Library*/
  #include <stdio.h>
  #include <stdlib.h>
  #include <time.h>
/*Useful*/
  typedef struct _tree{
    int           value;
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
