#!/bin/bash

if [ -d ./.setup-idx ]; then rm -rf ./.setup-idx; fi;
git clone --depth 1 https://github.com/sikancil/setup-idx.git .setup-idx

echo "Adding to PATH will easy to call later by call:"
echo -e "$  setup-idx\n"
echo "Otherwise you will call it by:"
echo -e "$  ./.setup-idx/cmd/setup-idx\n"
read -rp "❓ Add to PATH? (Yes/No): " ADD_TO_PATH

ADD_TO_PATH=$(echo "$ADD_TO_PATH" | tr '[:upper:]' '[:lower:]')
if [ "$REPLACE_IDX_DEV" = "yes" ] || [ "$REPLACE_IDX_DEV" = "y" ]; then
  echo "export PATH=\"$(pwd)/.setup-idx/cmd/setup-idx:\$PATH\"" >> ~/.bashrc
  echo "Done! Added to PATH."
fi
