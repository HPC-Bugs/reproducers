module m_BaseAction
   type :: BaseAction
      character(:), allocatable :: name
      class(*), allocatable :: default
   end type BaseAction
end module m_BaseAction

module m_ActionVector
   use m_BaseAction
   implicit none

   type ActionVector
      type(BaseAction), allocatable :: elements(:)
   end type ActionVector

end module m_ActionVector

module mock_parser
   use m_ActionVector
   implicit none

   type :: ArgParser
      type(ActionVector) :: actions
   contains
      procedure :: add_argument
   end type ArgParser

contains

   subroutine add_argument(parser, name, default)
      class(ArgParser), intent(inout) :: parser
      character(*), intent(in) :: name
      class(*), intent(in) :: default

      allocate(parser%actions%elements(1))
!#      parser%actions%elements(1)%name = name
      parser%actions%elements(1)%default = default
   end subroutine add_argument

end module mock_parser


module Test_MAPL_CapOptions
   use mock_parser
   implicit none

contains

   subroutine test_mapl_reproducer()
      type (ArgParser), target :: parser

      call add_command_line_options(parser)

   end subroutine test_mapl_reproducer

   subroutine add_command_line_options(parser)
      type (ArgParser), intent(inout) :: parser

      type :: T
         integer, allocatable :: items(:)
      end type T
     type(T) :: tt
      integer :: one = -999

      allocate(tt%items(1))
      tt%items(1) = -999

!#      call parser%add_argument('--A', default = 1) ! works
      call parser%add_argument('--A', default = tt) ! fails

   end subroutine add_command_line_options

end module Test_MAPL_CapOptions

program main
   use Test_MAPL_CapOptions
   implicit none
   call test_mapl_reproducer()
end program main
