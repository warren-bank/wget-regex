#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mingw_pkg_home="${DIR}/../../../2-msys2-mingw-package"
mingw_pkg_repo="${mingw_pkg_home}/mingw-w64-wget"

#wget_prefix=$(realpath "$mingw_pkg_repo")
#wget_opts="--no-check-certificate -P \"${wget_prefix}\""
wget_opts="--no-check-certificate -P ${mingw_pkg_repo}"

src_repo_URL='https://github.com/Alexpux/MINGW-packages/raw/master/mingw-w64-wget/'

[ -d "${mingw_pkg_repo}" ] && rm -rf "${mingw_pkg_repo}"
mkdir -p "${mingw_pkg_repo}"

wget $wget_opts "${src_repo_URL}/PKGBUILD"
wget $wget_opts "${src_repo_URL}/gettext-reconfigure.patch"
wget $wget_opts "${src_repo_URL}/openssl-windows-cert-store.patch"
wget $wget_opts "${src_repo_URL}/taskbar-progress.patch"
