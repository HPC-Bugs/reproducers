program example
    type :: my_type
        integer :: val
    end type
    print *, thing()
contains
    pure function thing()
        type(my_type) :: thing
        type(my_type), parameter :: constant = my_type(42)
        thing = constant
    end function
end program