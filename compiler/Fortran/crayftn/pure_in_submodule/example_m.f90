module example_m
    implicit none
    private
    public :: foo

    interface foo
        pure module function foo_a(a)
            implicit none
            integer, intent(in) :: a
            integer :: foo_a
        end function

        pure module function foo_b(a, b)
            implicit none
            integer, intent(in) :: a, b
            integer :: foo_b
        end function
    end interface
end module
