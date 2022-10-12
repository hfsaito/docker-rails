#!/bin/bash

set -e

docker build -f Dockerfile.setup -t hfsaito/rails:setup.7.0.4 .

docker run --rm \
  -v "$(pwd):/usr/src/app" \
  hfsaito/rails:setup.7.0.4 \
  bash -c "rails new app -d postgresql -j webpack"

echo "Adding postgres data folder to .gitignore..."
echo "db/postgres" >> .gitignore

echo "Setting development database in config/database.yml..."
sed -Ei '' 's/(\s*)(#|\s)\s*username: app/\1username: postgres/g' config/database.yml
sed -Ei '' 's/(\s*)(#|\s)\s*host: localhost/\1host: db/g' config/database.yml
