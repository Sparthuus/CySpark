#include <stdio.h>

void open_file(const AVL* pNew, const char* filename){
  FILE* file = fopen(filename, "r+");
  if (file == NULL) {
        printf("Error when opening the File = %d\n", strerron(errno));
        exit(1);
    }
    int id, capacity, load;
    int height_change = 0 ;
    while (fscanf(file, "%d; %d; %d; %d", &id, &capacity, &load)== 3) {
      *pRoot = insertAVL(*pRoot, id, capacity, load, &height_change); 
    }
    fclose(file);
    printf("File successfully loaded into AVL tree\n");
    
}
