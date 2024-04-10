module mod
  implicit none

  type mytype
    logical :: skip = .false.
  contains
    procedure :: myproc
  end type

contains

  subroutine myproc(self)
    implicit none
    class(mytype), intent(in) :: self
    write(*,*) trim(merge("true ","false",self%skip))
  end subroutine

end module
