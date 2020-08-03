@echo off
::Check ADB
adb version >nul
if %errorlevel% neq 0 (
	echo Check ADB: Fail. Add "[Android_SDK_folder]\platform-tools" to PATH environment variable.
	goto end
) else (
	echo Check ADB: PASS.
)

::Check Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
	echo Check Java: Fail. Add "[JDK_folder]\bin" to PATH environment variable.
	goto end
) else (
	echo Check Java: PASS.
)

::copy SignAndInstal.bat to C:\program files
echo Installing...
set installPath="C:\Program Files\SignAndInstall\"
md %installPath% >nul 2>&1
copy %~dp0\files\UninstallScript.bat %installPath% >nul
copy %~dp0\files\platform.pk8 %installPath% >nul
copy %~dp0\files\platform.x509.pem %installPath% >nul
copy %~dp0\files\signapk.jar %installPath% >nul
copy %~dp0\files\install.bat %installPath% >nul
copy %~dp0\files\sign.bat %installPath% >nul
copy %~dp0\files\SignAndInstall.bat %installPath% >nul

:: add script to regedit
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\SignAndInstall /f >nul
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\SignAndInstall\command /t reg_sz /d "C:\Program Files\SignAndInstall\SignAndInstall.bat %%1" /f >nul

reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Install /f >nul
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Install\command /t reg_sz /d "C:\Program Files\SignAndInstall\install.bat %%1" /f >nul

reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Sign /f >nul
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.apk\shell\Sign\command /t reg_sz /d "C:\Program Files\SignAndInstall\sign.bat %%1" /f >nul

echo Finish.

pause
exit \b 0

:end
pause
exit /b 0