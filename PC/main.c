#include "avl.h"
#include "total.h"
#include "csv.h"


int main(){
  AVLNode *root = NULL;
  const char *filename = "data.csv";
  int stationType;    // Variable to store the station type to analyze

    // Load data from the CSV file
    printf("Loading data from the CSV file...\n");
    open_file(&root, filename);
    printf("Data successfully loaded!\n");

    // Ask for the station type to calculate the load sum
    printf("Enter the station type (ID) to calculate the total load: ");
    if (scanf("%d", &stationType) != 1) {
        printf("Error: Invalid input.\n");
        return 1;
    }

    // Calculate the total load
    int totalLoad = calculateLoadSum(root, stationType);
    printf("The total load for stations of type %d is: %d\n", stationType, totalLoad);

    // Display the AVL tree in order
    printf("Displaying the AVL tree in order:\n");
    infix(root);
    printf("Sum of consumption by type of station :\n");
 
  return 0;
}
