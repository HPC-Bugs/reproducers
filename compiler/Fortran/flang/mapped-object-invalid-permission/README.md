# Invalid Permissions for Mapped Object

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

A segfault occurs when calling a procedure dummy argument if the actual
argument is an internal procedure that accesses as host associated
dummy argument. When run with the debugger the fault is reported as

```text
signal SIGSEGV: invalid permissions for mapped object (fault address: 0x7fffffffe310)
```
