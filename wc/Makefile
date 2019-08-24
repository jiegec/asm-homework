.PHONY: all
all: wc

wc: wc.o getline.o syscall.o
	ld $^ -o wc -g