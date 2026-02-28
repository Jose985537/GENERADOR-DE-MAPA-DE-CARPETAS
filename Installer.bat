@echo off
setlocal enabledelayedexpansion
title GENERADOR DE MAPA DE CARPETAS - INSTALADOR v2.0

:: ============================================================
::  INSTALLER.BAT  --  Registro dinamico en menu contextual
::  Autor: NEXUS_CALDERON  |  Version: 2.0
::  NOTA: Las rutas se resuelven dinamicamente.
::        NO usar MapaCarpeta_Install.reg (obsoleto).
:: ============================================================

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  [ADVERTENCIA] Se requieren permisos de administrador.
    echo  Solicitando elevacion automatica...
    echo.
    powershell -NoProfile -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cls
echo.
echo  ------------------------------------------------------------
echo   GENERADOR DE MAPA DE CARPETAS  -  INSTALADOR v2.0
echo  ------------------------------------------------------------
echo.

set "CUR_DIR=%~dp0"
if "%CUR_DIR:~-1%"=="\" set "CUR_DIR=%CUR_DIR:~0,-1%"

set "BAT_PATH=%CUR_DIR%\Mapa_Carpeta.bat"
set "PS1_PATH=%CUR_DIR%\Mapa_Carpeta.ps1"
set "ICON_PATH=%CUR_DIR%\ico.ico"

echo  [INFO] Directorio de instalacion : %CUR_DIR%
echo  [INFO] Lanzador BAT              : %BAT_PATH%
echo  [INFO] Motor PowerShell          : %PS1_PATH%
echo.

set "MISSING=0"
if not exist "%BAT_PATH%" ( echo  [ERROR] Falta: Mapa_Carpeta.bat & set "MISSING=1" )
if not exist "%PS1_PATH%" ( echo  [ERROR] Falta: Mapa_Carpeta.ps1 & set "MISSING=1" )
if "!MISSING!"=="1" (
    echo.
    echo  Instale el paquete completo y reintente.
    echo.
    pause
    exit /b 1
)

echo  [OK] Archivos verificados correctamente
echo.

set "ICON_VALUE=%ICON_PATH%"
if not exist "%ICON_PATH%" (
    echo  [AVISO] ico.ico no encontrado. Usando icono del sistema.
    set "ICON_VALUE=imageres.dll,-68"
)

echo  [PROCESO] Registrando en el menu contextual...
echo.

for %%G in (Directory Directory\Background) do (
    set "KEY=HKEY_CLASSES_ROOT\%%G\shell\MapaCarpeta"
    echo   - Configurando: %%G
    reg delete "!KEY!" /f >nul 2>&1
    reg add "!KEY!"          /ve /d "Generar Mapa de Carpeta" /f >nul
    reg add "!KEY!"          /v "Icon" /d "!ICON_VALUE!"      /f >nul
    if "%%G"=="Directory" (
        reg add "!KEY!\command" /ve /d "cmd.exe /c \"\"%BAT_PATH%\" \"%%1\"\"" /f >nul
    ) else (
        reg add "!KEY!\command" /ve /d "cmd.exe /c \"\"%BAT_PATH%\" \"%%V\"\"" /f >nul
    )
)

echo.
echo  ------------------------------------------------------------
echo   [EXITO] Instalacion completada correctamente
echo  ------------------------------------------------------------
echo.
echo   Haz clic derecho en cualquier carpeta y selecciona:
echo   "Generar Mapa de Carpeta"
echo.
echo  ------------------------------------------------------------
echo.
pause