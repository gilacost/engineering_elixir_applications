#!/usr/bin/env bash

# in scripts/asdf_plugins.sh

# install necessary plugins
plugins=(
  "github-cli"
  "packer"
  "terraform"
  "awscli"
  "elixir"
  "erlang"
  "postgres"
  "jq"
  "age"
  "sops"
)
for plugin in "${plugins[@]}"; do
    asdf plugin-add "$plugin" || true 
    # the "|| true" ignore errors if a certain plugin already exists
done

echo "Installation complete."
echo "Please restart your terminal or source your profile file."
