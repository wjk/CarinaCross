# CarinaCross

This is a small program I wrote to ease the creation of
cross-compilers for Linux and other platforms. It uses the
built-in cross-compilation functionality in `clang`, and includes
a copy of GNU Binutils `as` and `ld`, as well as a Ruby script that
ties everything together.

To build CarinaCross, just `cd` into this directory and run
`make install`. You can specify the target triple to use by passing
the `TARGET=` parameter to `make`, and the installation directory
by using `PREFIX=`. These values default to `amd64-elf-linux` and
`/usr/local`, respectively.
