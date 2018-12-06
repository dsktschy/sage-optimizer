#!/usr/bin/env bash

# Check argument that is directory name of theme to be created
if [ $# -eq 0 ]; then
  echo 'Input directory name of theme to be created, as argument.'
  exit 1
fi
# Detect path to directory contains this script
SCRIPT_DIR=$(cd $(dirname $0); pwd)
# Create theme based Sage
composer create-project roots/sage $1
# Ask path to .crt file for SSL
echo "Path to .crt file for SSL (e.g., /.ssl/localhost.crt)"
read BROWSER_SYNC_HTTPS_CERT
# Ask path to .key file for SSL
echo "Path to .key file for SSL (e.g., /.ssl/localhost.key)"
read BROWSER_SYNC_HTTPS_KEY
# Start sub shell
(
  # Move to theme directory
  cd $1
  # Install and uninstall Node modules
  npm i
  npm i -D ajv@^5.0.0 webpack@^3.11.0 browser-sync-webpack-plugin@^2.2.2
  npm uninstall jquery browsersync-webpack-plugin
  npm audit fix
  # From config.json, pick up values that should not be managed by git
  PUBLIC_PATH_LINE=`grep '"publicPath":' resources/assets/config.json`
  DEV_URL_LINE=`grep '"devUrl":' resources/assets/config.json`
  # Create config-local.json that is not managed by git
  cat <<EOF > resources/assets/config-local.json
{
${PUBLIC_PATH_LINE}
${DEV_URL_LINE}
  "browserSyncHttps": {
    "cert": "${BROWSER_SYNC_HTTPS_CERT}",
    "key": "${BROWSER_SYNC_HTTPS_KEY}"
  }
}
EOF
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
