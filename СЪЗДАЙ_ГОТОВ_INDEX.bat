@echo off
chcp 65001 >nul
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0СЪЗДАЙ_ГОТОВ_INDEX.ps1"
