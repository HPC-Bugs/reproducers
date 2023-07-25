module example_m
    implicit none

    type, abstract :: parent
    contains
        procedure(to_string_i), deferred :: to_string
    end type

    abstract interface
        pure function to_string_i(self) result(string)
            import parent
            implicit none
            class(parent), intent(in) :: self
            character(len=:), allocatable :: string
        end function
    end interface

    type :: item
        class(parent), allocatable :: val
    contains
        procedure :: to_string => item_to_string
    end type

    interface item
        module procedure item_constructor
    end interface

    type, extends(parent) :: child
        character(len=:), allocatable :: val
    contains
        procedure :: to_string => child_to_string
    end type
contains
    function item_constructor(val) result(new_item)
        class(parent), intent(in) :: val
        type(item) :: new_item

        new_item%val = val
    end function

    pure function item_to_string(self) result(string)
        class(item), intent(in) :: self
        character(len=:), allocatable :: string

        string = self%val%to_string()
    end function

    pure function child_to_string(self) result(string)
        class(child), intent(in) :: self
        character(len=:), allocatable :: string

        string = self%val
    end function
end module

program example
    use example_m

    implicit none

    type(item), allocatable :: i(:)

    i = [item(child("Hello, World!"))]
    print *, i(1)%to_string()
end program