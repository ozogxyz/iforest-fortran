# iforest-fortran
 
> ⚠️ **Warning**  
> Not fully implemented yet.

A minimal and clean Fortran implementation of the Isolation Forest algorithm for anomaly detection.  

## Features

- Clean modular Fortran (no third-party dependencies)
- Recursive tree building with controlled depth
- Random subsampling, path-based scoring
- Extendable to other tree-based experiments later

## Build

Requires Intel Fortran (`ifx`) and a `build.bat` script.  Haven't tested with `gfortran` or on Unix yet.
See `src/` for modules, `main.f90` for test harness.

## License

MIT
