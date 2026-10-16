#!/usr/bin/env bash

PACKAGES=(alacritty bash i3 nvim picom polybar rofi scripts tmux x)
TARGET="$HOME"
WALLPAPERS_TARGET="$HOME/wallpapers"

usage() {
	cat << _EOF_
Usage: bash $0 [OPTION]

OPTIONS:
	-h, --help
		Print this message.
	-i, --install
		Install all config files. This is the default option.
	-d, --delete
		Delete all config files.
	-p, --preview
		Preview changes to target directory.
_EOF_
}

install_dots() {
	# install everything except wallpapers package
	stow --target="$TARGET" --dotfiles -S "${PACKAGES[@]}"

	# install wallpapers package
	mkdir -p "$WALLPAPERS_TARGET"
	stow --target="$WALLPAPERS_TARGET" -S wallpapers
}

preview_dots() {
	# there is no reason to preview wallpapers stowing
	stow --target="$TARGET" --dotfiles -n -v "${PACKAGES[@]}"
}

delete_dots() {
	stow --target="$TARGET" --dotfiles -D "${PACKAGES[@]}"
	stow --target="$WALLPAPERS_TARGET" -D wallpapers
}

case "$#" in
	0 )
		install_dots
		;;
	1 )
		case "$1" in
			-h | --help )
				usage
				;;
			-i | --install )
				install_dots
				;;
			-d | --delete )
				delete_dots
				;;
			-p | --preview )
				preview_dots
				;;
			* )
				usage
				exit 1
				;;
		esac
		;;
	* )
		usage
		exit 1
		;;
esac
