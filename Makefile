CC=gcc

CFLAGS = -std=c11 -Iinclude

LIBS = -lpthread

PC= pc/main.c pc/avl.c 

OBJ = $(SRC:.c=.o)

TARGET = Wire

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJ) $(TARGET)
