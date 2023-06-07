module a
contains
  subroutine foo(x)
    class(*), intent(in) :: x(..)
    select type (x)
    type is (integer)
      select rank (x)
      rank (0)
        print *, x
      end select
    end select
  end subroutine
end module
program main
  use a, only: foo
  call foo(1)
end program
