#!/usr/bin/env bash
# =============================================================================
#
# Recommended:
#   git clone https://github.com/martinbalfanz/dotfiles.git ~/.dotfiles
#   cd ~/.dotfiles && ./bootstrap.sh
#
# One-liner:
#   curl -fsSL https://raw.githubusercontent.com/martinbalfanz/dotfiles/main/bootstrap.sh | bash
# =============================================================================

set -euo pipefail

GH_USER="martinbalfanz"

log()  { echo -e "\n\033[1;34m==>\033[0m $*"; }
ok()   { echo -e "\033[1;32m  ✔\033[0m $*"; }
warn() { echo -e "\033[1;33m  !\033[0m $*"; }
die()  { echo -e "\033[1;31m  ✘\033[0m $*" >&2; exit 1; }

install_prerequisites() {
    log "Installing prerequisites"

    # -- macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then

        # Xcode CLI tools provide git, make, curl, etc.
        if ! xcode-select -p &>/dev/null; then
            log "Installing Xcode Command Line Tools"
            xcode-select --install
            until xcode-select -p &>/dev/null; do sleep 5; done
            ok "Xcode CLI tools ready"
        fi

        # Homebrew
        if ! command -v brew &>/dev/null; then
            log "Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            # Apple Silicon
            [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
            # Intel
            [[ -f /usr/local/bin/brew ]] && eval "$(/usr/local/bin/brew shellenv)"
        fi

        brew install git curl

    # -- Fedora
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y git curl

    # -- Arch
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --needed --noconfirm git curl

    # -- Debian / Ubuntu
    elif command -v apt &>/dev/null; then
        sudo apt update && sudo apt install -y git curl

    else
        die "No supported package manager found (dnf/pacman/apt/brew)."
    fi

    ok "Prerequisites ready."
}

init_chezmoi() {
    log "Initialising chezmoi"

    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply "$GH_USER"

    command -v chezmoi &>/dev/null || die "chezmoi not found after install. Please install it manually: https://chezmoi.io/install"
    ok "Chezmoi ready ($(chezmoi --version | head -1))"
}

apply_chezmoi() {
    log "Applying dotfiles and running provisioning scripts"
    chezmoi apply --verbose
}

main() {
    echo ""
    echo "  ╔══════════════════════════════╗"
    echo "  ║       Bootstrap Setup        ║"
    echo "  ╚══════════════════════════════╝"
    echo ""

    install_prerequisites
    init_chezmoi
    apply_chezmoi

    echo ""
    ok "Bootstrap complete! Restart your shell (or reboot on Linux) to apply all changes."
    echo "You can now delete the bootstrap.sh"
    echo ""
    echo "  Useful commands going forward:"
    echo "    chezmoi edit ~/.zshrc      # edit a dotfile"
    echo "    chezmoi diff               # preview changes before applying"
    echo "    chezmoi apply              # apply changes"
    echo "    chezmoi update             # pull latest from repo and apply"
    echo "    chezmoi cd                 # jump into the source directory"
    echo "    chezmoi data               # see all template variables"
    echo ""
}

main