@echo off
setlocal EnableDelayedExpansion

set EXTPATH=%SRCDIR%\%EXTNAME%-everywhere-src-%QTVER%
set QMAKE=%QTINSTALLDIR%\bin\qmake.exe

IF NOT "%EXTNAME%" == "" (

    echo PATH: %EXTPATH%
    echo QMAKE: %QMAKE%

    set URL=http://download.qt.io/%QTRELEASE%_releases/qt/%QTVER:~0,-3%/%QTVER%/submodules/%EXTNAME%-everywhere-opensource-src-%QTVER%.zip

    cd %SRCDIR%
    echo Downloading !URL!
    curl %CURLOPTS% !URL!

    rd %EXTPATH% /s /q
    7z %ZOPTS% %EXTNAME%-everywhere-opensource-src-%QTVER%.zip || pause ^&^& exit /b 1
    cd ..

    cd %EXTPATH% ||  pause ^&^& exit /b 1

    echo Configuring %EXTNAME%...
    call %QMAKE% || pause ^&^& exit /b 1
    IF %errorlevel% NEQ 0 (
        pause
        exit /b 1
    )

    echo Building %EXTNAME%...
    call jom clean all
    IF %errorlevel% NEQ 0 (
        pause
        exit /b 1
    )

    echo Installing %EXTNAME%...
    call jom install
    IF %errorlevel% NEQ 0 (
        pause
        exit /b 1
    )

    echo %EXTNAME% installed
) ELSE (
    echo Missing extension name!
)

pause
exit

endlocal
