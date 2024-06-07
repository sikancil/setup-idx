#!/bin/bash

SSH_PERSONAL_PATH="./.ssh"
if [ ! -d $SSH_PERSONAL_PATH ]; then mkdir $SSH_PERSONAL_PATH; else echo "(i) SSH personal directory exist"; fi

# Define the keysOptions
keysOptions=("Generate SSH Keys" "Provide SSH Keys")

# Display the prompt
PS3="Please select an option: "
# Read the user's selection
select opt in "${keysOptions[@]}"; do
  echo -e ">> $opt selected.\n"

  case $opt in
    "Generate SSH Keys")
      # Get the user's email
      read -p "Enter your email address: " USER_EMAIL

      # Get the key name
      read -p "Enter the key name (default: ${USER}@$(hostname)): " KEY_NAME
      if [ -z "$KEY_NAME" ]; then
        KEY_NAME="${USER}@$(hostname)"
      fi

      # Generate the SSH key
      ssh-keygen -t ed25519 -C "$USER_EMAIL" -f "$KEY_NAME"
      mv "$(pwd)/${KEY_NAME}" "${SSH_PERSONAL_PATH}/"
      mv "$(pwd)/${KEY_NAME}.pub" "${SSH_PERSONAL_PATH}/"

      echo "SSH key generated successfully."
      break
      ;;
    "Provide SSH Keys")
      # Get the private key
      # read -rp "Paste your Private Key (when done press Ctrl+D): " -d $'\04' PRIVATE_KEY
      echo -e "Paste your Private Key below:"
      IFS= read -d '' -n 1 PRIVATE_KEY   
      while IFS= read -d '' -n 1 -t 1 c
      do
        PRIVATE_KEY+=$c
      done

      # Get the public key
      # read -rp "Paste your Public Key (when done press Ctrl+D): " -d $'\04' PUBLIC_KEY
      echo -e "Paste your Public Key below:"
      IFS= read -d '' -n 1 PUBLIC_KEY   
      while IFS= read -d '' -n 1 -t 1 c
      do
        PUBLIC_KEY+=$c
      done

      # Extract the key name from the public key
      KEY_NAME=$(echo "$PUBLIC_KEY" | grep -oP 'ssh-ed25519 AAA.* \K.*' | cut -d ' ' -f 2)

      # Save the keys to files
      echo "${PRIVATE_KEY}" | grep -c '^$'
      echo "${PUBLIC_KEY}" | grep -c '^$'

      # echo "${PRIVATE_KEY}" | sed -e '/^$/d' > "${SSH_PERSONAL_PATH}/${KEY_NAME}"
      # echo "${PUBLIC_KEY}" | sed -e '/^$/d' > "${SSH_PERSONAL_PATH}/${KEY_NAME}.pub"
      echo "${PRIVATE_KEY}" | awk 'NF' > "${SSH_PERSONAL_PATH}/${KEY_NAME}"
      echo "${PUBLIC_KEY}" | awk 'NF' > "${SSH_PERSONAL_PATH}/${KEY_NAME}.pub"

      echo "SSH keys provided successfully."
      break
      ;;
    *)
      echo "Invalid option. Please select a valid option."
      ;;
  esac
done

PROVIDER_BITBUCKET="\
# BitBucket\n\
Host bitbucket.org\n\
  AddKeysToAgent yes\n\
  PreferredAuthentications publickey\n\
  HostName altssh.bitbucket.org\n\
  IdentityFile ${SSH_PERSONAL_PATH}/${KEY_NAME}\n\
  IgnoreUnknown UseKeychain\n\
  UseKeychain yes\n\
  # Common \"Port\" options: 443 (default; HTTPS)  or  22 (SSH)
  Port 443\n\
  "

PROVIDER_GITHUB="\
# Github\n\
Host github.com\n\
  AddKeysToAgent yes\n\
  PreferredAuthentications publickey\n\
  IdentityFile ${SSH_PERSONAL_PATH}/${KEY_NAME}\n\
  IgnoreUnknown UseKeychain\n\
  UseKeychain yes\n\
  # Common \"Port\" options: 443 (default; HTTPS)  or  22 (SSH)
  Port 443\n\
  "

PROVIDER_GITLAB="\
# GitLab.com\n\
Host gitlab.com\n\
  AddKeysToAgent yes\n\
  PreferredAuthentications publickey\n\
  IdentityFile ${SSH_PERSONAL_PATH}/${KEY_NAME}\n\
  IgnoreUnknown UseKeychain\n\
  UseKeychain yes\n\
  # Common \"Port\" options: 443 (default; HTTPS)  or  22 (SSH)
  Port 443\n\
  "

# Define the options
providerOptions=("Use ONLY with BitBucket" "Use ONLY with Github" "Use ONLY with Gitlab" "Add All Providers")

# Display the prompt
PS3="🚦 Please select an Provider option: "

# Read the user's selection
select opt in "${providerOptions[@]}"; do
  echo "👉 ${keysOptions[@]} selected"

  case $opt in
    "Use ONLY with BitBucket")
      echo -e "${PROVIDER_BITBUCKET}" >> "${SSH_PERSONAL_PATH}/config";
      break
      ;;
    "Use ONLY with Github")
      echo -e "${PROVIDER_GITHUB}" >> "${SSH_PERSONAL_PATH}/config";
      break
      ;;
    "Use ONLY with Gitlab")
      echo -e "${PROVIDER_GITHUB}" >> "${SSH_PERSONAL_PATH}/config";
      break
      ;;
    "Add All Providers")
      echo -e "${PROVIDER_BITBUCKET}\n\n${PROVIDER_GITHUB}\n\n${PROVIDER_GITLAB}" > "${SSH_PERSONAL_PATH}/config";
      break
      ;;
    *)
      echo "Invalid option. Please select a valid option."
      ;;
  esac
done

# Inform if SSH Config was updated
echo -e "👉 SSH Config was updated to preffered Provider(s). Check: ${SSH_PERSONAL_PATH}/config\n"
echo -e "🔑 Now you can continue use git to clone your preferred repository.\n"
