#!/usr/bin/bash

cd "$(dirname "$0")"

#sudo docker compose -f ./docker-compose-7861.yml --profile comfy down

konsole -e sudo docker compose -f ./docker-compose-7861.yml --profile comfy up --build
# sudo docker compose -f ./docker-compose-7861.yml --profile comfy up --build

# sudo docker compose -f ./docker-compose-7861.yml --profile comfy build
# sudo docker compose -f ./docker-compose-7861.yml --profile comfy run comfy bash
