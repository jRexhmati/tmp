#!/usr/bin/env bash

echo "Build JS files for AUTH"
cd ./apps/auth
yarn build
cd ../../

echo "Build JS files for RECRUITMENT"
cd ./apps/recruitment
yarn build
cd ../../

echo "Build JS files for SETTINGS"
cd ./apps/settings
yarn build
cd ../../

echo "Build JS files for CONTENT"
cd ./apps/content
yarn build
cd ../../

echo "Build JS files for WORKERS"
cd ./apps/workers
yarn generate:schema
yarn build
cd ../../
