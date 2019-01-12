#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git_repo_root="${DIR}/../../.."
cd "$git_repo_root"

wget_prefix='1-src/wget'

mingw_pkg_home="${DIR}/../../../2-msys2-mingw-package"
mingw_pkg_repo="${mingw_pkg_home}/mingw-w64-wget"

git_version='1.20.1'
git_tag="v${git_version}"
git_dev_branch="dev-git-tag-${git_version}"

git diff --no-ext-diff --no-color --patch --relative="$wget_prefix" "$git_tag" "$git_dev_branch" >"${mingw_pkg_repo}/git-diff.patch"
