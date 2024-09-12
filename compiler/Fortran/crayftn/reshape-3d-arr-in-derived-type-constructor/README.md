# Parsing bug with a reshape function call for a 3d array in a derived type constructor

version: Cray Fortran : Version 17.0.0
system: NERSC perlmutter

## Additional Content

The included file, [./example.f90], illustrates the problem. The file includes the
same exact call to `reshape` in a separate normal assignment statement to an array.
If the call to the derived type constructor with the `reshape` function call is commented
out, then the file with the remaining `reshape` function call compiles. Additionally,
if the 3d array is commented out of the derived type and the call to its constructor, the
remaining `reshape` function call for the 2d array component in the call to the
derived type constructor compiles.

## Steps to Reproduce

The parsing bug is triggered when there is a function call to the intrinsic `reshape` for
a 3d array and when this function call is inside of a call to a derived type constructor.

See below:

```
~/hpc-bugs-reproducers> ftn example.f90 

    arr_3d = reshape([real:: [1,0, 0,1], [1,0, 0,1]], [dim_sz, dim_sz, dim_sz]), &
                              ^                                                    
ftn-1725 ftn: ERROR MAIN, File = example.f90, Line = 13, Column = 31 
  Unexpected syntax while parsing the assignment statement : "INTEGER, REAL, DOUBLE, COMPLEX, LOGICAL, CHARACTER or type-name" was expected but found "1".

    arr_2d = reshape([real:: [0,0], [0,0]], [dim_sz, dim_sz]))
                                                              ^
ftn-1725 ftn: ERROR MAIN, File = example.f90, Line = 14, Column = 63 
  Unexpected syntax while parsing the assignment statement : "]" was expected but found "EOS".
                                                              ^
ftn-1725 ftn: ERROR MAIN, File = example.f90, Line = 14, Column = 63 
  Unexpected syntax while parsing the assignment statement : "]" was expected but found "EOS".
                                                              ^
ftn-1725 ftn: ERROR MAIN, File = example.f90, Line = 14, Column = 63 
  Unexpected syntax while parsing the assignment statement : ", or )" was expected but found "EOS".
                                                              ^
ftn-1725 ftn: ERROR MAIN, File = example.f90, Line = 14, Column = 63 
  Unexpected syntax while parsing the assignment statement : ", or )" was expected but found "EOS".

Cray Fortran : Version 17.0.0 (20231107223020_b59b7a8e9169719529cf5ab440f3c301e515d047)
Cray Fortran : Compile time:  0.0062 seconds
Cray Fortran : 17 source lines
Cray Fortran : 5 errors, 0 warnings, 0 other messages, 0 ansi
Cray Fortran : "explain ftn-message number" gives more information about each message.
```
