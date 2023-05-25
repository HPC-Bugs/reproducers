submodule(example_m) example_s
    implicit none
contains
    module procedure foo_a
        foo_a = foo(a, 1)
    end procedure

    module procedure foo_b
        foo_b = a * b
    end procedure
end submodule
