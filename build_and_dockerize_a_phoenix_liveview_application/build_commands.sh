#!/usr/bin/env bash

set -ex

PROJECT_REPO_FLDR=kanban

# TODO replace beamops for PROJECT_REPO_FLDR everywhere

rm -rf $PROJECT_REPO_FLDR

# ## INSTALLING PHOENIX AND BUILDING A RELEASE
# mix archive.install hex phx_new 1.7.0
mix archive.install --force hex phx_new 1.7.0
# mix phx.new $PROJECT_REPO_FLDR --no-ecto
mix phx.new $PROJECT_REPO_FLDR --no-ecto --install
cd $PROJECT_REPO_FLDR || exit

mix phx.gen.release
mix assets.deploy
rm -rf _build/dev/rel/
mix release
# _build/dev/rel/kanban/bin/kanban start
PHX_SERVER=true "_build/dev/rel/$PROJECT_REPO_FLDR/bin/$PROJECT_REPO_FLDR" daemon
sleep 4
# echo "curl --fail localhost:4000 with manual release building"
# curl --fail localhost:4000
pkill beam

# ## BUILDING WITH DOCKER
SECRET_KEY_BASE="$(mix phx.gen.secret)"
cd ../

### ONLY FROM
docker build -f 01_from/Dockerfile --tag beamops:latest 01_from
docker run beamops:latest elixir --version

### FROM WITH ARGUMENTS
docker build -f 02_args/Dockerfile  --tag beamops:latest 02_args
# docker run beamops:latest elixir --version
docker run beamops:latest elixir --version | grep "Elixir 1.16.0"
# docker run beamops:latest cat /etc/os-release
docker run beamops:latest cat /etc/os-release | grep "bullseye"
docker build -f 02_args/Dockerfile \
             --build-arg EX_VSN=1.13.2 \
             --build-arg OTP_VSN=24.3.4.9 \
             --build-arg DEB_VSN=buster-20230202 \
             --tag beamops:latest 02_args
# docker run beamops:latest elixir --version
docker run beamops:latest elixir --version | grep "Elixir 1.13.2"
# docker run beamops:latest cat /etc/os-release
docker run beamops:latest cat /etc/os-release | grep "buster"

## ENTRYPOINT AND INTERACTIVE
# docker run -ti beamops:latest
docker inspect beamops | jq '.[0]["Config"]' # assert with json
# TODO diff <(jq --sort-keys . A.json) <(jq --sort-keys . B.json)

docker run --entrypoint=bash beamops:latest -c ls | grep "opt"

## THE BUILDING STAGE

### DEPS
docker build -f 03_compile_deps/Dockerfile --tag beamops:latest 03_compile_deps
# maybe trigger the layer recreation by changing the deps in the mix file
# docker build -f deps.Dockerfile --tag beamops:latest .
# ...
# docker run -ti --entrypoint=/bin/bash beamops:latest
docker run --entrypoint=/bin/bash beamops:latest -c "ls deps" | grep "phoenix"

### ALL
docker build -f 05_mix_release/Dockerfile --tag beamops:latest 05_mix_release
docker run beamops:latest
# docker run -ti -e SECRET_KEY_BASE=$(mix phx.gen.secret) beamops:latest .
docker run --entrypoint=bash -e SECRET_KEY_BASE="$SECRET_KEY_BASE" beamops:latest -c "env" | grep "SECRET_KEY_BASE"
# docker run -ti -e SECRET_KEY_BASE=$(mix phx.gen.secret) \
#                -e PHX_SERVER=1 beamops:latest
docker run --entrypoint=bash -e SECRET_KEY_BASE="$SECRET_KEY_BASE" \
                             -e PHX_SERVER=1 \
                              beamops:latest -c "env" | grep "SECRET_KEY_BASE\|PHX_SERVER"
# shellcheck disable=SC2046
docker stop $(docker ps -a -q)

# docker run -ti -e SECRET_KEY_BASE="$(mix phx.gen.secret)" \
#                  -e PHX_SERVER=1 \
#                  -p 4000:4000 beamops:latest
docker run -d --entrypoint=_build/prod/rel/$PROJECT_REPO_FLDR/bin/$PROJECT_REPO_FLDR \
                 -e SECRET_KEY_BASE="$SECRET_KEY_BASE" \
                 -e PHX_SERVER=1 \
                 -p 4000:4000 beamops:latest start 
sleep 2
curl --fail localhost:4000
# shellcheck disable=SC2046
docker stop $(docker ps -a -q)
sleep 2

# # ## THE RUNNING STAGE
echo "The running stage"
docker build -f 06_multi_stage/Dockerfile --tag beamops:latest 06_multi_stage
docker run -d -e SECRET_KEY_BASE="$SECRET_KEY_BASE" \
              -e PHX_SERVER=1 \
              -p 4000:4000 beamops:latest
sleep 2
curl --fail localhost:4000
# shellcheck disable=SC2046
docker stop $(docker ps -a -q)
