@echo off
setlocal

if not exist build mkdir build

REM Compile modules from src/
ifx /c /O2 /nologo /warn:all /module:build /object:build\if_types.obj src\if_types.f90
if errorlevel 1 exit /b 1

ifx /c /O2 /nologo /warn:all /module:build /object:build\if_sampling.obj src\if_sampling.f90
if errorlevel 1 exit /b 1

ifx /c /O2 /nologo /warn:all /module:build /object:build\if_tree.obj src\if_tree.f90
if errorlevel 1 exit /b 1

ifx /c /O2 /nologo /warn:all /module:build /object:build\if_forest.obj src\if_forest.f90
if errorlevel 1 exit /b 1

ifx /c /O2 /nologo /warn:all /module:build /object:build\if_api.obj src\if_api.f90
if errorlevel 1 exit /b 1

REM Create static lib
lib /nologo /out:build\libiforest.lib build\*.obj

REM Compile main
ifx /c /O2 /nologo /warn:all /module:build /object:build\main.obj main.f90
if errorlevel 1 exit /b 1

REM Link all objects
ifx /nologo build\*.obj /exe:iforest.exe
if errorlevel 1 exit /b 1

echo Build succeeded.
