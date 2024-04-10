# `merge` Function Call Crashes When the `mask` Argument Is a Derived Type Component

version: Cray Fortran : Version 17.0.0
system: NERSC perlmutter

## Additional Content

The included file, [./example.f90], illustrates the problem.

## Steps to Reproduce

This is triggered when there is a function call to the intrinsic `merge` and when the
`mask` argument is a component of the derived type argument to a type bound procedure and
when the result of the `merge` call is then passed to the intrinsic `trim`. Attempting to
compile such code causes an internal compiler error.

See below:

```text
~/hpc-bugs-reproducers/compiler/Fortran/crayftn/merge-with-derived-type-mask> ftn -c example.f90
The bad bad string _select('true ','false',$GVN_self_1) stmt_x 10

*** ASSERT failed ('/home/jenkins/crayftn/pdgcs/llvm-substr.c':493) ***
   Error message      ::  get_string_address - the string is not a lsbstr
   Error detected     ::  File '/home/jenkins/crayftn/pdgcs/llvm-substr.c', line 493
   Optimizer built    ::  2023-11-07 (debug)

   File               ::  example.f90
   Function           ::  myproc
   at or near line    ::  15

   Raw function name  ::  myproc$mod_
   File path          ::  /hpc-bugs-reproducers/compiler/Fortran/crayftn/merge-with-derived-type-mask/example.f90
   Compiler hash      ::  b59b7a8e9169719529cf5ab440f3c301e515d047
   Target             ::  Heterogeneous
     CPU              ::  x86-milan
     ACCEL            ::  nvidia_80

Creating internal compiler error backtrace (please wait):
[0x000000012d4e69] linux_backtrace /home/jenkins/crayftn/pdgcs/v_util.c:186
[0x000000012d53a1] pdgcs_internal_error(char const*, char const*, int) /home/jenkins/crayftn/pdgcs/v_util.c:663
[0x000000015e3c52] llvm_cg::get_string_address(EXP_INFO) /home/jenkins/crayftn/pdgcs/llvm-substr.c:493
[0x000000021a5ac9] llvm_cg::gen_llvm_unary_expr(EXP_INFO) /home/jenkins/crayftn/pdgcs/llvm-uex-expr.c:436
[0x000000015dc36b] llvm_cg::gen_llvm_assign_stmt(int) /home/jenkins/crayftn/pdgcs/llvm-stmt.c:644
[0x0000000158f4e2] llvm_cg::translate_body() /home/jenkins/crayftn/pdgcs/llvm-pdgcs.c:5170
[0x000000015ae15a] llvm_cg::llvm_function_with_body() /home/jenkins/crayftn/pdgcs/llvm-pdgcs.c:5410
[0x000000015b106f] internal_llvm_function(int, int, int, int, llvm_cg::FunctionTranslateMode) /home/jenkins/crayftn/pdgcs/llvm-pdgcs.c:7777
[0x000000015b477c] llvm_function(int) /home/jenkins/crayftn/pdgcs/llvm-pdgcs.c:8724
[0x00000000a7d520] PDGCS_do_proc /home/jenkins/crayftn/pdgcs/v_fei.c:3646
[0x00000000912aed] cvrt_proc_to_pdg /home/jenkins/crayftn/inl/sources/m_cvrt.c:10377
[0x0000000096707e] process_scp /home/jenkins/crayftn/inl/sources/m_i_control.c:1615
[0x000000007c98ce] main /home/jenkins/crayftn/inl/sources/m_main.c:296
[0x007f35e3e3e24c] ?? ??:0
[0x000000008a9fc9] _start /home/abuild/rpmbuild/BUILD/glibc-2.31/csu/../sysdeps/x86_64/start.S:120
ftn-7991 ftn: INTERNAL MYPROC, File = example.f90, Line = 15 
  INTERNAL COMPILER ERROR:  "get_string_address - the string is not a lsbstr" (/home/jenkins/crayftn/pdgcs/llvm-substr.c, line 493, version b59b7a8e9169719529cf5ab440f3c301e515d047)
ftn-2116 ftn: INTERNAL  
  "/opt/cray/pe/cce/17.0.0/cce/x86_64/bin/optcg" was terminated due to receipt of signal 06:  Aborted.
```
