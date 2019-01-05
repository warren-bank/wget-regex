@echo off

set mingw_home=C:\PortableApps\MinGW
call "%mingw_home%\set_distro_paths.bat"

set wget_src=%~dp0.\1-src\wget-1.11.4

cd /D "%wget_src%"
call configure.bat --mingw

rem :: ----------------------------------------------------- edit:
rem ::  .\1-src\wget-1.11.4\src\Makefile
rem :: ----------------------------------------------------- from:
rem ::    OPENSSL_PATH = ../../openssl-0.9.7c
rem ::    CFLAGS += -I${OPENSSL_PATH}/outinc -DHAVE_SSL
rem ::    LIBS += -L${OPENSSL_PATH}/out -leay32 -lssl32
rem :: ----------------------------------------------------- to:
rem ::    OPENSSL_PATH = ../../openssl-1.0.2q
rem ::    CFLAGS += -I${OPENSSL_PATH}/include -DHAVE_SSL
rem ::    LIBS += -L${OPENSSL_PATH}/lib -leay32 -lssleay32
rem :: ----------------------------------------------------- where:
rem ::  .\1-src\openssl-1.0.2q
rem ::  .\1-src\openssl-1.0.2q\include\openssl\ssl.h
rem ::  .\1-src\openssl-1.0.2q\lib\libeay32.lib
rem ::  .\1-src\openssl-1.0.2q\lib\ssleay32.lib
rem :: -----------------------------------------------------

cd src
mingw32-make SSL=1 REGEX=1

move /Y "wget.exe" "..\..\..\2-bin"
