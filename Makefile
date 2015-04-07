ifeq ($(TARGET),)
 TARGET ?= amd64-elf-linux
 $(info note: $$(TARGET) defaults to amd64-elf-linux)
endif
ifeq ($(PREFIX),)
 PREFIX ?= /usr/local
 $(warning $$(PREFIX) not set, using /usr/local)
endif
export TARGET
export PREFIX

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
