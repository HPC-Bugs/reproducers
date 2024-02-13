# User Defined Operator on Associate Name

version: Cray Fortran : Version 17.0.0 (20231107223020_b59b7a8e9169719529cf5ab440f3c301e515d047)
system: perlmutter

## Additional Content

The included file, [./example.f90] illustrates the problem.

## Steps to Reproduce

This is triggered by trying to call a user defined operator on a name associated with a function/expression result.
The file `example.f90` does this, and so compiling and executing it produces a Segmentation Fault.
I.e.

```text
bprichar@perlmutter:login40:~/reproducers/tmp> module load PrgEnv-cray
bprichar@perlmutter:login40:~/reproducers/tmp> ftn -eDC example.f90 
ftn-1069 ftn: WARNING in command line
  The ipa optimization option is ignored, if the debugging level is 0.
bprichar@perlmutter:login40:~/reproducers/tmp> ./a.out 

lib-4968 : WARNING 
  An unallocated allocatable array 'STRING_' is referenced at
  at line 20 in file 'example.f90'.
Segmentation fault
```
