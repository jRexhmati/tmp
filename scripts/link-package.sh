#!/usr/bin/env bash

RED='\033[0;31m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

if [ $# -lt 1 ]; then
    echo -e "${RED}ERROR: missing params${NC}"
    echo "Params are: package-name"
    echo "Usage: yarn link-package \"PACKAGE NAME\""
    exit 1
fi

PACKAGE=$1
echo "Linking ${PACKAGE} to AUTH APP"
cd ./apps/auth
yarn link "${PACKAGE}"
cd ../../

echo "Linking ${PACKAGE} to RECRUITMNET APP"
cd ./apps/recruitment
yarn link "${PACKAGE}"
cd ../../

echo "Linking ${PACKAGE} to SETTINGS APP"
cd ./apps/settings
yarn link "${PACKAGE}"
cd ../../

echo "Linking ${PACKAGE} to CONTENT APP"
cd ./apps/content
yarn link "${PACKAGE}"
cd ../../

echo "Linking ${PACKAGE} to WORKERS APP"
cd ./apps/workers
yarn link "${PACKAGE}"
cd ../../
