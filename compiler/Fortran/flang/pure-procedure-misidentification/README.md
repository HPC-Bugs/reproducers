# Procedure pointer derived type components & misidentification of PURE module function

version: flang version 23.0.0git
system: HPE internal development server

## Additional Content

The included file, [./example.f90], illustrates the problem.

## Steps to Reproduce

Flang incorrectly diagnoses the result variable of a non-pure module
function as undefinable in a PURE subprogram. The function `construct`
cannot legally be PURE: F2018 C1590 requires that all dummy procedures
of a PURE subprogram be declared as PURE, but its dummy procedure argument
`test_function` has interface `test_function_i`, which is not declared PURE.

The false diagnosis appears to be triggered by `construct` being declared
in a structure constructor interface block (`INTERFACE type_t`).

See below:

```text
[reproducers/compiler/Fortran/crayftn/associated-func-call] $ flang -c example.f90 
error: Semantic errors in example.f90
example.f90:45:7: error: The left-hand side of a pointer assignment is not definable
        test_description%test_function_ => test_function
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
example.f90:17:52: Declaration of 'test_function_'
      procedure(test_function_i), pointer, nopass :: test_function_ => null()
                                                     ^^^^^^^^^^^^^^
example.f90:45:7: because: 'test_description' is externally visible via 'test_description' and not definable in a pure subprogram
        test_description%test_function_ => test_function
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
example.f90:28:20: Declaration of 'test_description'
        type(type_t) test_description
                     ^^^^^^^^^^^^^^^^
```
