module string_m
implicit none

type string_t
character(len=:), allocatable :: string_
end type

interface operator(.cat.)
procedure concatenate_elements
end interface

contains

function concatenate_elements(strings) result(concatenated_elements)
type(string_t), intent(in) :: strings(:)
character(len=:), allocatable :: concatenated_elements
integer s
concatenated_elements = ""
do s = 1, size(strings)
concatenated_elements = concatenated_elements // strings(s)%string_
end do
end function

end module

use string_m
implicit none

associate(array => [string_t("foo"),string_t("bar")])
if (.cat. array /= "foobar" ) error stop
end associate
end