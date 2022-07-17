#!/usr/bin/env bash

function command_exists () {
  type "$1" &> /dev/null ;
}

if command_exists mkcert ; then
  mkcert -cert-file ./certs/server.crt -key-file ./certs/server.key localhost
else
  openssl req -nodes -new -x509 -keyout ./certs/server.key -out ./certs/server.crt -subj '/C=UK/ST=Leeds/L=Leeds/CN=localhost'
fi