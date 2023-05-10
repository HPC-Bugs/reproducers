# (Re)allocation on assignment to allocatable polymorphic variable from allocatable polymorphic function result

version: GNU Fortran (GCC) 13.1.1 20230429
OS: Arch Linux

## Additional Content

The included [file](./example.f90) is sufficient to demonstrate the issue.

## Steps to Reproduce

Compile the included [file](./example.f90) with gfortran and execute the resulting program.
Executing with gdb is necessary to identify the offending line.
I.e.

```text
$ gfortran -g example.f90
$ gdb ./a.out
GNU gdb (GDB) 13.1
Copyright (C) 2023 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./a.out...
(gdb) run
Starting program: /home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/gfortran/polymorphic-function-assignment/a.out

This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.archlinux.org>
Enable debuginfod for this session? (y or [n]) y
Debuginfod has been enabled.
To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
Downloading separate debug info for system-supplied DSO at 0x7ffff7fc8000
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x0000000000000000 in ?? ()
(gdb) bt
#0  0x0000000000000000 in ?? ()
#1  0x0000555555555358 in MAIN__ () at example.f90:9
```

## Workaround

Use explicit sourced allocation.
I.e. replace lines like

```fortran
a = func()
```

with

```fortran
if (allocated(a)) deallocate(a)
allocate(a, source = func())
```