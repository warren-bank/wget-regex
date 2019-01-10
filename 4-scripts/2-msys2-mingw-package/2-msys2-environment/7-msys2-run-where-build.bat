@echo off

set msys2_home=C:\PortableApps\msys64

call "%msys2_home%\msys2_shell.cmd" -msys2 -where "%~dp0..\3-msys2-build"
