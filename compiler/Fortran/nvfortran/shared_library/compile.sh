#!/bin/bash

# module load PrgEnv-nvidia

set -ex

ftn -c -fPIC example_mod.f90 -o example_mod.o
ftn -shared -fPIC example_mod.o -o libexample.so
ftn -c -fPIC example_prog.f90 -o example_prog.o
ftn -fPIC example_prog.o libexample.so -o example_prog.exe
./example_prog.exe