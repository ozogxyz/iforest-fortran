#!/bin/bash

mkdir -p build

# Compile modules
gfortran -c -O2 -Wall -Jbuild -o build/if_types.o src/if_types.f90
gfortran -c -O2 -Wall -Jbuild -o build/if_sampling.o src/if_sampling.f90
gfortran -c -O2 -Wall -Jbuild -o build/if_tree.o src/if_tree.f90
gfortran -c -O2 -Wall -Jbuild -o build/if_forest.o src/if_forest.f90
gfortran -c -O2 -Wall -Jbuild -o build/if_api.o src/if_api.f90

# Create static lib
ar rcs build/libiforest.a build/*.o

# Compile main
gfortran -c -O2 -Wall -Jbuild -o build/main.o main.f90

# Link
gfortran build/*.o -o iforest.exe

