The code below demonstrates a bug in ifx's generic resolution.  The bug causes
ifx to mistakenly detect a recursive procedure invocation related to the fact
that two procedures in different modules have the same specific name and both
also have (different) generic names.  The compiler bug occurs when the procedure
definition that triggers the compiler error messages is in a submodule and that
same procedure contains a declaration of an object of the type refrenced in function
being invoked via a generic interface.  To work around this compiler bug, one can
give the two involved procedures different specific names.

```
$ ifx -V
Intel(R) Fortran Compiler for applications running on Intel(R) 64, Version 2024.0.0 Build 20231017
Copyright (C) 1985-2023 Intel Corporation. All rights reserved.

$ ifx -c false-recursion.f90 
false-recursion.f90(41): error #6437: A subroutine or function is calling itself recursively.   [CONSTRUCT]
    construct%component = component_t()
--------------------------^
false-recursion.f90(41): error #6197: An assignment of different structure types is invalid.   [CONSTRUCT]
    construct%component = component_t()
--------------------------^
compilation aborted for false-recursion.f90 (code 1)

$ cat false-recursion.f90 
module component_m
  implicit none

  type component_t
  end type

  interface component_t
    module function construct()
      implicit none
      type(component_t) construct
    end function
  end interface

contains
  module procedure construct
  end procedure
end module

module container_m
  use component_m, only : component_t
  implicit none

  type container_t
    type(component_t) component
  end type

  interface container_t
    module function construct()
      implicit none
      type(container_t) construct
    end function
  end interface

end module

submodule(container_m) container_s
  implicit none
contains
  module procedure construct
    type(container_t) local_container
    construct%component = component_t()
  end procedure
end submodule
```
