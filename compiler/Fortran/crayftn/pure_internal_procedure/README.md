# Pure Interal Procedures

version: Cray Fortran : Version 16.0.1 (20230807191643_6d4824324d375100ba18ca639dfc956fe6546d06)
system: Perlmutter

## Additional Content

The included file is sufficient to demonstrate the issue.

## Steps to Reproduce

Attempt to compile the included file with crayftn to see the problem.
I.e.

```text
bprichar@muller:login01:~/Repositories/reproducers/compiler/Fortran/crayftn/pure_internal_procedure> ftn example.f90

module example_m
       ^
ftn-855 ftn: ERROR EXAMPLE_M, File = example.f90, Line = 1, Column = 8
  The compiler has detected errors in module "EXAMPLE_M".  No module information file will be created for this module.

        elemental function internal(x_) result(y_)
                           ^
ftn-1272 ftn: ERROR INTERNAL, File = example.f90, Line = 9, Column = 28
  "INTERNAL" is an internal subprogram to ELEMENTAL subprogram "FUNC".  It must be given the PURE or ELEMENTAL prefix-spec.

Cray Fortran : Version 16.0.1 (20230807191643_6d4824324d375100ba18ca639dfc956fe6546d06)
Cray Fortran : Compile time:  0.0027 seconds
Cray Fortran : 16 source lines
Cray Fortran : 2 errors, 0 warnings, 0 other messages, 0 ansi
Cray Fortran : "explain ftn-message number" gives more information about each message.
```
