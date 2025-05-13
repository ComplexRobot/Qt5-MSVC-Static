@echo off
setlocal

cd %QTBUILDDIR% ||  exit /b 1

echo Building Qt...
call jom -j%NUMBER_OF_PROCESSORS%
IF %errorlevel% NEQ 0 (
    exit /b 1
)

echo Installing Qt...
call jom -j%NUMBER_OF_PROCESSORS% install
IF %errorlevel% NEQ 0 (
    exit /b 1
)

echo Qt sucessfully installed

endlocal
