@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: ============================================================
::  MAPA_CARPETA.BAT  --  Orquestador del escaneo
::  Autor: NEXUS_CALDERON  |  Version: 2.1
:: ============================================================

set "TARGET=%~1"
if "!TARGET!"=="" set "TARGET=%CD%"

set "EDITOR=notepad.exe"

cls
echo.
echo  ------------------------------------------------------------
echo   GENERADOR DE MAPA DE CARPETAS  v2.1
echo  ------------------------------------------------------------
echo   Ruta objetivo  : "!TARGET!"
echo   Motor PS1      : "%~dp0Mapa_Carpeta.ps1"
echo   Programador    : NEXUS_CALDERON
echo  ------------------------------------------------------------
echo.

if not exist "%~dp0Mapa_Carpeta.ps1" (
    echo  [ERROR] No se encuentra Mapa_Carpeta.ps1 en:
    echo          %~dp0
    echo.
    pause
    exit /b 1
)

if not exist "!TARGET!" (
    echo  [ERROR] La ruta objetivo no existe:
    echo          "!TARGET!"
    echo.
    pause
    exit /b 1
)

echo  [OK] Iniciando escaneo...
echo.

powershell -NoProfile -Command ^
    "Set-ExecutionPolicy Bypass -Scope Process -Force; & '%~dp0Mapa_Carpeta.ps1' -TargetPath '!TARGET!' -EditorPath '!EDITOR!'"

set "EXIT_CODE=!errorlevel!"
if !EXIT_CODE! neq 0 (
    echo.
    echo  [ERROR] El script termino con codigo de salida: !EXIT_CODE!
    echo.
    pause
    exit /b !EXIT_CODE!
)

echo.
echo  ------------------------------------------------------------
echo   Esta ventana se cerrara automaticamente en 7 segundos...
echo  ------------------------------------------------------------
timeout /t 4 /nobreak >nul