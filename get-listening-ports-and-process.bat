@echo off
for /f "tokens=2,5" %%t in ( 'netstat -aon ^| find "LISTEN"' ) do (
for /f %%p in ( 'tasklist /fi "pid eq %%u" /fo csv /nh' ) do echo %%t %%p
)