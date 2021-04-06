@echo off
setlocal

set a=%1 %2 %3 %4 %5 %6 %7 %8 %9
set x=notepad.exe
if exist "C:\Program Files\Notepad++\notepad++.exe" set x="C:\Program Files\Notepad++\notepad++.exe"
start "" %x% %a%
