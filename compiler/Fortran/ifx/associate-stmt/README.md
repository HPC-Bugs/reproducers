# Associate Name Created From Slice of Assumed Character Length Variable Has No Length

version: ifx (IFX) 2024.0.0 20231017
system: headroom@orthus.nic.uoregon.edu

## Additional Content

The included file, [./example.f90] illustrates the problem.

## Steps to Reproduce

This is triggered when refering to an associate-name created when the selector was a slice of an assumed character length variable. The associate-name seemingly has not be given a length. This behavior can be observed when trying to compile `example.f90`.

See below:

```text
~/reproducers$ ifx example.f90
example.f90(11): error #5529: CHARACTER variable 'ASSOCIATENAME' has no length argument in routines with C or STDCALL attribute
        returnVal = index(associateName, '"')
--------------------------^
compilation aborted for example.f90 (code 1)
```