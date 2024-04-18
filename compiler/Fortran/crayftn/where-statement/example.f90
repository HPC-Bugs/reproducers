module example_mod
    implicit none
    private
    public :: varying_string, assignment(=)

    type :: varying_string
        character(len=:), allocatable :: chars
    end type

    interface assignment(=)
        module procedure assign_character_to_string
    end interface
contains
    elemental subroutine assign_character_to_string(lhs, rhs)
        type(varying_string), intent(out) :: lhs
        character(len=*), intent(in) :: rhs

        allocate(lhs%chars, source = rhs)
    end subroutine
end module

program example
    use example_mod

    implicit none

    type(varying_string) :: lines(3)
    logical :: blank_lines(3)

    lines(1) = "foo"
    lines(2) = "  "
    lines(3) = "bar"
    blank_lines = [.false., .true., .false.]
    where(blank_lines) lines = ""
end program