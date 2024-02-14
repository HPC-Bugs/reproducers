#!/bin/bash

# module load PrgEnv-nvidia

set -ex

ftn -echo -c -fPIC example_mod.f90 -o example_mod.o
ftn -c -fPIC example_mod.f90 -o example_mod.o
ftn -echo -shared -fPIC example_mod.o -o libexample.so
ftn -shared -fPIC example_mod.o -o libexample.so
ftn -echo -c -fPIC example_prog.f90 -o example_prog.o
ftn -c -fPIC example_prog.f90 -o example_prog.o
ftn -echo -fPIC example_prog.o libexample.so -o example_prog.exe
ftn -fPIC example_prog.o libexample.so -o example_prog.exe
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:." ./example_prog.exe
