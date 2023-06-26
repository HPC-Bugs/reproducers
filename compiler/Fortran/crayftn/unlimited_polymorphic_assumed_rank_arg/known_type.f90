module a
contains
  subroutine foo(x)
    integer, intent(in) :: x(..)
    select rank (x)
    rank (0)
      print *, x
    end select
  end subroutine
end module
program main
  use a, only: foo
  call foo(1)
end program
