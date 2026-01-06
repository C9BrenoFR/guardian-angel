#!/bin/sh
printf '\033c\033]0;%s\a' Guardian angel
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Guardian angel- Easy Mode.x86_64" "$@"
