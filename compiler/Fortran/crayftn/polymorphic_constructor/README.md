# Overloaded Constructor With Polymorphic Argument in Array Constructor

* version: Cray Fortran : Version 15.0.1
* system: perlmutter

## Additional Content

The include file, `example.f90` illustrates the issue.

## Steps to Reproduce

This is triggered by passing a child type to an overloaded structure constructor within an array constructor, where the parent type has a deferred procedure.
The file `example.f90` does this, and so compiling it elicits and internal compiler error (ICE).
I.e.

```text
bprichar@login29:~/Repositories/reproducers/compiler/Fortran/crayftn/polymorphic_constructor> module load PrgEnv-cray
bprichar@login29:~/Repositories/reproducers/compiler/Fortran/crayftn/polymorphic_constructor> ftn example.f90
*** Expected 2 arguments but only 1 on stack
    Contents of the expression stack:
---TOP---
t$52
---BOT---
   Error message      ::  _expr_type: Invalid table type
   Error detected     ::  File '/home/jenkins/crayftn/pdgcs/v_expr_utl.c', line 7360
   Optimizer built    ::  2023-01-20 (production)

   File               ::  example.f90
   Function           ::  example
   at or near line    ::  63

   File path          ::  /global/u2/b/bprichar/Repositories/reproducers/compiler/Fortran/crayftn/polymorphic_constructor/example.f90
   Compiler hash      ::  66f7391d6a03cf932f321b9f6b1d8612ef5f362c
   Target             ::  Heterogeneous
     CPU              ::  x86-milan
     ACCEL            ::  nvidia_80

Creating internal compiler error backtrace (please wait):
[0x00000000c75a43] linux_backtrace ??:?
[0x00000000c76931] pdgcs_internal_error(char const*, char const*, int) ??:?
[0x0000000125c2d0] _expr_type(EXP_INFO) ??:?
[0x0000000115e854] expr_asg_common(EXP_OP, EXP_OP) v_expr.c:?
[0x0000000080f7ec] fei_op ??:?
[0x0000000073aeb9] cvrt_exp_to_pdg m_cvrt.c:?
[0x0000000074b7eb] cvrt_proc_to_pdg m_cvrt.c:?
[0x0000000074c50f] m_cvrt_to_pdg ??:?
[0x000000007831b4] m_start_ipa ??:?
[0x00000000674da7] main ??:?
[0x007f86c32e129c] ?? ??:0
[0x00000000729d09] _start /home/abuild/rpmbuild/BUILD/glibc-2.31/csu/../sysdeps/x86_64/start.S:120

Note:  This is a non-debug compiler.  Technical support should
       continue problem isolation using a compiler built for
       debugging.

ftn-7991 ftn: INTERNAL EXAMPLE, File = example.f90, Line = 63
  INTERNAL COMPILER ERROR:  "_expr_type: Invalid table type" (/home/jenkins/crayftn/pdgcs/v_expr_utl.c, line 7360, version 66f7391d6a03cf932f321b9f6b1d8612ef5f362c)
```