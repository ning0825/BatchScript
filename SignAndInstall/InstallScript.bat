@echo off
::Check ADB
adb version >nul
if %errorlevel% neq 0 (
	echo Check ADB: Fail.
	goto end
) else (
	echo Check ADB: PASS.
)

::Check Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
	echo Check Java: Fail.
	goto end
) else (
	echo Check Java: PASS.
)

::copy SignAndInstal.bat to C:\program files
echo Installing...
md "C:\Program Files\SignAndInstall\" >nul 2>&1
copy .\files\platform.pk8 "C:\Program Files\SignAndInstall\" >nul
copy .\files\platform.x509.pem "C:\Program Files\SignAndInstall\" >nul
copy .\files\signapk.jar "C:\Program Files\SignAndInstall\" >nul
copy .\files\install.bat "C:\Program Files\SignAndInstall\" >nul
copy .\files\sign.bat "C:\Program Files\SignAndInstall\" >nul
copy .\files\SignAndInstall.bat "C:\Program Files\SignAndInstall\" >nul

:: add script to regedit
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\SignAndInstall /f >nul
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\SignAndInstall\command /t reg_sz /d "C:\Program Files\SignAndInstall\SignAndInstall.bat %%1" /f >nul

reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Install /f >nul
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Install\command /t reg_sz /d "C:\Program Files\SignAndInstall\install.bat %%1" /f >nul

reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Sign /f >nul
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Sign\command /t reg_sz /d "C:\Program Files\SignAndInstall\sign.bat %%1" /f >nul

echo Installation finish.

pause
exit \b 0

:end
pause
exit /b 0