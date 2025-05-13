@echo off
setlocal

IF exist %SSLINSTALLDIR% (
    echo Found OpenSSL
) ELSE (
    echo Could not find OpenSSL in %SSLINSTALLDIR%
    echo use "qt.bat openssl" to install it.
    pause
    exit /b 1
)

IF exist %QTDIR% (
    cd %QTDIR%
) ELSE ( 
    echo Could not find Qt sources in %QTDIR%
    pause
    exit /b 1
)

IF exist %QTBUILDDIR% (
    echo Cleaning old Qt build dir
    rd /s /q %QTBUILDDIR%
)

md %QTBUILDDIR%
cd %QTBUILDDIR%  ||  pause ^&^& exit /b 1

echo Configuring Qt...
call %QTDIR%\configure.bat -prefix "%QTINSTALLDIR%" -platform %PLATFORM% ^
-opensource -debug-and-release -confirm-license -opengl desktop -mp -static ^
-qt-libpng -qt-libjpeg -qt-zlib -qt-pcre -no-compile-examples -nomake examples ^
%EXTRABUILDOPTIONS% ^
-openssl-linked OPENSSL_PREFIX=%SSLINSTALLDIR%
IF %errorlevel% NEQ 0 (
    pause
    exit /b 1
)

echo Configuration complete
echo Will install to %QTINSTALLDIR%

pause
exit

endlocal

