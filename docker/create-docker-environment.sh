#!/bin/bash

# Check if script is running as root or sudo.
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: You need to execute this script as root/sudo."
  exit 1
fi

# Check if script is running at same folder where it exists.
if [ "$(dirname $0)" != "." ]; then
  echo "Error: You need to execute this command at same folder where it exists. Please, cd into the folder."
  exit 1
fi

# Create symbolic link for main .env file.
rm $(pwd)/../.env
cp $(pwd)/../.env-sample $(pwd)/../.env
ln -sf $(pwd)/../.env .env

# Remove completely the Docker environment.
docker-compose down --volume --remove-orphans --rmi all

# Remove temp files used by containers and application.
rm -Rf $(pwd)/../tmp/*
rm -Rf $(pwd)/../log/*
rm -Rf $(pwd)/../node_modules/
rm -Rf $(pwd)/../public/uploads/
rm -Rf $(pwd)/../public/assets/

# Build the new Docker environment.
docker-compose up --build -d

# Define the application host dinamically, based on port defined for web container.
external_port_of_web_container=$(docker container inspect --format="{{(index (index .NetworkSettings.Ports \"80/tcp\") 0).HostPort}}" trabalho_ach2077_web_1)
sed -i "/SMTP_APPLICATION_HOST=/c\SMTP_APPLICATION_HOST='http://localhost:$external_port_of_web_container'" $(pwd)/../.env
docker container restart trabalho_ach2077_app_1

# Creates the database and some initial dummy data.
docker-compose exec app bundle exec rails db:drop
docker-compose exec app bundle exec rails db:create
docker-compose exec app bundle exec rails db:migrate

external_port_of_mailer_container=$(docker container inspect --format="{{(index (index .NetworkSettings.Ports \"1080/tcp\") 0).HostPort}}" trabalho_ach2077_mailer_1)
echo "Your docker environment was created! Access now:"
echo "Rails application -> http://localhost:$external_port_of_web_container"
echo "Mailer UI -> http://localhost:$external_port_of_mailer_container"
