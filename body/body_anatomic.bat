@echo off
cd image
for /d %%i in (*) do (
    mkdir "%%i\anatomic"
)
