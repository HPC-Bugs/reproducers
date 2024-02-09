module mod_m
  implicit none

  private
  public :: func

contains

    function func(line) result(returnVal)
      character(len=*), intent(in) :: line
      integer :: returnVal

      associate(associateName => line(index(line, ':')+1:))
        returnVal = index(associateName, '"')
      end associate
    end function func

end module
