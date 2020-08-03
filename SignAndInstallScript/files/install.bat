@echo off
set apkName=%1
::install apk
echo Waiting for device connection...
adb wait-for-device
echo Device connected.
adb install -r %apkName%
if %errorlevel%==0 (goto end) else (pause)

:end
exit /b 0