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
      ${APP_HOME}/ide.sh
      sleep 2
      ${APP_HOME}/git.sh
      sleep 2
      ${APP_HOME}/services.sh
      break
      ;;
    "Preconfigure IDX")
      ${APP_HOME}/ide.sh
      break
      ;;
    "Only Setup SSH Keys")
      ${APP_HOME}/git.sh
      break
      ;;
    "Only Setup Services")
      ${APP_HOME}/services.sh
      break
      ;;
    "Update")
      ${APP_HOME}/update_setup-idx
      echo -e "🚀 Setup IDX has been updated!\n"
      exit 0
      break
      ;;
    "Uninstall")
      ${APP_HOME}/uninstall_setup-idx
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
