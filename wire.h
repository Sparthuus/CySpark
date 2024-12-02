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
