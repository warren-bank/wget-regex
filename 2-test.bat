@echo off

set wget_bin=%~dp0.\2-bin
set test_output=%~dp0.\3-test

set PATH=%wget_bin%;%PATH%

"%wget_bin%\wget.exe" --version
"%wget_bin%\wget.exe" --ca-certificate="%wget_bin%\certs\cacert.pem" -P "%test_output%" --content-disposition "https://github.com/warren-bank/electron-starter-app/archive/master.zip" >"%test_output%\electron-starter-app-master.log" 2>&1
