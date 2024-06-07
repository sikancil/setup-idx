#!/bin/bash

if [ -d ./.setup-idx ]; then rm -rf ./.setup-idx; fi;

echo "Please remove manually this content from PATH in ${HOME}/.bashrc\n"
echo -e "$(pwd)/.setup-idx/cmd/setup-idx\n"
