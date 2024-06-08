#!/bin/bash

APP_HOME="${HOME}/.setup-idx"
APP_PATH="${APP_HOME}/app"

indexOptions=(
  "Walkthrough all"
  "Preconfigure IDX"
  "Only Setup SSH Keys"
  "Only Setup Services"
  "Update"
  "Uninstall"
  "Exit"
)

PS3="🚦 Please select an option: "

select opt in "${indexOptions[@]}"; do
  echo -e "👉 $opt selected.\n"
  
  case $opt in
    "Walkthrough all")
      ${APP_PATH}/ide.sh
      sleep 2
      ${APP_PATH}/git.sh
      sleep 2
      ${APP_PATH}/services.sh
      break
      ;;
    "Preconfigure IDX")
      ${APP_PATH}/ide.sh
      break
      ;;
    "Only Setup SSH Keys")
      ${APP_PATH}/git.sh
      break
      ;;
    "Only Setup Services")
      ${APP_PATH}/services.sh
      break
      ;;
    "Update")
      ${APP_PATH}/update_setup-idx.sh
      echo -e "🚀 Setup IDX has been updated!\n"
      exit 0
      break
      ;;
    "Uninstall")
      ${APP_PATH}/uninstall_setup-idx.sh
      echo -e "🚀 Setup IDX has been uninstalled!\n"
      exit 0
      break
      ;;
    "Exit")
      echo -e "🥰 Have a great day!"
      exit 0
      break
      ;;
  esac
  echo -e "💡 All done, have fun to KODING!\n"
  exit 0
done

exit 0
