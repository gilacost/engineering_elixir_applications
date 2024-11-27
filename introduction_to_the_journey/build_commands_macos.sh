#!/usr/bin/env bash

set -ex

# Install Homebrew (MacOS package manager) NOT IN CI AS IT IS ALREADY INSTALLED
# brew installed /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# ERLANG ASDF
brew install openssl wxwidgets libxslt fop

# Export PATH with asdf directories included
export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:${PATH}"

./install.sh

asdf install

age --version
aws --version
elixir --version
erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell
gh --version 
packer --version
psql --version
terraform --version

# Install Docker
brew install --cask docker
docker -v

# Spotlight and open Docker (open anyway and accept the license)
# check daemon is running 
# docker ps 
