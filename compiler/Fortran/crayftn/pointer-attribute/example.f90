module pointer_attribute_bug_m
  implicit none

  private
  public :: type_t
  public :: function_i

  abstract interface
    function function_i() result(passes)
      implicit none
      logical passes
    end function
  end interface

  type type_t
    private
    procedure(function_i), pointer, nopass :: test_function_ => null()
  end type

  interface type_t

    module function construct(test_function) result(result)
      implicit none
      procedure(function_i), intent(in), pointer :: test_function
      type(type_t) result
    end function

  end interface

end module pointer_attribute_bug_m

submodule(pointer_attribute_bug_m) pointer_attribute_bug_s
  implicit none
contains
    module procedure construct
      result%test_function_ => test_function
    end procedure

end submodule pointer_attribute_bug_s
