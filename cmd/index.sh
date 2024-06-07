#!/bin/bash

indexOptions=(
  "Walkthrough all"
  "Preconfigure IDX"
  "Only Setup SSH Keys"
  "Only Setup Services"
  "Exit"
)

PS3="🚦 Please select an option: "

select opt in "${indexOptions[@]}"; do
  echo -e "👉 $opt selected.\n"
  
  case $opt in
    "Walkthrough all")
      $(pwd)/.setup-idx/cmd/ide.sh
      sleep 2
      $(pwd)/.setup-idx/cmd/git.sh
      sleep 2
      $(pwd)/.setup-idx/cmd/services.sh
      break
      ;;
    "Preconfigure IDX")
      $(pwd)/.setup-idx/cmd/ide.sh
      break
      ;;
    "Only Setup SSH Keys")
      $(pwd)/.setup-idx/cmd/git.sh
      break
      ;;
    "Only Setup Services")
      $(pwd)/.setup-idx/cmd/services.sh
      break
      ;;
    "Exit")
      echo -e "🥰 Have a great day!"
      exit 0
  esac
  echo -e "💡 All done, have fun to KODING!\n"
  exit 0
done

exit 0
