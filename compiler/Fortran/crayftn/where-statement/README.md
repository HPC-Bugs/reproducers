# WHERE statement defined assignment

compiler: crayftn
version: 17.0.0
operating system: "SUSE Linux Enterprise Server 15 SP4"
platform: perlmutter.nersc.gov
bug-type: compile time

## Additional Content

The included file, `example.f90`, illustrates the issue.

## Steps to Reproduce

This seems to be due to the fact of using a defined assignment in a WHERE statement.
Compile the included `example.f90` to see an Internal Compiler Error pointing at that line.
I.e.

```text
bprichar@login07:~/Repositories/reproducers/compiler/Fortran/crayftn/where-statement> module load PrgEnv-cray

Lmod is automatically replacing "gcc-native/12.3" with "cce/17.0.0".


Lmod is automatically replacing "PrgEnv-gnu/8.5.0" with "PrgEnv-cray/8.5.0".


Due to MODULEPATH changes, the following have been reloaded:
  1) cray-libsci/23.12.5     2) cray-mpich/8.1.28

bprichar@login07:~/Repositories/reproducers/compiler/Fortran/crayftn/where-statement> ftn example.f90
add_asg( Op_ASG,  substr(t$22,1,0), t$21(+:(1,3,1)) where '', character[8]*0, ... )
   Error message      ::  Array syntax flags do not match
   Error detected     ::  File '/home/jenkins/crayftn/pdgcs/v_expr_tbl.c', line 413
   Optimizer built    ::  2023-11-07 (debug)

   File               ::  example.f90
   Function           ::  example
   at or near line    ::  34

   Raw function name  ::  example_
   File path          ::  /global/u2/b/bprichar/Repositories/reproducers/compiler/Fortran/crayftn/where-statement/example.f90
   Compiler hash      ::  b59b7a8e9169719529cf5ab440f3c301e515d047
   Target             ::  Heterogeneous
     CPU              ::  x86-milan
     ACCEL            ::  nvidia_80

Creating internal compiler error backtrace (please wait):
[0x000000012d4e69] linux_backtrace /home/jenkins/crayftn/pdgcs/v_util.c:186
[0x000000012d53a1] pdgcs_internal_error(char const*, char const*, int) /home/jenkins/crayftn/pdgcs/v_util.c:663
[0x00000001ddcbc5] verify_binary_args(EXP_OP, EXP_INFO, EXP_INFO, TYPE, char const*, EXP_T_TYPE, bool, bool, bool) [clone .constprop.0] /home/jenkins/crayftn/pdgcs/v_expr_tbl.c:413
[0x00000001ddf5a4] add_asg(EXP_OP, EXP_INFO, EXP_INFO, TYPE, EXP_INFO) /home/jenkins/crayftn/pdgcs/v_expr_tbl.c:2143 (discriminator 2)
[0x00000001bf8cc0] expr_asg_common(EXP_OP, EXP_OP) /home/jenkins/crayftn/pdgcs/v_expr.c:1281
[0x00000000ab3459] fei_where /home/jenkins/crayftn/pdgcs/v_fei_fort.c:2393
[0x000000008d95c4] cvrt_exp_to_pdg /home/jenkins/crayftn/inl/sources/m_cvrt.c:7027 (discriminator 2)
[0x00000000910674] cvrt_ir_to_pdg /home/jenkins/crayftn/inl/sources/m_cvrt.c:9834 (discriminator 2)
[0x00000000912a28] cvrt_proc_to_pdg /home/jenkins/crayftn/inl/sources/m_cvrt.c:10353
[0x0000000096707e] process_scp /home/jenkins/crayftn/inl/sources/m_i_control.c:1615
[0x000000007c98ce] main /home/jenkins/crayftn/inl/sources/m_main.c:296
[0x007fd83a83e24c] ?? ??:0
[0x000000008a9fc9] _start /home/abuild/rpmbuild/BUILD/glibc-2.31/csu/../sysdeps/x86_64/start.S:120
ftn-7991 ftn: INTERNAL EXAMPLE, File = example.f90, Line = 34
  INTERNAL COMPILER ERROR:  "Array syntax flags do not match" (/home/jenkins/crayftn/pdgcs/v_expr_tbl.c, line 413, version b59b7a8e9169719529cf5ab440f3c301e515d047)
ftn-2116 ftn: INTERNAL
  "/opt/cray/pe/cce/17.0.0/cce/x86_64/bin/optcg" was terminated due to receipt of signal 06:  Aborted.
```

## Workaround

The issue is simple enough to workaround by changing the `where` statement as follows:

from

```fortran
    where(blank_lines) lines = ""
```

to

```fortran
    do concurrent (integer :: i = 1:size(lines), blank_lines(i))
        lines(i) = ""
    end do
```
