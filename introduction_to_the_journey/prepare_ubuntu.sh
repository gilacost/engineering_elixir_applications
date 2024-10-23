#!/usr/bin/env bash

set -ex

docker build -f Dockerfile  --tag ubuntu-asdf:latest .

docker run ubuntu-asdf:latest age --version
docker run ubuntu-asdf:latest aws --version
docker run ubuntu-asdf:latest elixir --version
docker run ubuntu-asdf:latest erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell
docker run ubuntu-asdf:latest gh --version 
docker run ubuntu-asdf:latest jq --version
docker run ubuntu-asdf:latest packer --version
docker run ubuntu-asdf:latest psql --version
docker run ubuntu-asdf:latest sops --version
docker run ubuntu-asdf:latest terraform --version
