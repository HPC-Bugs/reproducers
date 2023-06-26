# Structure Constructor Reference Without Argument for Allocatable Component

* Version: nvfortran 22.7-0 64-bit target on x86-64 Linux -tp zen3-64
* System: Perlmutter

## Additional Content

The included file, [./example.f90], demonstrates the issue.

## Steps to reproduce

This seems to just be a misunderstanding of the standard, that allocatable components are not required arguments to the intrinsic structure constructor.
Compiling the included file with nvfortran reports the following:

```text
bprichar@perlmutter:login15:~/reproducers/allocatable-component-default> ml PrgEnv-nvidia

Lmod is automatically replacing "gcc/11.2.0" with "nvidia/22.7".


Lmod is automatically replacing "PrgEnv-gnu/8.3.3" with "PrgEnv-nvidia/8.3.3".


Due to MODULEPATH changes, the following have been reloaded:
  1) cray-mpich/8.1.25

bprichar@perlmutter:login15:~/reproducers/allocatable-component-default> ftn example.f90
NVFORTRAN-F-0155-No default initialization in structure constructor- member a (example.f90: 10)
NVFORTRAN/x86-64 Linux 22.7-0: compilation aborted
```