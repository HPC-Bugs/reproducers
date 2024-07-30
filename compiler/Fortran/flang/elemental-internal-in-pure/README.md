# Erroneous compiler error with elemental internal procedure in pure procedure

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

This is triggered when a pure procedure has an internal procedure that
is elemental. For example, try compiling the included file as shown below.

```text
$ flang-new example.f90
error: Semantic errors in example.f90
./example.f90:8:9: error: An internal subprogram of a pure subprogram must also be pure
          elemental function add_one(x)
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

# Workaround

If feasible, move the procedure to no longer be internal.