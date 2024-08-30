# Passing procedure pointer derived type components to associated function call

version: Cray Fortran : Version 17.0.0
system: NERSC perlmutter

## Additional Content

The included file, [./example.f90], illustrates the problem.

## Steps to Reproduce

An internal compiler error is triggered when there is an associated function call
whose arguments are two procedure pointer derived type components.

See below:

```text
~/hpc-bugs-reproducers/compiler/Fortran/crayftn/associated-func-call> ftn -c example.f90 
   Struct_Opr  idx = 17  Cray parcel pointer   rank = 0; line = 49, col = 34
   Left opnd is IR_Tbl_Idx;  line = 49, col = 31
      Dv_Deref_Opr  idx = 81  type(TYPE_T)    typ_idx (587)   dim = 0 rank = 0; line = 49, col = 31
      Left opnd is AT_Tbl_Idx;  line = 49, col = 31
         LHS  idx = 701  derived-type * 587  
      Right operand is NO_Tbl_Idx;
   Right operand is AT_Tbl_Idx;  line = 49, col = 35
      TEST_FUNCTION_  idx = 591  Cray parcel pointer * Cray_Parcel_Ptr_8  
ftn-1716 ftn: INTERNAL EQUALS, File = example.f90, Line = 49, Column = 34 
  A multiparented node was encountered.
ftn-2116 ftn: INTERNAL  
  "/opt/cray/pe/cce/17.0.0/cce/x86_64/bin/ftnfe" was terminated due to receipt of signal 06:  Aborted.
```
