@echo off
setlocal

cd %QTBUILDDIR% ||  pause ^&^& exit /b 1

echo Building Qt...
call jom -j16
IF %errorlevel% NEQ 0 (
    pause
    exit /b 1
)

echo Installing Qt...
call jom -j16 install
IF %errorlevel% NEQ 0 (
    pause
    exit /b 1
)

echo Qt sucessfully installed

pause
exit

endlocal
