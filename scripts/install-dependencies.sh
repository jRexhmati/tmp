#!/usr/bin/env bash

echo "Install Main APP node_modules"
rm -rf node_modules
yarn install

echo "Install AUTH APP node_modules"
cd ./apps/auth
rm -rf node_modules
yarn install
cd ../../

echo "Install RECRUITMNET APP node_modules"
cd ./apps/recruitment
rm -rf node_modules
yarn install
cd ../../

echo "Install SETTINGS APP node_modules"
cd ./apps/settings
rm -rf node_modules
yarn install
cd ../../

echo "Install CONTENT APP node_modules"
cd ./apps/content
rm -rf node_modules
yarn install
cd ../../

echo "Install WORKERS APP node_modules"
cd ./apps/workers
rm -rf node_modules
yarn install
yarn generate:schema
cd ../../
