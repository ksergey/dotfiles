#!/usr/bin/env bash

hyprctl dispatch exec "kitty --override confirm_os_window_close=0 --class cli-tool -e impala"
