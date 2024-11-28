#!/bin/bash

GIT_REPO="https://github.com/coordinate/alist.git"
TAG_NAME=$(git -c 'versionsort.suffix=-' ls-remote --exit-code --refs --sort='version:refname' --tags $GIT_REPO | tail --lines=1 | cut --delimiter='/' --fields=3)

echo "AList - ${TAG_NAME}"
rm -rf ./src
unset GIT_WORK_TREE
git clone $GIT_REPO ./src
rm -rf ./src/.git

mv -f ./src/* ../
rm -rf ./src

cd ../src
go mod edit -replace github.com/alist-org/alist/v3=./
cd ../
go mod edit -replace github.com/djherbis/times@v1.6.0=github.com/jing332/times@latest

