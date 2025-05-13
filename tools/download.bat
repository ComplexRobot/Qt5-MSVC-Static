@echo off
setlocal

call tools\options.bat

cd %SRCDIR% ||  pause ^&^& exit /b 1

echo Downloading %QTURL%
curl %CURLOPTS% %QTURL% 
7z %ZOPTS% qtbase-everywhere-opensource-src-%QTVER%.zip || pause ^&^& exit /b 1

echo Downloading %SSLURL%
curl %CURLOPTS% %SSLURL%
7z %ZOPTS% openssl-%SSLVER%.tar.gz ||  pause ^&^& exit /b 1
7z %ZOPTS% openssl-%SSLVER%.tar ||  pause ^&^& exit /b 1

cd ..

pause
exit

endlocal
