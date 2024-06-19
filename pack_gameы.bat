@echo off
chcp 65001 > nul

REM Set path to FreeArc
set "FreeArcPath=c:\FreeArc\bin\FreeArc.exe"

REM Prompt user to input paths for Archive and Files folders
set /p "ArchivePath=Введите путь к папке для архивов: "
set /p "FilesPath=Введите путь к папке с файлами: "

REM Validate if paths end with a backslash (\) and remove if present
if "%ArchivePath:~-1%"=="\" set "ArchivePath=%ArchivePath:~0,-1%"
if "%FilesPath:~-1%"=="\" set "FilesPath=%FilesPath:~0,-1%"

REM Check if the paths entered are valid
if not exist "%ArchivePath%\" (
    echo Путь к папке для архивов не найден: "%ArchivePath%"
    pause
    exit /b 1
)

if not exist "%FilesPath%\" (
    echo Путь к папке с файлами не найден: "%FilesPath%"
    pause
    exit /b 1
)

REM Menu for choosing archive size
echo.
echo Выберите размер архива (в гигабайтах):
echo [1] - 2 ГБ
echo [2] - 2.5 ГБ
echo [3] - 4.5 ГБ
echo [4] - 5 ГБ
echo [5] - 7 ГБ

set /p ArchiveSizeChoice="Введите номер размера архива (1-5): "

REM Validate user input and set archive size in bytes
if "%ArchiveSizeChoice%"=="1" set /a ArchiveSizeBytes=2*1024*1024*1024
if "%ArchiveSizeChoice%"=="2" set /a ArchiveSizeBytes=2.5*1024*1024*1024
if "%ArchiveSizeChoice%"=="3" set /a ArchiveSizeBytes=4.5*1024*1024*1024
if "%ArchiveSizeChoice%"=="4" set /a ArchiveSizeBytes=5*1024*1024*1024
if "%ArchiveSizeChoice%"=="5" set /a ArchiveSizeBytes=7*1024*1024*1024

REM If user enters an invalid option, default to 4.5 GB
if not "%ArchiveSizeChoice%"=="1" if not "%ArchiveSizeChoice%"=="2" if not "%ArchiveSizeChoice%"=="3" if not "%ArchiveSizeChoice%"=="4" if not "%ArchiveSizeChoice%"=="5" (
    set /a ArchiveSizeBytes=4.5*1024*1024*1024
)

REM Menu for choosing compression level
echo.
echo Выберите уровень сжатия:
echo [1] - Максимальное сжатие (оптимальное)
echo [2] - Очень высокое сжатие
echo [3] - Высокое сжатие (по умолчанию)
echo [4] - Среднее сжатие
echo [5] - Низкое сжатие
echo [6] - Очень низкое сжатие (быстрое)

set /p CompressionLevel="Введите номер уровня сжатия (1-6): "

REM Validate user input and set compression flag
if "%CompressionLevel%"=="1" (
    set CompressionFlag=-m0
    set CompressionLevelName=Максимальное сжатие (оптимальное)
)
if "%CompressionLevel%"=="2" (
    set CompressionFlag=-m1
    set CompressionLevelName=Очень высокое сжатие
)
if "%CompressionLevel%"=="3" (
    set CompressionFlag=-m2
    set CompressionLevelName=Высокое сжатие (по умолчанию)
)
if "%CompressionLevel%"=="4" (
    set CompressionFlag=-m3
    set CompressionLevelName=Среднее сжатие
)
if "%CompressionLevel%"=="5" (
    set CompressionFlag=-m4
    set CompressionLevelName=Низкое сжатие
)
if "%CompressionLevel%"=="6" (
    set CompressionFlag=-m5
    set CompressionLevelName=Очень низкое сжатие (быстрое)
)

REM If user enters an invalid option, default to -m2 (high compression)
if not "%CompressionLevel%"=="1" if not "%CompressionLevel%"=="2" if not "%CompressionLevel%"=="3" if not "%CompressionLevel%"=="4" if not "%CompressionLevel%"=="5" if not "%CompressionLevel%"=="6" (
    set CompressionFlag=-m2
    set CompressionLevelName=Высокое сжатие (по умолчанию)
)

echo.
echo Упаковка файлов с выбранным уровнем сжатия: %CompressionLevelName%
echo.

REM Loop through all subdirectories in FilesPath and compress files
for /d %%i in ("%FilesPath%\*") do (
    echo Упаковка файлов из %%~nxi...
    "%FreeArcPath%" a -s%ArchiveSizeBytes% -r %CompressionFlag% -ep1 "%ArchivePath%\temp\data-%%~nxi.arc" "%%i\*"
)

echo.
echo Перемещение архивов...

REM Move temporary archives to the main directory
move /y "%ArchivePath%\temp\*.arc" "%ArchivePath%"

echo Перемещение завершено.

echo.
echo Удаление временного каталога...

REM Delete the temporary directory
rmdir /s /q "%ArchivePath%\temp"

echo Удаление временного каталога завершено.

echo.
echo Упаковка и перемещение файлов завершены.

pause
exit /b
