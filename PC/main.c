#include "avl.h"
#include "total.h"
#include "csv.h"
#include "tools.h"


int main(){
  intro();
      // Load data from the terminal
    printf("Loading data from the terminal...\n");
    int v1, v2, v3;
    AVL* pRoot = NULL;
    while(scanf("%d %d %d", &v1, &v2, &v3) == 3){
      if (v1 == 0){
          printf("Doesnt work");
      }
      else {
        pRoot = insertAVL();
    }
    printf("Displaying the AVL tree in order:\n");
    infix(pRoot); // Display the AVL tree in order
    finish();
    freeAVL(pRoot);
    int totalload = calculateLoadSum(pRoot, stationType);
   
    printf("The total load for stations of type %d is: %d\n", stationType, totalLoad);
     
    printf("Sum of consumption by type of station :\n");
    /*
    AVLNode *root = NULL;
    const char *filename = "data.csv";
    int stationType;    // Variable to store the station type to analyze
    
    open_file(&root, filename);
    clear();
    intro();
    printf("Data successfully loaded!\n");

    // Ask for the station type to calculate the load sum
    printf("Enter the station type (ID) to calculate the total load: ");
    if (scanf("%d", &stationType) != 1) {
        printf("Error: Invalid input.\n");
        return 1;
    }

    // Calculate the total load
    int totalLoad = calculateLoadSum(root, stationType);
    finish();
    printf("The total load for stations of type %d is: %d\n", stationType, totalLoad);

    // Display the AVL tree in order
    printf("Displaying the AVL tree in order:\n");
    infix(root);
    printf("Sum of consumption by type of station :\n");
    */
 
  return 0;
}
