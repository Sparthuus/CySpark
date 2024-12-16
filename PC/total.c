#include "avl.h"
#include <stdio.h>
#include <stdlib.h>

int calculateLoadSum(AVL* pRoot, int stationType) {
    if (pRoot == NULL) {
        return 0;
    }

    int sum = 0;

    // Filtre : si l'ID correspond au type de station spécifié
    if (pRoot->id == stationType) {
        sum += pRoot->load;
    }

    // Parcours récursif (infix)
    sum += calculateLoadSum(pRoot->pLeft, stationType);
    sum += calculateLoadSum(pRoot->pRight, stationType);

    return sum;
}
