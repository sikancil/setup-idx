#!/bin/bash

echo "Welcome to setup-idx!"
echo "This will replace your current IDX configuration."

read -p "❓ Continue? (Yes/No): " REPLACE_IDX_DEV

APP_HOME=$HOME/.setup-idx
APP_PATH=$APP_HOME/app
IDX_CONFIG_PATH=$(pwd)/.idx
IDX_CONFIG_FILE=$IDX_CONFIG_PATH/dev.nix

# Convert input to lowercase
REPLACE_IDX_DEV=$(echo "$REPLACE_IDX_DEV" | tr '[:upper:]' '[:lower:]')

# Check if input is "yes" or "y"
if [ "$REPLACE_IDX_DEV" = "yes" ] || [ "$REPLACE_IDX_DEV" = "y" ]; then
  if [ ! -d $(pwd)/.idx ]; then mkdir $(pwd)/.idx/; fi;
  
  cp "${APP_PATH}/.idx/dev.nix" "${IDX_CONFIG_FILE}"
  echo "🚀 IDX configuration has been replaced!"
  echo "Please Rebuild Environment in IDX Platform!"
fi
