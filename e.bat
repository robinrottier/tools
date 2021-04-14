@echo off
setlocal

set d=%1
if not defined d set d=%cd%
start explorer /e,%d%
