#!/bin/bash

docker compose build
docker compose push

sudo ./update-certs.sh

