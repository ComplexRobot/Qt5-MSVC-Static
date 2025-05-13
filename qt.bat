@echo off
setlocal

call tools\options.bat

IF NOT "%1"=="" (

    IF "%1"=="download" (
        start "qt download" /W /BELOWNORMAL tools\download.bat
    )
    IF "%1"=="setup" (
        start "qt setup" /W /BELOWNORMAL tools\setup_qt.bat
    )
    IF "%1"=="build" (
        start "qt build" /W /BELOWNORMAL tools\build_qt.bat
    )
    IF "%1"=="openssl" (
        start "qt openssl" /W /BELOWNORMAL tools\build_openssl.bat
    )
    IF "%1"=="extra" (
        set EXTNAME=%2
        start "qt extra %2" /W /BELOWNORMAL tools\build_qt_extras.bat
    )

) ELSE (
    echo **Available commands**
    echo download: Download and extracts required sources
    echo openssl : Build OpenSSL
    echo setup : Setup Qt
    echo build : build Qt
    echo extra [name]: Download and build qt extension [name]
)

endlocal
