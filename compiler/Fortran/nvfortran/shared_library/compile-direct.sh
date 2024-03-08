#!/bin/bash

# module load PrgEnv-nvidia

set -ex

nvfortran -echo -c -fPIC -acc example_mod.f90 -o example_mod.o
nvfortran -c -fPIC -acc example_mod.f90 -o example_mod.o
nvfortran -echo -shared -fPIC -acc example_mod.o -o libexample.so
nvfortran -shared -fPIC -acc example_mod.o -o libexample.so
nvfortran -echo -c -fPIC -acc example_prog.f90 -o example_prog.o
nvfortran -c -fPIC -acc example_prog.f90 -o example_prog.o
nvfortran -echo -fPIC -acc example_prog.o libexample.so -o example_prog.exe
nvfortran -fPIC -acc example_prog.o libexample.so -o example_prog.exe
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:." ./example_prog.exe
