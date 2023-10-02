# Allocatable Access

version: ifx (IFX) 2023.2.0 20230622
OS: Arch Linux

## Additional Content

The included [file](./example.f90) is sufficient to demonstrate the issue.

## Steps to Reproduce

Compile the included [file](./example.f90) with ifx with address sanitizer turned on and execute the resulting program.
I.e.

```text
$ ifx -check uninit -g -O0 example.f90
$ ./a.out
           1
Uninitialized bytes in __interceptor_write at offset 0 inside [0x725000000000, 13)
==181450==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x4a8b07 in for__write_output (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x4a8b07) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #1 0x4a987e in for__put_sf (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x4a987e) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #2 0x493991 in for_write_seq_lis_xmit (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x493991) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #3 0x48fbb2 in for_write_seq_lis (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x48fbb2) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #4 0x488e58 in MAIN__ /home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/example.f90:5:5
    #5 0x40a578 in main (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x40a578) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #6 0x7fb0e505fccf  (/usr/lib/libc.so.6+0x27ccf) (BuildId: 023ea16fd6c04ef9cf094507024e6ecdb35e02ca)
    #7 0x7fb0e505fd89 in __libc_start_main (/usr/lib/libc.so.6+0x27d89) (BuildId: 023ea16fd6c04ef9cf094507024e6ecdb35e02ca)
    #8 0x40a444 in _start (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x40a444) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)

  Uninitialized value was created by a heap allocation
    #0 0x416d36 in __interceptor_malloc /netbatch/donb00013_00/dir/workspace/NIT/xmain-rel/LX/xmainefi2linux_release/ws/icsws/llvm/compiler-rt/lib/msan/msan_interceptors.cpp:933:3
    #1 0x48d732 in for__get_vm (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x48d732) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #2 0x4b8609 in for__open_proc (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x4b8609) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #3 0x4a700a in for__open_default (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x4a700a) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #4 0x48f663 in for_write_seq_lis (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x48f663) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #5 0x488e58 in MAIN__ /home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/example.f90:5:5
    #6 0x40a578 in main (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x40a578) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1)
    #7 0x7fb0e505fccf  (/usr/lib/libc.so.6+0x27ccf) (BuildId: 023ea16fd6c04ef9cf094507024e6ecdb35e02ca)

SUMMARY: MemorySanitizer: use-of-uninitialized-value (/home/brad/Repositories/GitHub/BerkeleyLab/reproducers/compiler/Fortran/ifx/allocatable-array/a.out+0x4a8b07) (BuildId: cf2ae6e962ef133afe9e88441202948e168965a1) in for__write_output
Exiting
```
