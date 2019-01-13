#!/usr/bin/env bash

# ---------------------------------------------------------- safety net

echo Do not directly run this script.
echo Use it as a reference only.
echo Some steps need to be run (synchronously) in an external process.

exit 1

# ---------------------------------------------------------- go to common starting point

git checkout -f 'dev-git'

# ---------------------------------------------------------- remove previous work?

git tag -d 'v1.20.1'
git push --delete origin 'v1.20.1'

git branch -d 'dev-git-tag-1.20.1'
git push --delete origin 'dev-git-tag-1.20.1'

# ---------------------------------------------------------- create new work

./4-scripts/1-src/1-git-pull-wget.sh

# make a trivial change to the wget source code:
sed -i '' -e 's/"wget.h"/<wget.h>/' ./1-src/wget/src/main.c

git add --all .
git commit -m 'example: change to wget source code'

./4-scripts/2-msys2-mingw-package/1-prepare-package/2-generate-patch.sh

git add --all .
git commit -m 'example: new patch file'

# ---------------------------------------------------------- compile wget w/ changes

# open MSYS2 environment:
# -----------------------
cmd //C $(realpath './4-scripts/2-msys2-mingw-package/2-msys2-environment/7-msys2-run-where-build.bat')

# in MSYS2 environment:
# ---------------------
# ./2-msys2-build-x64.sh
# ./3-msys2-build-x32.sh

# ---------------------------------------------------------- run tests

cmd //C $(realpath './4-scripts/3-test/2-test-x64.bat')
cmd //C $(realpath './4-scripts/3-test/3-test-x32.bat')

git add --all .
git commit -m 'example: test result log files'

# ---------------------------------------------------------- save a git cheatsheet

git add --all .
git update-index --chmod=+x git-cheatsheet.sh
git commit -m 'example: git cheatsheet'

# ---------------------------------------------------------- push branch to origin

git push -u origin 'dev-git-tag-1.20.1'
git push --tags origin

# ----------------------------------------------------------
