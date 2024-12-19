CC = gcc

CF = -std=c11 -Iheaders

PC = pc/main.c pc/avl.c pc/tools.c 
OBJ = $(PC:.c=.o)

TARGET = SPARK

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CF) -o $@ $^ 

%.o: %.c
	$(CC) $(CF) -c -o $@ $<

clean:
	@echo "Cleaning..."
	rm -f $(OBJ) $(TARGET)
	@echo "Clean completed"


