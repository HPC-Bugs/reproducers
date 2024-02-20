# Call Type-Bound Procedure on Associate Name

version: Cray Fortran : Version 17.0.0 (20231107223020_b59b7a8e9169719529cf5ab440f3c301e515d047)
system: perlmutter

## Additional Content

The included file, [./example.f90] illustrates the problem.

## Steps to Reproduce

This is triggered by trying to call a type-bound procedure on a name associated with a function/expression result.
The file `example.f90` does this, and so compiling it elicits an error message from the compiler.
I.e.

```text
bprichar@perlmutter:login40:~/reproducers/tmp> module load PrgEnv-cray
bprichar@perlmutter:login40:~/reproducers/tmp> ftn example.f90

    call stuff%do_something()
         ^                    
ftn-113 ftn: ERROR SELECTOR_TBP_INVOCATION, File = example.f90, Line = 17, Column = 10 
  IMPLICIT NONE is specified in the local scope, therefore an explicit type must be specified for data object "STUFF".
```