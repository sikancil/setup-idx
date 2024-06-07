#!/bin/bash

if [ -d ./.setup-idx ]; then rm -rf ./.setup-idx; fi;
git clone --depth 1 https://github.com/sikancil/setup-idx.git .setup-idx

echo "Adding to PATH will easy to call later by call:"
echo "$  setup-idx\n"
echo "Otherwise you will call it by:"
echo "$  ./.setup-idx/cmd/setup-idx"
echo ""

read -p "❓ Add to PATH? (Yes/No): " ADD_TO_PATH

ADD_TO_PATH=$(echo "$ADD_TO_PATH" | tr '[:upper:]' '[:lower:]')
if [ "$ADD_TO_PATH" = "yes" ] || [ "$ADD_TO_PATH" = "y" ]; then
  echo "export PATH=\"$(pwd)/.setup-idx/cmd/setup-idx:\$PATH\"" >> ~/.bashrc
  export PATH="$(pwd)/.setup-idx/cmd/setup-idx:\$PATH"
  source ~/.bashrc
  echo "🚀 NEXT, Run:  setup-idx"
else
  echo "🚀 NEXT, Run:  ./.setup-idx/cmd/setup-idx"
fi
