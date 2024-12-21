CC = gcc

CF = -std=c11 -Iheaders

PC = pc/main.c pc/avl.c 
OBJ = $(PC:.c=.o)

TARGET = exec

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CF) -o $@ $^ 

%.o: %.c
	$(CC) $(CF) -c -o $@ $<

clean:
	@echo "Cleaning..."
	rm -f $(OBJ) $(TARGET)
	@echo "Clean completed"


