@echo off


set MSVCVER=2022
set SSLVER=1.1.1k
set EXTRABUILDOPTIONS=-qt-sqlite -c++std c++2b -pch -ltcg -qt-doubleconversion -qt-freetype -qt-harfbuzz -gui -widgets
set PATH=%PATH%


REM DO NOT EDIT BELOW THIS LINE

set STARTDIR=%CD%
set SRCDIR=%CD%\sources
set BUILDDIR=%CD%\build
set PLATFORM=win32-msvc%MSVCVER%
set QTINSTALLDIR=%PREFIX%\%QTVER%\msvc%MSVCVER%-%VSCMD_ARG_TGT_ARCH%-static

set QTRELEASE=official
for %%A in (alpha beta rc) DO (echo.%QTVER% | find /I "%%A">Nul && set QTRELEASE=development)

set QTURL=http://download.qt.io/%QTRELEASE%_releases/qt/%QTVER:~0,-3%/%QTVER%/submodules/qtbase-everywhere-opensource-src-%QTVER%.zip
set QTDIR=%SRCDIR%\qtbase-everywhere-src-%QTVER%
set QTBUILDDIR=%QTDIR%\build

set SSLURL=https://www.openssl.org/source/openssl-%SSLVER%.tar.gz
set SSLBUILDDIR=%SRCDIR%\openssl-%SSLVER%
set SSLINSTALLDIR=%QTINSTALLDIR%\openssl-%SSLVER%

set CURLOPTS=-L -C - -O
set ZOPTS=x -aos -y
set PATH=%STARTDIR%\tools\gnuwin32\bin;%STARTDIR%\tools\jom;%STARTDIR%\tools\nasm;%PATH%
