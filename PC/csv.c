#include <stdio.h>

void open_file(const AVL* pNew, const char* namefile){
  FILE* file = fopen(filename, "rb");
  if (fichier == NULL) {
        printf("Error when opening the File = %d\n", errno);
        exit(1);
    }
    AVL* pRoot = malloc(sizeof(AVL);
    fscanf(file, "%d; %d; %d; %d", pRoot->id, pRoot->capacity, pRoot->load);  
    fclose(file);
    
  return pRoot;
}
