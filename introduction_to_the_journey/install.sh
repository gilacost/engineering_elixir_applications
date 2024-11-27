#!/usr/bin/env bash

# Install asdf
if [ ! -d "$HOME/.asdf" ]; then
    # git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
    git clone --depth 1 https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    # Determine which shell is being used
    if [ -n "$ZSH_VERSION" ]; then
        # Zsh
        echo -e "\n. $HOME/.asdf/asdf.sh" >> ~/.zshrc
        echo -e "\n. $HOME/.asdf/completions/asdf.bash" >> ~/.zshrc
    elif [ -n "$BASH_VERSION" ]; then
        # Bash
        echo -e "\n. $HOME/.asdf/asdf.sh" >> ~/.bashrc
        echo -e "\n. $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc
    else
        echo "Unsupported shell. This script supports Bash and Zsh."
        exit 1
    fi
fi

# shellcheck disable=SC1091
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source "$HOME/.asdf/asdf.sh"
fi

./scripts/asdf_plugins.sh

echo "Installation complete. Please restart your terminal or source your profile file."
