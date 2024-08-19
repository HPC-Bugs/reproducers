# Named Constant of Derived Type in Pure Procedure

```yaml
compiler: flang-new
version: 18.1.8
operating system: Arch Linux
platform: x86_64-pc-linux-gnu
bug-type: compile-time
```

# Additional content

The included file, `example.f90`, is sufficient to illustrate the problem.

# Steps to Reproduce

Declaring a named constant of derived type in a pure procedure triggers this bug.
For example, try compiling the included file as shown below.

```text
$ flang-new example.f90
error: Semantic errors in example.f90
./example.f90:9:37: error: 'constant' may not be a local variable in a pure subprogram
          type(my_type), parameter :: constant = my_type(42)
                                      ^^^^^^^^
./example.f90:9:37: because: 'constant' is not a variable
          type(my_type), parameter :: constant = my_type(42)
                                      ^^^^^^^^
./example.f90:9:37: Declaration of 'constant'
          type(my_type), parameter :: constant = my_type(42)
                                      ^^^^^^^^
```

# Workaround

Declare the constant outside of the procedure, i.e. in the module or main
program.