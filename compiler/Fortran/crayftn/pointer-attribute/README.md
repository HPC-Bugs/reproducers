# Argument that has pointer attribute causes a compile-time error about needing pointer attribute

version: Cray Fortran : Version 17.0.0
system: NERSC perlmutter

## Additional Content

The included file, [./example.f90], illustrates the problem.

## Steps to Reproduce

This is triggered when there is a procedure argument to a derived type user defined constructor
that has the pointer attribute. If the interface for the constructor is in a module and if
the definition is in a submodule, then a compiler error occurs which says that the procedure
argument needs the pointer attribute, even though it already has it.

See below:

```text
~/hpc-bugs-reproducers/compiler/Fortran/crayftn/pointer-attribute> ftn -c example.f90 

submodule(pointer_attribute_bug_m) pointer_attribute_bug_s
          ^                                                
ftn-1800 ftn: ERROR CONSTRUCT, File = example.f90, Line = 32, Column = 11 
  Procedure "TEST_FUNCTION" has the INTENT attribute, so it must be a procedure pointer.  Add the POINTER attribute.
```

## Workaround

Move the definition of the constructor into the module.
The included file, [./workaround.f90], illustrates the workaround.
