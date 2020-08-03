@echo off
cd \
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\SignAndInstall /f >nul
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Sign /f >nul
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Install /f >nul
rd "C:\Program Files\SignAndInstall" /s /q
echo Finish.
pause