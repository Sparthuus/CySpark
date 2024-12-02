/*Library*/
  #include <stdio.h>
  #include <stdlib.h>
/*Useful*/
  typedef struct _tree{
    int           value;
    struct _tree* pLeft;
    struct _tree* pRight;
    int           balance;
} Tree;
