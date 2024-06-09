@echo off
REM Define environment variables
set DB_NAME=HereYouPutTheNameOfTheDataBaseThatWillBeCreated
set MYSQL_PATH=C:\xampp\mysql\bin
set BACKUP_DIR=C:\Path\To\Your\Folder\WithBackups.sql

REM Create databse if doesn't exists
"%MYSQL_PATH%\mysql" --defaults-file=mysql_config.cnf -e "CREATE DATABASE IF NOT EXISTS %DB_NAME%;"

REM Find the newest backup file
for /f "delims=" %%I in ('dir /b /o-d "%BACKUP_DIR%\*.sql"') do (
    set NEWEST_BACKUP=%%I
    goto :found
)

:found
if "%NEWEST_BACKUP%"=="" (
    echo No backup file found.
    pause
    exit /b 1
)

REM Import backup to the database
"%MYSQL_PATH%\mysql" --defaults-file=mysql_config.cnf -f %DB_NAME% < "%BACKUP_DIR%\%NEWEST_BACKUP%"

REM Verificação de erro
if %ERRORLEVEL% neq 0 (
    echo Error to import the database.
    pause
) else (
    echo Database successfully imported from %NEWEST_BACKUP%.
    
)
