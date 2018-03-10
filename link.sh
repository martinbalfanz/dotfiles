#/bin/sh

dotfiles=("chunkwmrc"
          "skhdrc"
          "alacritty.yml")

for file in "${dotfiles[@]}"; do
    ln -sf "`pwd`/${file}" "${HOME}/.${file}"
done
