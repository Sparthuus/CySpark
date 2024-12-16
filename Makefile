CC=gcc

CF = -std=c11 -Iinclude

LIB = -lpthread

PC= pc/main.c pc/avl.c pc/total.c pc/waiting.c \

OBJ = $(SRC:.c=.o)

TARGET = Wire

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CF) -o $@ $^ $(LIB)

%.o: %.c
	$(CC) $(CF) -c -o $@ $<

clean:
	rm -f $(OBJ) $(TARGET)
