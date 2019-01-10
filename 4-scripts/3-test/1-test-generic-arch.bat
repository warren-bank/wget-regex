@echo off

if not defined wget_arch (
  echo wget architecture not defined
  exit /B 1
)

set wget_bin=%~dp0..\..\5-bin\%wget_arch%
set wget_crt=%~dp0..\..\5-bin\certs\cacert.pem
set test_input=%~dp0..\..\3-test\1-input
set test_output=%~dp0..\..\3-test\2-output\%wget_arch%
set test_number=

set PATH=%wget_bin%;%PATH%

set devd_home=C:\PortableApps\devd
set devd_options=--port=80 --all
start "web server" "%devd_home%\devd.exe" %devd_options% %test_input%
set url_input="http://localhost:80/page.html"

:test_01
set test_number=01
set prefix=%test_output%\%test_number%
call :prepare_dir
set log="%prefix%\wget.log"
"%wget_bin%\wget.exe" --version >%log% 2>&1

:test_02
set test_number=02
set prefix=%test_output%\%test_number%
call :prepare_dir
set wget_opts=--ca-certificate="%wget_crt%" -P "%prefix%" -nv --content-disposition
set url="https://github.com/warren-bank/wget-regex/archive/c85fa9ee949c65efd5c2fffe3ccc7287ebd107e8.zip"
set log="%prefix%\wget.log"
"%wget_bin%\wget.exe" %wget_opts% %url% >%log% 2>&1

:test_03
set test_number=03
set prefix=%test_output%\%test_number%
call :prepare_dir
set filters=
call :download_website %filters%

:test_04
set test_number=04
set prefix=%test_output%\%test_number%
call :prepare_dir
set filters=--regex_AD=".*local.*"
call :download_website %filters%

:test_05
set test_number=05
set prefix=%test_output%\%test_number%
call :prepare_dir
set filters=--regex_RD=".*github.*"
call :download_website %filters%

:test_06
set test_number=06
set prefix=%test_output%\%test_number%
call :prepare_dir
set filters=--regex_AP="(next|u)"
call :download_website %filters%

:test_07
set test_number=07
set prefix=%test_output%\%test_number%
call :prepare_dir
set filters=--regex_RP="(next|u)"
call :download_website %filters%

:test_08
set test_number=08
set prefix=%test_output%\%test_number%
call :prepare_dir
set filters=--regex_AU=".*(/page\.html$|/u/.*)"
call :download_website %filters%

:test_09
set test_number=09
set prefix=%test_output%\%test_number%
call :prepare_dir
set filters=--regex_RU=".*(/page\.html$|/u/.*)"
call :download_website %filters%

goto :done

rem :: -----------------------------------------------------

:prepare_dir
  if exist "%prefix%" rmdir /Q /S "%prefix%"
  mkdir "%prefix%"
  goto :eof

:download_website
  set filters=%*
  set wget_opts=-P "%prefix%" --no-check-certificate -e robots=off -v -r -l inf -H -E -k %filters%
  set url=%url_input%
  set log="%prefix%\wget.log"
  "%wget_bin%\wget.exe" %wget_opts% %url% >%log% 2>&1
  goto :eof

rem :: -----------------------------------------------------

:done
