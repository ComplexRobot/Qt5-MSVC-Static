@echo off
setlocal

set SSLRELEASE=1.0.x
set SSLARCH=WIN32
IF NOT v%SSLVER:1.1.=% == v%SSLVER% set SSLRELEASE=1.1.x
IF %VSCMD_ARG_TGT_ARCH% == x64 set SSLARCH=WIN64A

echo Configuring OpenSSL %SSLVER% for %SSLARCH%...
IF exist %SSLINSTALLDIR% (
    echo OpenSSL already installed!
    echo Delete or rename %SSLINSTALLDIR% if you want to rebuild it.
) ELSE (
    IF exist %SSLBUILDDIR% (

        cd %SSLBUILDDIR%

        IF %SSLRELEASE% == 1.1.x (

            rd build /s /q
            md build
            cd build

            call perl ..\Configure VC-%SSLARCH% enable-static-engine no-shared --prefix=%SSLINSTALLDIR%

            echo Building / Installing OpenSSL...
            call nmake install_sw
            IF %errorlevel% NEQ 0 (
                exit /b 1
            )

        ) ELSE (

            call perl Configure VC-%SSLARCH% enable-static-engine --prefix=%SSLINSTALLDIR%
            IF %SSLARCH% == WIN32 call ms\do_nasm
            IF %SSLARCH% == WIN64A call ms\do_win64a

            echo Building OpenSSL...
            call nmake -f ms\nt.mak clean all
            IF %errorlevel% NEQ 0 (
                exit /b 1
            )

            echo Installing OpenSSL...
            call nmake -f ms\nt.mak install
            IF %errorlevel% NEQ 0 (
                exit /b 1
            )

        )

    ) ELSE (

        echo Could not find OpenSSL sources in %SSLBUILDDIR%
        exit /b 1
    )
)

exit

endlocal
