ifeq ($(PREFIX),)
 PREFIX ?= /usr/local
 $(warning $$(PREFIX) not specified, defaulting to /usr/local)
endif
ifeq ($(TARGET),)
 $(error $$(TARGET) must be specified)
endif

libiberty/Makefile :
	cd libiberty && ./configure --prefix=$(PREFIX)

.libiberty.stamp : libiberty/Makefile
	make -C libiberty
	@touch .libiberty.stamp

libopcodes/Makefile :
	cd libopcodes && ./configure --prefix=$(PREFIX)

.libopcodes.stamp : libopcodes/Makefile .libiberty.stamp
	make -C libopcodes
	@touch .libopcodes.stamp

libbfd/Makefile :
	cd libbfd && ./configure --prefix=$(PREFIX) --target=$(TARGET)

.libbfd.stamp : libbfd/Makefile .libopcodes.stamp
	make -C libbfd
	@touch .libbfd.stamp

as/Makefile : libbfd/compile.stamp
	cd as && ./configure --prefix=$(PREFIX) --target=$(TARGET)

.as.stamp : as/Makefile .libbfd.stamp
	make -C as
	@touch .as.stamp

ld/Makefile :
	cd ld && ./configure --prefix=$(PREFIX) --target=$(TARGET)

.ld.stamp : ld/Makefile .libbfd.stamp
	make -C ld
	@touch .ld.stamp

.PHONY : ld as libbfd libopcodes libiberty
ld : ld/compile.stamp
as : as/compile.stamp
libbfd : libbfd/compile.stamp
libopcodes : libopcodes/compile.stamp
libiberty : libiberty/compile.stamp

.PHONY : clean
clean :
	-make -C libiberty clean
	-make -C libopcodes clean
	-make -C libbfd clean
	-make -C as clean
	-make -C ld clean
	rm -f .*.stamp

.PHONY : all
.DEFAULT_GOAL : all
all : as ld
