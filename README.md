# ops-class
Here is a compiled and ever expanding list of tips, tricks, and tidbits relating to [OPS class](https://ops-class.org/).

### Building the os161 kernel
In your kernel directory (e.g. kern/compile/DUMBVM):
   * `bmake` - Generate kernel binary
   * `bmake install` - Install kernel to root directory

### GDB
#### Setting up
In order to get GDB going, you will need a running kernel. This means having a kernel on one window, and a free terminal for GDB itself.


In the kernel, you will need to have generated a panic. An easy way of doing is is running `panic`.


From here, you can run GDB: `os161-gdb kernel`


Everything else from here on is more centric on GDB itself. Useful GDB commands include (s)tep, (n)ext, (c)ontinue, (b)reak, (c)lear, (p)rint, and [more](https://in-addr.nl/mirror/GDB%20Cheat%20Sheet.pdf).