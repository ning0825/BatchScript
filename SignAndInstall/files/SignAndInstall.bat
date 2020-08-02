@echo off
set jarDir="C:\Program Files\SignAndInstall"
:: sign apk
set apkName=%1
::format time
set timeTag=%time::=.%
set timeTag=%timeTag:~0,-3%
set signedName=%apkName:~0,-4%_%timeTag%_signed.apk

echo Signing %apkName%...
java -jar %jarDir%\signapk.jar %jarDir%\platform.x509.pem %jarDir%\platform.pk8 %apkName% %signedName%
echo Signing finish.

::install apk
echo Waiting for device connection...
adb wait-for-device
echo Device connected.
adb install -r %signedName%
if %errorlevel%==0 (goto end) else (pause)

:end
exit /b 0
