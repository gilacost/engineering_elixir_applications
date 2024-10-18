#!/usr/bin/env bash
#
set -xe

PROJECT_NAME=kanban
export WEB_IMAGE="${PROJECT_NAME}:latest"

# Clean up

docker rm -f postgres
docker rm -f elixir
docker rm -f elixirMigrator
docker network rm "${PROJECT_NAME}_network" || true
for dir in 02_postgres_simple 03_postgres_ports_published_hardcoded 04_postgres_ports_published 05_postgres_pinned_version 06_postgres_explicit_volume 07_adding_your_phoenix_app 08_update_your_ci_pipeline 09_extra_mile
do
  (cd "$dir" && docker compose down -v)
done
docker swarm leave --force || true

rm -rf $PROJECT_NAME
mix archive.install --force hex phx_new 1.7.0
# mix phx.new $PROJECT_NAME --install, this time with ecto
mix phx.new $PROJECT_NAME --install
cd $PROJECT_NAME || exit

mix phx.gen.release --docker

docker build -t "${WEB_IMAGE}" .
# This will produce and error about the ENV var user_name not being set 
set +e
OUTPUT=$(docker run "${WEB_IMAGE}" 2>&1)
status=$?
if [ $status -eq 0 ]; then
  echo "Docker run should've failed"
  exit 1
else
  echo "$OUTPUT"
fi
set -xe

docker run --name postgres -e POSTGRES_PASSWORD=postgres -d postgres
docker run --name elixir \
           -e DATABASE_URL=ecto://postgres:postgres@postgres/postgres \
           -e SECRET_KEY_BASE="$(mix phx.gen.secret)" \
           -p 4000:4000 \
           -d \
           "${WEB_IMAGE}"
sleep 5
docker logs elixir --tail=1 | grep "failed to connect"
# This 2 commands are actually done via -ti in the book
set +e
OUTPUT=$(docker run tutum/dnsutils ping -c1 "$(docker ps -aqf "name=postgres")")
status=$?
if [ $status -eq 0 ]; then
  echo "ping command using the container id should've not resolved the hostname"
  exit 1
else
  OUTPUT=$(docker run tutum/dnsutils ping -c1 postgres)
  status=$?
  if [ $status -eq 0 ]; then
    echo "ping command using container name should've not resolved the hostname"
    exit 1
  else
    echo "$OUTPUT"
  fi
  echo "$OUTPUT"
fi
set -xe

docker rm -f postgres
docker rm -f elixir

docker network create "${PROJECT_NAME}_network"

docker run --network "${PROJECT_NAME}_network" \
           --name postgres \
           -e POSTGRES_PASSWORD=postgres \
           -d postgres

sleep 5

# CONTAINER_ID=$(docker ps -aqf "name=postgres") 
# docker run --network "${PROJECT_NAME}_network" \
#            tutum/dnsutils ping -c1 "$CONTAINER_ID" | grep "1 received, 0% packet loss"

# docker run --network "${PROJECT_NAME}_network" \
#            tutum/dnsutils ping -c1 postgres | grep "1 received, 0% packet loss"

docker run -e "DATABASE_URL=ecto://postgres:postgres@postgres/postgres" \
           -e SECRET_KEY_BASE="$(mix phx.gen.secret)" \
           --network "${PROJECT_NAME}_network" \
           --name elixir -d \
           "${WEB_IMAGE}"

sleep 5

docker logs elixir --tail=2 | grep ' \[info\] Running '

docker run -e "DATABASE_URL=ecto://postgres:postgres@postgres/postgres" \
           -e SECRET_KEY_BASE="$(mix phx.gen.secret)" \
           --network "${PROJECT_NAME}_network" \
           --name elixirMigrator \
           "${WEB_IMAGE}" "bin/migrate" 

docker logs elixirMigrator --tail=2 | grep "\[info\] Migrations already up"
docker rm -f elixirMigrator elixir postgres
cd ..

##################################################################
##################### DOCKER COMPOSE #############################
##################################################################

# SIMPLE
echo "simple"
pwd
cd 02_postgres_simple
docker compose up -d 
sleep 5
docker compose logs | grep "db-1  | The files"

set +e
sleep 5
OUTPUT=$(psql -h localhost -U postgres 2>&1)
STATUS=$?
if [ $STATUS -eq 0 ]; then
  echo "psql should've failed"
  echo "$OUTPUT"
  exit 1
else
  set -xe
  echo "$OUTPUT" | grep "Connection refused"
fi
set -xe
docker compose down -v
cd ..

# PORTS PUBLISHED
echo "ports published"
cd 04_postgres_ports_published
POSTGRES_PORT=5432:5432 docker compose up -d 
docker compose logs | grep "db-1  | The files"
sleep 5
# The real one
# psql -h localhost -U postgres 
PGPASSWORD=postgres psql -h localhost -U postgres -p 5432 -w -c "SELECT NOW();"

docker compose config
# TODO
docker compose config | grep -v "published\: \"5432\""
POSTGRES_PORT=5432:5432 docker compose config | grep "published\: \"5432\""
docker compose down -v
cd ..

## PINNED VERSIONS
echo "pinned versions"
cd 05_postgres_pinned_version
mix deps.get
POSTGRES_PORT=5432:5432 docker compose up -d
sleep 5
docker compose logs | grep "PostgreSQL 15.2"

## EXPLICIT VOLUMES
echo "explicit volumes"
mix ecto.create | grep "has been created"
docker compose stop
POSTGRES_PORT=5432:5432 docker compose up -d
mix ecto.create | grep "has already been created"
docker compose down
cd ..
cd 06_postgres_explicit_volume
mix deps.get
POSTGRES_PORT=5432:5432 docker compose up -d
sleep 5
mix ecto.create | grep "has been created"
docker compose down
POSTGRES_PORT=5432:5432 docker compose up -d
mix ecto.create | grep "has already been created"
docker compose down -v
cd ..

# TODO login to registry

## FULL COMPOSE 1 
cd 07_adding_your_phoenix_app
docker compose -f compose-incomplete-1.yaml up -d 
sleep 5
docker compose -f compose-incomplete-1.yaml logs | grep "\[info\] Running"
docker compose -f compose-incomplete-1.yaml down -v
## FULL COMPOSE 2 
docker compose -f compose-incomplete-2.yaml up -d 
sleep 5
docker compose -f compose-incomplete-2.yaml logs | grep "\[info\] Running"
# TODO
# docker compose -f ../compose-incomplete-2.yaml logs | grep -v "Migrations already up"
docker compose -f compose-incomplete-2.yaml down -v
## FULL COMPOSE 3 
docker compose -f compose.yaml up -d 
sleep 5 # TODO wait for grep Running
docker compose -f compose.yaml logs | grep "\[info\] Running"
docker compose -f compose.yaml logs | grep "Migrations already up"
docker compose -f compose.yaml down -v

# THE DOCKER SWARM
docker swarm init --listen-addr "0.0.0.0:2377" | grep "Swarm initialized"
docker service ls # nada TODO 
docker node ls # 1 node TODO
# TWEAK the compose 
# TODO
# docker stack deploy -c ../compose.yaml "${PROJECT_NAME}" # TODO | grep "Ignoring unsupported options: restart"
# docker stack rm "${PROJECT_NAME}"
docker stack deploy -c compose.yaml "${PROJECT_NAME}"
docker service ls # has two service TODO
docker service inspect --pretty "${PROJECT_NAME}_web" # TODO
# CLEANUP
docker swarm leave --force 
