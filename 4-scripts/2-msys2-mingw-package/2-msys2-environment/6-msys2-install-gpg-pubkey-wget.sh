#!/usr/bin/env bash

# https://bbs.archlinux.org/viewtopic.php?id=240225
# http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x08302DB6A2670428
# https://github.com/Alexpux/MSYS2-packages/issues/462
# https://stackoverflow.com/questions/13116457/how-to-make-auto-trust-gpg-public-key

gpg --recv-keys 08302DB6A2670428

gpg --edit-key 1CB27DBC98614B2D5841646D08302DB6A2670428
# gpg> trust
#   Your decision? 5
#   Do you really want to set this key to ultimate trust? (y/N) y
# gpg> quit
