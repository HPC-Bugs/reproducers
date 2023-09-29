module example_m
contains
    elemental function func(x) result(y)
        integer, intent(in) :: x
        integer :: y

        y = internal(x)
    contains
        elemental function internal(x_) result(y_)
            integer, intent(in) :: x_
            integer :: y_

            y_ = x_ + 1
        end function
    end function
end module