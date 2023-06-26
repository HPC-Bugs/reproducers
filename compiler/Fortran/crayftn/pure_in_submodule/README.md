# Pure Procedures Defined in Submodule

version: Cray Fortran : Version 15.0.1 (20230120205242_66f7391d6a03cf932f321b9f6b1d8612ef5f362c)
system: Perlmutter

## Additional Content

The included files, [./example_m.f90] and [./example_s.f90] are sufficient to demonstrate the issue.

## Steps to Reproduce

It seems this is triggered by a generic interface block declaring the interfaces to two specific procedures.
The procedures are then defined in a submodule, where one calls the other through the generic interface.
The two included files exhibit this pattern, so attempt to compile the included files with crayftn to see the problem.
I.e.

```text
bprichar@perlmutter:login14:~/reproducers/cray_submodule_pure> module load PrgEnv-cray
bprichar@perlmutter:login14:~/reproducers/cray_submodule_pure> ftn -c example_m.f90
bprichar@perlmutter:login14:~/reproducers/cray_submodule_pure> ftn -c example_s.f90

submodule(example_m) example_s
          ^
ftn-1624 ftn: ERROR FOO_A, File = example_s.f90, Line = 1, Column = 11
  "FOO_B" is also defined at line 8 (example_s.f90).  The PURE attribute is specified in only one of the definitions.  It should be in both.

Cray Fortran : Version 15.0.1 (20230120205242_66f7391d6a03cf932f321b9f6b1d8612ef5f362c)
Cray Fortran : Compile time:  0.0022 seconds
Cray Fortran : 11 source lines
Cray Fortran : 1 errors, 0 warnings, 0 other messages, 0 ansi
Cray Fortran : "explain ftn-message number" gives more information about each message.
```