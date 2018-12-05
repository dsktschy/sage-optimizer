#!/usr/bin/env bash

# Ask directory name of theme to be created
echo 'Input directory name of theme to be created.'
read BASENAME
# Ask site domain of local development hostname
echo 'Input site domain of local development hostname.'
read DEVURL
# Ask path to .crt file for SSL
echo 'Input path to .crt file for SSL.'
read BROWSER_SYNC_HTTPS_CERT
# Ask path to .key file for SSL
echo 'Input path to .key file for SSL.'
read BROWSER_SYNC_HTTPS_KEY
# Detect path to directory contains this script
SCRIPT_DIR=$(cd $(dirname $0); pwd)
# Create theme based Sage
composer create-project roots/sage ${BASENAME}
# Start sub shell
(
  # Move to theme directory
  cd ${BASENAME}
  # Create .env from variables
  echo SAGE_DIST_PATH=/wp-content/themes/${BASENAME}/dist >> .env
  echo DEVURL=${DEVURL} >> .env
  echo BROWSER_SYNC_HTTPS_CERT=${BROWSER_SYNC_HTTPS_CERT} >> .env
  echo BROWSER_SYNC_HTTPS_KEY=${BROWSER_SYNC_HTTPS_KEY} >> .env
  # Install and uninstall Node modules
  npm i
  npm i -D ajv@^5.0.0 webpack@^3.11.0 dotenv@^6.1.0 browser-sync-webpack-plugin@^2.2.2
  npm uninstall jquery browsersync-webpack-plugin
  npm audit fix
  # Replace and remove files
  \cp -f ${SCRIPT_DIR}/theme/.gitignore .gitignore
  \cp -f ${SCRIPT_DIR}/theme/.eslintrc.js .eslintrc.js
  \cp -f ${SCRIPT_DIR}/theme/app/setup.php app/setup.php
  \cp -f ${SCRIPT_DIR}/theme/resources/assets/build/webpack.config.js resources/assets/build/webpack.config.js
  \cp -f ${SCRIPT_DIR}/theme/resources/assets/build/webpack.config.watch.js resources/assets/build/webpack.config.watch.js
  \cp -f ${SCRIPT_DIR}/theme/resources/assets/config.json resources/assets/config.json
  \cp -f ${SCRIPT_DIR}/theme/resources/assets/scripts/customizer.js resources/assets/scripts/customizer.js
  \cp -f ${SCRIPT_DIR}/theme/resources/assets/scripts/main.js resources/assets/scripts/main.js
  rm resources/assets/build/helpers/hmr-client.js
  rm resources/assets/build/util/addHotMiddleware.js
)
