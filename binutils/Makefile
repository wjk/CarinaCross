ifeq ($(PREFIX),)
 PREFIX ?= /usr/local
 $(warning $$(PREFIX) not specified, defaulting to /usr/local)
endif
ifeq ($(TARGET),)
 $(error $$(TARGET) must be specified)
endif

# This target must come first.
.PHONY : all
.DEFAULT_GOAL : all
all : as ld


libiberty/Makefile :
	cd libiberty && ./configure --prefix=$(PREFIX)

.libiberty.stamp : libiberty/Makefile
	make -C libiberty
	@touch .libiberty.stamp

opcodes/Makefile :
	cd opcodes && ./configure --prefix=$(PREFIX) --target=$(TARGET)

.libopcodes.stamp : opcodes/Makefile .libiberty.stamp
	make -C opcodes
	@touch .libopcodes.stamp

bfd/Makefile :
	cd bfd && ./configure --prefix=$(PREFIX) --target=$(TARGET)

.libbfd.stamp : bfd/Makefile
	make -C bfd
	@touch .libbfd.stamp

as/Makefile : .libopcodes.stamp
	cd as && ./configure --prefix=$(PREFIX) --target=$(TARGET)

.as.stamp : as/Makefile .libopcodes.stamp
	make -C as
	@touch .as.stamp

ld/Makefile :
	cd ld && ./configure --prefix=$(PREFIX) --target=$(TARGET)

.ld.stamp : ld/Makefile .libbfd.stamp
	make -C ld
	@touch .ld.stamp

.PHONY : ld as libbfd libopcodes libiberty
ld : .ld.stamp
as : .as.stamp
libbfd : .libbfd.stamp
libopcodes : .libopcodes.stamp
libiberty : .libiberty.stamp

.PHONY : install
install : as ld
	mkdir -p $(PREFIX)/bin
	install as/as-new $(PREFIX)/bin/$(TARGET)-as
	install ld/ld-new $(PREFIX)/bin/$(TARGET)-ld

.PHONY : clean
clean :
	-make -C libiberty clean
	-make -C libopcodes clean
	-make -C libbfd clean
	-make -C as clean
	-make -C ld clean
	rm -f .*.stamp
