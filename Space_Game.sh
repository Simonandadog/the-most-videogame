#!/bin/sh
printf '\033c\033]0;%s\a' the most videogame
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Space_Game.x86_64" "$@"
