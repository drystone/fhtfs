TARGET=fhtfs
LIBS=-lfuse -lpthread
CFLAGS=-g -Wall -O2 -I. -I/usr/include -D_FILE_OFFSET_BITS=64 -DFUSE_USE_VERSION=29

SOURCES=fhtfs.c
OBJECTS=$(patsubst %.c, %.o, $(SOURCES))
HEADERS=$(wildcard *.h)

.PHONY: default all clean install

default: $(TARGET)

all: default

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) $(LIBS) -o $@

%.o: %.c $(HEADERS)
	$(CC) -c $(CFLAGS) $<

install: all
	mkdir -p $(PREFIX)/bin
	cp -a $(TARGET) $(PREFIX)/bin/

clean:
	rm -f *.o $(TARGET) $(OBJECTS)
