#!/bin/bash

SERVICES=(
  "MariaDB mariadb:10.5.18-focal"
  "Redis Stack redis-stack:7.2.0-v10"
  "Kafka & Zookeeper cp-kafka:7.4.4 + cp-zookeeper:7.4.4"
  "MariaDB and Redis Stack"
  "MariaDB and Kafka + Zookeeper"
  "All those services"
  "Restart all containers"
  "Remove all containers"
  "Exit!"
)

# Display options
echo "🐳 Do you require to run any of this sevices?"
echo "1) MariaDB (mariadb:10.5.18-focal)"
echo "2) Redis Stack (redis-stack:7.2.0-v10)"
echo "3) Kafka & Zookeeper (cp-kafka:7.4.4 + cp-zookeeper:7.4.4)"
echo "4) MariaDB and Redis Stack"
echo "5) MariaDB and Kafka + Zookeeper"
echo "6) All those services"
echo "7) Restart all containers"
echo "8) Remove all containers"
echo "9) No services required. Exit!"

COMPOSER=(
  "01__docker-compose-mariadb.yml"
  "02__docker-compose-redis.yml"
  "03__docker-compose-kafka-zookeeper.yml"
  "04__docker-compose-mariadb-redis.yml"
  "05__docker-compose-mariadb-kafka-zookeeper.yml"
  "06__docker-compose-all.yml"
)

APP_HOME=$HOME/.setup-idx
APP_PATH=$APP_HOME/app
SERVICE_ENV_PATH=$APP_PATH/cmd/.env.services
TMP_SERVICES_PATH=$APP_PATH/.services

# Read user input
read -p "🚦 Enter your choice: " choice
echo -e "👉 Deployment: ${SERVICES[$choice]} selected.\n"
echo "$choice"

if [ "$choice" -ge 1 ] && [ "$choice" -le 6 ]; then
  if [ ! -f $SERVICE_ENV_PATH ]; then
    # cp $APP_PATH/cmd/.env.services-example $SERVICE_ENV_PATH;

    # Generate a random hash
    HASH_MARIADB_ROOT_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    HASH_MARIADB_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1)
    HASH_REDIS_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

    # Read the content of the example file
    CONTENT=$(cat ./cmd/.env.services-example)

    # Replace the placeholders with the generated hash
    CONTENT=$(echo "$CONTENT" | sed "s/MARIADB_ROOT_PASSWORD=.*/MARIADB_ROOT_PASSWORD=\"$HASH_MARIADB_ROOT_PASSWORD\"/")
    CONTENT=$(echo "$CONTENT" | sed "s/MARIADB_PASSWORD=.*/MARIADB_PASSWORD=\"$HASH_MARIADB_PASSWORD\"/")
    CONTENT=$(echo "$CONTENT" | sed "s/REDIS_ARGS=.*/REDIS_ARGS=\"--requirepass $HASH_REDIS_PASSWORD\"/")

    # Save the modified content to the new file
    echo "$CONTENT" > $TMP_SERVICES_PATH
  fi
    
  # Get the last modified timestamp of .env.services
  timestamp=$(stat -c %Y $SERVICE_ENV_PATH)

  # Open .env.service file in nano
  read -p "❓ Open Variables configuration file (Yes/No): " OPEN_VARS_FILE

  # Convert input to lowercase
  OPEN_VARS_FILE=$(echo "$OPEN_VARS_FILE" | tr '[:upper:]' '[:lower:]')
  
  # Check if input is "yes" or "y"
  if [ "$OPEN_VARS_FILE" = "yes" ] || [ "$OPEN_VARS_FILE" = "y" ]; then
    nano $SERVICE_ENV_PATH
    
    # Wait until nano exits
    # while [ "$(stat -c %Y $SERVICE_ENV_PATH)" -eq "$timestamp" ]; do
    #   sleep 1
    # done
  fi
  
  # Compare timestamps to check if file was modified
  if [ "$(stat -c %Y $SERVICE_ENV_PATH)" -ge "$timestamp" ]; then
    echo "📝 Variables updated!"
  else
    echo "📝 Variables have not changed!"
  fi;
  echo -e "👉 You can comeback later to check variables in: $SERVICE_ENV_PATH\n"

  # Save user's choice to a file
  echo "${COMPOSER[$choice-1]}" > $TMP_SERVICES_PATH
  # echo "$(cat $TMP_SERVICES_PATH)"
  
  docker compose -f "${APP_PATH}/dockers/$(cat $TMP_SERVICES_PATH)" up -d
  echo -e "🚀 Services has been lanched!\n"
elif [ "$choice" -eq 7 ]; then
  echo "$(cat $TMP_SERVICES_PATH)"
  if [ -f $TMP_SERVICES_PATH ]; then
    docker compose -f "${APP_PATH}/dockers/$(cat $TMP_SERVICES_PATH)" restart
    echo -e "🎷 Services has been restarted!\n"
  else
    echo -e "🚫 No services to restart!\n"
  fi
elif [ "$choice" -eq 8 ]; then
  echo "$(cat $TMP_SERVICES_PATH)"
  if [ -f $TMP_SERVICES_PATH ]; then
    docker compose -f "${APP_PATH}/dockers/$(cat $TMP_SERVICES_PATH)" down --remove-orphans --volumes
    echo -e "⛔️ Services has been shutdown!\n"
  else
    echo -e "🚫 No services to shutdown!\n"
  fi
elif [ "$choice" -eq 9 ]; then
  echo -e "👋 Exiting script...\n"
  exit 0
else
  echo -e "🚫 Invalid choice!\n"
  exit 0
fi
