module example_mod
    abstract interface
        subroutine sub_i
        end subroutine
    end interface
contains
    subroutine call_internal(string)
        character(len=*), intent(in) :: string
        call call_it(print_it)
    contains
        subroutine print_it
            print *, string
        end subroutine
    end subroutine
    subroutine call_it(sub)
        procedure(sub_i) :: sub
        call sub
    end subroutine
end module

program example_prog
    use example_mod
    call call_internal("Hello")
end program