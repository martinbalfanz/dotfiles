#!/bin/bash

dotfiles=("chunkwmrc"
          "skhdrc"
          "alacritty.yml"
          "lein"
          "hyper.js")

for file in "${dotfiles[@]}"; do
    source="$(pwd)/${file}"
    dest="${HOME}/.${file}"

    if [ -L "$dest" ] && [ -e "$dest" ]; then
        echo "$file already linked"
    else
        ln -sfv "$source" "$dest"
    fi
done


# Übersicht setup
source="$(pwd)/Übersicht"
dest="${HOME}/Library/Application Support/Übersicht"
if [ -L "$dest" ] && [ -e "$dest" ]; then
    echo "Übersicht already linked"
else
    ln -sfv "$(pwd)/Übersicht" "$dest"
fi
