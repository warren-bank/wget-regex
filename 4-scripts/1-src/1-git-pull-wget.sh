#!/usr/bin/env bash

# https://www.atlassian.com/blog/git/alternatives-to-git-submodule-git-subtree

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git_repo_root="${DIR}/../.."
cd "$git_repo_root"

wget_prefix='1-src/wget'
wget_remote='https://git.savannah.gnu.org/git/wget.git'

if [ -d "$wget_prefix" ]; then
  git_op='pull'
else
  git_op='add'
fi

git_version='1.20.1'
git_tag="v${git_version}"
git_dev_branch="dev-git-tag-${git_version}"

git checkout -b "$git_dev_branch"

git subtree $git_op --prefix "$wget_prefix" "$wget_remote" "$git_tag" --squash

git tag "$git_tag"
