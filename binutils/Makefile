ifeq ($(PREFIX),)
 PREFIX ?= /usr/local
 $(warning $$(PREFIX) not specified, defaulting to /usr/local)
endif
ifeq ($(TARGET),)
 $(error $$(TARGET) must be specified)
endif

libiberty/Makefile : 
	cd libiberty && ./configure --prefix=$(PREFIX)

libiberty/compile.stamp : libiberty/Makefile
	make -C libiberty
	@touch libiberty/compile.stamp

libopcodes/Makefile : 
	cd libopcodes && ./configure --prefix=$(PREFIX)

libopcodes/compile.stamp : libopcodes/Makefile libiberty/compile.stamp
	make -C libopcodes
	@touch libopcodes/compile.stamp

libbfd/Makefile : 
	cd libbfd && ./configure --prefix=$(PREFIX) --target=$(TARGET)

libbfd/compile.stamp : libbfd/Makefile libopcodes/compile.stamp
	make -C libbfd
	@touch libbfd/compile.stamp

as/Makefile : libbfd/compile.stamp
	cd as && ./configure --prefix=$(PREFIX) --target=$(TARGET)

as/compile.stamp : as/Makefile libbfd/compile.stamp
	make -C as
	@touch as/compile.stamp

ld/Makefile : 
	cd ld && ./configure --prefix=$(PREFIX) --target=$(TARGET)

ld/compile.stamp : ld/Makefile libbfd/compile.stamp
	make -C ld
	@touch ld/compile.stamp

.PHONY : ld as libbfd libopcodes libiberty
ld : ld/compile.stamp
as : as/compile.stamp
libbfd : libbfd/compile.stamp
libopcodes : libopcodes/compile.stamp
libiberty : libiberty/compile.stamp

.PHONY : clean
clean : 
	-make -C libiberty clean
	-rm libiberty/compile.stamp
	-make -C libopcodes clean
	-rm libopcodes/compile.stamp
	-make -C libbfd clean
	-rm libbfd/compile.stamp
	-make -C as clean
	-rm as/compile.stamp
	-make -C ld clean
	-rm ld/compile.stamp

.PHONY : all
.DEFAULT_GOAL : all
all : as ld
