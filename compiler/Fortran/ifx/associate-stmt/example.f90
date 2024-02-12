module mod_m
  implicit none

contains

    function func(line) result(returnVal)
      character(len=*) :: line
      integer :: returnVal

      associate(associateName => line(2:))
        returnVal = index(associateName, '"')
      end associate
    end function func

end module
