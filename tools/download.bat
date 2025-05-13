@echo off
setlocal

call tools\options.bat

cd %SRCDIR% ||  exit /b 1

echo Downloading %QTURL%
curl %CURLOPTS% %QTURL% 
7z %ZOPTS% qtbase-everywhere-opensource-src-%QTVER%.zip || exit /b 1

echo Downloading %SSLURL%
curl %CURLOPTS% %SSLURL%
7z %ZOPTS% openssl-%SSLVER%.tar.gz ||  exit /b 1
7z %ZOPTS% openssl-%SSLVER%.tar ||  exit /b 1

cd ..

endlocal
