@echo off
setlocal enabledelayedexpansion

:: Set the timestamp using the system date and time
for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set datetime=%%i
set TIMESTAMP=%datetime:~0,4%%datetime:~4,2%%datetime:~6,2%_%datetime:~8,2%%datetime:~10,2%

:: Set script directory and backup path (as you can see, i was using xampp)
set SCRIPT_DIR=%~dp0
set BACKUP_PATH=%SCRIPT_DIR%
set MYSQLDUMP_PATH=C:\xampp\mysql\bin\mysqldump.exe 

:: Log the start of the backup process
echo Executando backup em %DATE% %TIME% > "%BACKUP_PATH%\backup_log.txt"
echo Script Directory: %SCRIPT_DIR% >> "%BACKUP_PATH%\backup_log.txt"
echo Backup Path: %BACKUP_PATH% >> "%BACKUP_PATH%\backup_log.txt"
echo MySQL Dump Path: %MYSQLDUMP_PATH% >> "%BACKUP_PATH%\backup_log.txt"

:: Run mysqldump and handle errors (In my case My MySql was using "root" as user and a blank password, if you have a user and password, will need to put it)
"%MYSQLDUMP_PATH%" -u root PutYourDataBaseNameHere > "%BACKUP_PATH%\backup_%TIMESTAMP%.sql" 2>> "%BACKUP_PATH%\backup_log.txt"

if %ERRORLEVEL% neq 0 (
    echo Ocorreu um erro ao tentar fazer o backup. >> "%BACKUP_PATH%\backup_log.txt"
) else (
    echo Backup realizado com sucesso. >> "%BACKUP_PATH%\backup_log.txt"
)

:: Log the end of the backup process
echo Operação concluída em %DATE% %TIME% >> "%BACKUP_PATH%\backup_log.txt"

endlocal
