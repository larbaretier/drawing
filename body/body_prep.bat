@echo off
setlocal enabledelayedexpansion

mkdir "image" 2>nul

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "try { " ^
    "  $json = Get-Content 'body.json' -Raw -Encoding UTF8 -ErrorAction Stop | ConvertFrom-Json; " ^
    "  $json | ForEach-Object { " ^
    "    $nom = $_.nom -replace '[^\p{L}\d_-]','_'; " ^
    "    New-Item -Path 'image' -Name $nom -ItemType Directory -Force -ErrorAction SilentlyContinue " ^
    "  } " ^
    "} catch { " ^
    "  Write-Host 'ERREUR JSON: ' $_.Exception.Message; " ^
    "  exit 1 " ^
    "}"

@echo off
cd image
for /f "delims=" %%D in ('dir /ad /b /s') do (
    mkdir "%%D\cartoon"
    mkdir "%%D\realist"
    mkdir "%%D\photo"
)
