module example_mod
contains
    pure function add_one_to_each(a)
        integer, intent(in) :: a(:)
        integer :: add_one_to_each(size(a))
        add_one_to_each = add_one(a)
    contains
        elemental function add_one(x)
            integer, intent(in) :: x
            integer :: add_one
            add_one = x + 1
        end function
    end function
end module

use example_mod
print *, add_one_to_each([1, 2, 3])
end