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
