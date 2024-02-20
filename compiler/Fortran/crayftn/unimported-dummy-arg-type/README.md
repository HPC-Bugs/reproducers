1. Compiler version: 17.0.0 on perlmutter.nersc.gov
2. Additional content necessary to reproduce the issue: None.
3. The steps needed to reproduce the issue: `ftn -c unimported-dummy-arg-type.f90`
4. Workaround: remove the procedure definition from the module and instead place it in a submodule like below.
```
submodule(foo_m) foo_s
  implicit none
contains
  module procedure construct
  end procedure
end submodule
```
