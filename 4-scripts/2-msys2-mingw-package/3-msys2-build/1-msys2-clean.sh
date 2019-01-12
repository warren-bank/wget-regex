#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mingw_pkg_home="${DIR}/../../../2-msys2-mingw-package"
mingw_pkg_repo="${mingw_pkg_home}/mingw-w64-wget"

cd "$mingw_pkg_repo"

rm -rf src
rm -rf pkg
rm -f mingw-w64-* wget-*
