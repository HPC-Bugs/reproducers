type, abstract :: p
end type

type, extends(p) :: c
end type

class(p), allocatable :: a

a = func()
contains
  function func() result(a)
    class(p), allocatable :: a

    a = c()
  end function
end
