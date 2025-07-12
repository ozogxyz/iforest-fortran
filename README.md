# iforest-fortran
A minimal and clean Fortran implementation of the Isolation Forest algorithm for anomaly detection.  

## Status

🚧 Work in progress — not production-ready. Core training and scoring functionality implemented.

## Features

- Clean modular Fortran (no dependencies)
- Isolation Forest from scratch
- Recursive tree building with controlled depth
- Random subsampling, path-based scoring
- Extendable to other tree-based experiments later

## Build

Requires Intel Fortran (`ifx`) and a `build.bat` script.  Haven't tested with gfortran or on Unix yet.
See `src/` for modules, `main.f90` for test harness.

## License

MIT
