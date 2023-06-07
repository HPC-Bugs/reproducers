# Unlimited Polymorphic Assumed Rank Argument

version: Cray Fortran : Version 15.0.1 (20230120205242_66f7391d6a03cf932f321b9f6b1d8612ef5f362c)
system: perlmutter

## Additional Content

The included files, [./combined.f90], [./inverted.f90], [./known_rank.f90], and [./known_type.f90] illustrate the issue and that both features together are required to elicit the bug.

## Steps to Reproduce

This is triggered by trying to use the `select type` and `select rank` constructs together in order to make use of an unlimited polymorphic assumed rank argument.
The two files `combined.f90` and `inverted.f90` do this, and so compiling either of them elicits an error message from the compiler (slightly different from each other).
I.e.

```text
bprichar@perlmutter:login22:~/reproducers/cray_select_rank_and_type> module load PrgEnv-cray
bprichar@perlmutter:login22:~/reproducers/cray_select_rank_and_type> ftn combined.f90

module a
       ^
ftn-855 ftn: ERROR A, File = combined.f90, Line = 1, Column = 8
  The compiler has detected errors in module "A".  No module information file will be created for this module.

    select type (x)
                 ^
ftn-620 ftn: ERROR FOO, File = combined.f90, Line = 5, Column = 18
  This reference to assumed-rank variable "X" is not valid.

      select rank (x)
                   ^
ftn-393 ftn: ERROR FOO, File = combined.f90, Line = 7, Column = 20
  An array reference with parentheses must have at least one subscript.
                   ^
ftn-1543 ftn: ERROR FOO, File = combined.f90, Line = 7, Column = 20
  The selector in a SELECT RANK statement must be an assumed-rank array.

  use a, only: foo
      ^
ftn-894 ftn: ERROR MAIN, File = combined.f90, Line = 15, Column = 7
  Module "A" has compile errors, therefore declarations obtained from the module via the USE statement may be incomplete.

Cray Fortran : Version 15.0.1 (20230120205242_66f7391d6a03cf932f321b9f6b1d8612ef5f362c)
Cray Fortran : Compile time:  0.0027 seconds
Cray Fortran : 17 source lines
Cray Fortran : 5 errors, 0 warnings, 0 other messages, 0 ansi
Cray Fortran : "explain ftn-message number" gives more information about each message.
bprichar@perlmutter:login22:~/reproducers/cray_select_rank_and_type> ftn inverted.f90

module a
       ^
ftn-855 ftn: ERROR A, File = inverted.f90, Line = 1, Column = 8
  The compiler has detected errors in module "A".  No module information file will be created for this module.

      select type (x)
                   ^
ftn-1871 ftn: ERROR FOO, File = inverted.f90, Line = 7, Column = 20
  The selector in a SELECT TYPE statement must be polymorphic.

        print *, x
                 ^
ftn-620 ftn: ERROR FOO, File = inverted.f90, Line = 9, Column = 18
  This reference to assumed-rank variable "X" is not valid.

  use a, only: foo
      ^
ftn-894 ftn: ERROR MAIN, File = inverted.f90, Line = 15, Column = 7
  Module "A" has compile errors, therefore declarations obtained from the module via the USE statement may be incomplete.

Cray Fortran : Version 15.0.1 (20230120205242_66f7391d6a03cf932f321b9f6b1d8612ef5f362c)
Cray Fortran : Compile time:  0.0027 seconds
Cray Fortran : 17 source lines
Cray Fortran : 4 errors, 0 warnings, 0 other messages, 0 ansi
Cray Fortran : "explain ftn-message number" gives more information about each message.
```