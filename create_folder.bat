@echo off

rem get dir like com.kintina.core...
if [%1] == [] ( 
	set /p dir=Please Input Directory:
) else (
	set dir=%1
)

set slash=\
call set dir=%%dir:.=%slash%%%

set "Directory=%dir%"

md "%Directory%" 2>nul
if not exist "%Directory%\*" (
    echo Failed to create directory "%Directory%"
    pause
    goto :EOF
)

rem Other commands after successful creation of the directory.
endlocal