#!/usr/bin/env bash

echo "Generate .env for GENERAL"
FILE=.env
if test -f "$FILE"; then
    echo "$FILE exists. Skipping ..."
else
    echo "Generating ..."
    cp env.example .env
fi

echo "Generate .env for AUTH"
cd ./apps/auth
FILE=.env
if test -f "$FILE"; then
    echo "$FILE exists. Skipping ..."
else
    echo "Generating ..."
    cp env.example .env
fi
cd ../../

echo "Generate .env for RECRUITMENT"
cd ./apps/recruitment
FILE=.env
if test -f "$FILE"; then
    echo "$FILE exists. Skipping ..."
else
    echo "Generating ..."
    cp env.example .env
fi
cd ../../

echo "Generate .env for SETTINGS"
cd ./apps/settings
FILE=.env
if test -f "$FILE"; then
    echo "$FILE exists. Skipping ..."
else
    echo "Generating ..."
    cp env.example .env
fi
cd ../../

echo "Generate .env for CONTENT"
cd ./apps/content
FILE=.env
if test -f "$FILE"; then
    echo "$FILE exists. Skipping ..."
else
    echo "Generating ..."
    cp env.example .env
fi
cd ../../

echo "Generate .env for WORKERS"
cd ./apps/workers
FILE=.env
if test -f "$FILE"; then
    echo "$FILE exists. Skipping ..."
else
    echo "Generating ..."
    cp env.example .env
fi
cd ../../
