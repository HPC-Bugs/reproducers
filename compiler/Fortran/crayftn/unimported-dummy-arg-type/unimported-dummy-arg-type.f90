module foo_m
  implicit none

  type foo_t
  end type

  type bar_t
  end type

  interface foo_t
    module function construct(bar) result(foo)
      implicit none
      type(bar_t) bar
      type(foo_t) foo
    end function
  end interface
  
contains
  module procedure construct
  end procedure
end module
