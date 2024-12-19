#include "avl.h"
#include <stdio.h>
#include <stdlib.h>

int calculateLoadSum(AVL* pRoot, int stationType) {
    if (pRoot == NULL) {
        return 0;
    }

    int sum = 0;

    // If ID correspond to the type of station specified
    if (pRoot->id == stationType) {
        sum += pRoot->load;
    }

    // Infix 
    sum += calculateLoadSum(pRoot->pLeft, stationType);
    sum += calculateLoadSum(pRoot->pRight, stationType);

    return sum;
}
