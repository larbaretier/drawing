@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion

set "IMGDIR=image"
set "OUTFILE=image_paths.json"
set "EXTS=jpg jpeg png gif bmp tiff webp"

REM Collect all relative paths into a temp file
set "TMPFILE=%TEMP%\image_paths_tmp.txt"
del "%TMPFILE%" 2>nul

for %%E in (%EXTS%) do (
    for /r "%IMGDIR%" %%F in (*.%%E) do (
        set "relpath=%%F"
        set "relpath=!relpath:%CD%\=!"
        echo !relpath!>> "%TMPFILE%"
    )
)

REM Write to JSON file with commas between elements
echo [ > "%OUTFILE%"
set /a count=0
for /f "usebackq delims=" %%A in ("%TMPFILE%") do (
    set /a count+=1
)
set /a current=0

for /f "usebackq delims=" %%A in ("%TMPFILE%") do (
    set /a current+=1
    set "line=%%A"
    REM Double backslashes for JSON
    set "line=!line:\=\\!"
    if !current! lss !count! (
        echo    "!line!", >> "%OUTFILE%"
    ) else (
        echo    "!line!" >> "%OUTFILE%"
    )
)
echo ] >> "%OUTFILE%"

del "%TMPFILE%"
endlocal
