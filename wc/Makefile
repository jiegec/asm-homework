.PHONY: all
all: wc

wc: wc.o getline.o syscall.o putnum.o
	ld $^ -o wc -g
