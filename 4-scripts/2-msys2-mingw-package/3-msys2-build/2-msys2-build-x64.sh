#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# -------------------------------------------------------------------- build package:

mingw_pkg_home="${DIR}/../../../2-msys2-mingw-package"
mingw_pkg_repo="${mingw_pkg_home}/mingw-w64-wget"

# https://github.com/msys2/msys2/wiki/Creating-Packages

cd "$mingw_pkg_repo"
MINGW_INSTALLS=mingw64 makepkg-mingw -sCLf

# -------------------------------------------------------------------- bundle exe w/ dll(s):

msys2_home='/c/PortableApps/msys64'

bin_exe_dir="${DIR}/../../../5-bin/x64"
[ -d "$bin_exe_dir" ] && rm -rf "$bin_exe_dir"
mkdir -p "$bin_exe_dir"

cp "${mingw_pkg_repo}/pkg/mingw-w64-x86_64-wget/mingw64/bin/wget.exe" "$bin_exe_dir"

cp "${msys2_home}/mingw64/bin/libassuan-0.dll"       "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libcares-3.dll"        "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libcrypto-1_1-x64.dll" "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libexpat-1.dll"        "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libgpg-error-0.dll"    "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libgpgme-11.dll"       "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libiconv-2.dll"        "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libidn2-4.dll"         "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libintl-8.dll"         "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libmetalink-3.dll"     "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libpcre2-8-0.dll"      "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libpsl-5.dll"          "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libssl-1_1-x64.dll"    "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libunistring-2.dll"    "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/libwinpthread-1.dll"   "$bin_exe_dir"
cp "${msys2_home}/mingw64/bin/zlib1.dll"             "$bin_exe_dir"

# -------------------------------------------------------------------- run exe:

"${bin_exe_dir}/wget.exe" --version

# -------------------------------------------------------------------- install package:

pacman -U mingw-w64-*-wget-*-any.pkg.tar.xz
