#!/usr/bin/env bash

# https://sourceforge.net/projects/msys2/files/Base/i686/
# https://sourceforge.net/projects/msys2/files/Base/x86_64/

msys2_home='/c/PortableApps'
msys2_dname='msys64'

msys2_arch='x86_64'
msys2_fname='msys2-base-x86_64-20180531.tar.xz'
msys2_url="https://sourceforge.net/projects/msys2/files/Base/${msys2_arch}/${msys2_fname}/download"

if [ ! -d "$msys2_home" ]; then
  echo "$(basename "$msys2_home") directory does not exist"
  exit 1
fi

if [ -d "${msys2_home}/${msys2_dname}" ]; then
  echo "${msys2_dname} directory already exists"
  exit 1
fi

wget_opts="-nc --no-check-certificate -O ${msys2_home}/${msys2_fname}"
wget $wget_opts "$msys2_url"

tar -xJf "${msys2_home}/${msys2_fname}" -C "$msys2_home"
rm -f "${msys2_home}/${msys2_fname}"
