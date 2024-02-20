module stuff_m
  implicit none
  type stuff_t
  contains
    procedure, nopass :: do_something
  end type
contains
  subroutine do_something
  end subroutine
end module

program selector_tbp_invocation
  use stuff_m
  implicit none
  type(stuff_t) stuff
  associate (stuff => stuff_t())
    call stuff%do_something()
  end associate
end program