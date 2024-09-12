program main
  implicit none

  type mytype
    real, allocatable :: arr_3d(:,:,:), arr_2d(:,:)
  end type mytype

  type(mytype) :: x
  integer, parameter :: dim_sz = 2
  real, allocatable :: test(:,:,:)

  x = mytype( &
    arr_3d = reshape([real:: [1,0, 0,1], [1,0, 0,1]], [dim_sz, dim_sz, dim_sz]), &
    arr_2d = reshape([real:: [0,0], [0,0]], [dim_sz, dim_sz]))

  test = reshape([real:: [1,0, 0,1], [1,0, 0,1]], [dim_sz, dim_sz, dim_sz])
end program
