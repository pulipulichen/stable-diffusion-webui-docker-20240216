#!/usr/bin/bash

cd "$(dirname "$0")"

sudo docker compose --profile auto down


#konsole -e sudo docker compose --profile auto up
# sudo docker compose --profile auto run auto bash
sudo docker compose --profile auto up

