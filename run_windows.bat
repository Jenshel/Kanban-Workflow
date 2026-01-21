@echo off
REM Script para ejecutar Flutter en Windows con Visual Studio 2026

setlocal enabledelayedexpansion

REM Establecer el generador de CMake
set CMAKE_GENERATOR=Visual Studio 18 2025

REM Cambiar al directorio del proyecto
cd /d "d:\PersonalApp\kanban_app"

REM Ejecutar Flutter
flutter run -d windows

endlocal
pause
