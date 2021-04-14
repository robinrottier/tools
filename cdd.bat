@echo off
setlocal
set fn0=%~fn0
set dp0=%~dp0

if %1. == /e. shift&echo on

if %1. == /h. (
echo.
echo cdd [/l] [alias]
echo /l      print directory instead of cd
echo [alias] name to change directory to
echo.
goto :eof
)

set l=
if %1. == /l. shift&set l=1

set d=%1
if not defined d set d=%cd% &goto :end

rem find alias file...
set af=%dp0%\cdd.txt

if not exist %af% echo Cant find alias file cdd.txt&exit /b 1

for /f "tokens=1*" %%l in ( %af% ) do if "%d%" == "%%l" set d=%%m&goto :done
rem couldnt find alias? just assume its the directory then

rem check for source/respos matching name...
if exist "%USERPROFILE%\source\repos\%d%" set d=%USERPROFILE%\source\repos\%d%&goto :done


:done 

rem if d contains %env% syntax then this will epxand it...(note the "call" to do the double process)
call set d=%d%

if "%d:~0,1%" == "~" set d=%USERPROFILE%%d:~1%

:end
rem exit this bat into new directrory, avoiding issues with set/endlocao by having all on same line
if defined l endlocal&echo %d%&goto :eof
endlocal&cd /d %d%&goto :eof
