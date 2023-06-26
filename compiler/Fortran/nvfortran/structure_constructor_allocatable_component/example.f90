program example
    implicit none
    type :: T
        integer :: i
        integer, allocatable :: a(:)
    end type

    type(T) :: v

    v = T(i = 42)
end program
