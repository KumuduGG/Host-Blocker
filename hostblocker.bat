@echo off
set /a _Debug=0
::==========================================
:: Get Administrator Rights
set _Args=%*
if "%~1" NEQ "" (
  set _Args=%_Args:"=%
)
fltmc 1>nul 2>nul || (
  cd /d "%~dp0"
  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~dp0"" && ""%~dpnx0"" ""%_Args%""", "", "runas", 1 > "%temp%\GetAdmin.vbs"
  "%temp%\GetAdmin.vbs"
  del /f /q "%temp%\GetAdmin.vbs" 1>nul 2>nul
  exit
)
::==========================================
@shift /0
CLS
@COLOR b
@echo off
setlocal EnableDelayedExpansion

REM Check if the script is run as administrator
>nul 2>&1 net session
if %errorlevel% neq 0 (
    echo Please run this script as an administrator.
    pause
    exit
)

set "hosts_file=%SystemRoot%\System32\drivers\etc\hosts"

set /p "input_url=Enter the URL you want to block: "

REM Validate if the input URL is not empty
if "!input_url!" == "" (
    echo URL cannot be empty. Exiting...
    pause
    exit /b
)

REM Check if the URL is already blocked in the hosts file
findstr /i /c:" 0.0.0.0 !input_url!" "%hosts_file%" >nul
if %errorlevel% equ 0 (
    echo URL is already blocked in the hosts file.
    pause
    exit /b
)

REM Add the URL to the hosts file to block it
echo ^0.0.0.0	!input_url! >> "%hosts_file%"

echo URL blocked successfully!
pause
