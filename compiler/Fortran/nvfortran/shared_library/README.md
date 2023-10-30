# Shared Library Link Error

* Version: nvfortran 22.7-0 64-bit target on x86-64 Linux -tp zen3
* System: Perlmutter

## Additional Content

The included files, `example_mod.f90`, `example_prog.f90`, and the compile script `compile.sh`.

## Steps to reproduce

It's unclear all the conditions under which this can occur, but the following is what I've found so far.

* Have a named constant integer array defined in a module.
* Compile that module into a shared library (i.e. `*.so` file)
* Use that module and refer to the named constant in another Fortran file
* Attempt to link to the shared library directly

The attached Fortran source files and compile script will reproduce the error like below.

```text
bprichar@login34:~/Repositories/reproducers/compiler/Fortran/nvfortran/shared_library> module load PrgEnv-nvidia

Lmod is automatically replacing "gcc/11.2.0" with "nvidia/22.7".


Lmod is automatically replacing "PrgEnv-gnu/8.3.3" with "PrgEnv-nvidia/8.3.3".


Due to MODULEPATH changes, the following have been reloaded:
  1) cray-mpich/8.1.25

bprichar@login34:~/Repositories/reproducers/compiler/Fortran/nvfortran/shared_library> ./compile.sh
+ ftn -c -fPIC example_mod.f90 -o example_mod.o
+ ftn -shared -fPIC example_mod.o -o libexample.so
/usr/bin/ld: warning: /tmp/pgcudafatMnV7hYI_KuOBB.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
+ ftn -c -fPIC example_prog.f90 -o example_prog.o
+ ftn -fPIC example_prog.o libexample.so -o example_prog.exe
nvlink error   : Undefined reference to '_example_mod_21' in 'example_prog.o'
pgacclnk: child process exit status 2: /opt/nvidia/hpc_sdk/Linux_x86_64/22.7/compilers/bin/tools/nvdd
```
