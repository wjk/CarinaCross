ifeq ($(TARGET),)
 TARGET ?= amd64-elf-linux
 export TARGET
 $(info note: $$(TARGET) defaults to amd64-elf-linux)
endif
ifeq ($(PREFIX),)
 PREFIX ?= /usr/local
 export PREFIX
 $(warning $$(PREFIX) not set, using /usr/local)
endif

.PHONY : all
.DEFAULT_GOAL : all
all : binutils

.PHONY : binutils
binutils : 
	make -C binutils all

.PHONY : install
install : 
	make -C binutils install
	mkdir -p $(PREFIX)/bin
	cp cross-gcc $(PREFIX)/bin/$(TARGET)-gcc
