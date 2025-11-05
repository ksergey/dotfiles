#!/usr/bin/env bash

set -euo pipefail

if ! command -v jq &> /dev/null; then
  echo "jq not found, make sure it installed"
  echo "Install jq: yay -S jq"
  exit 1
fi

focused_id="$(niri msg -j workspaces | jq ".[] | select(.is_focused == true ) | .id")"
count="$(niri msg -j windows | jq "[.[] | select(.workspace_id == ${focused_id})] | length")"

printf "%d\n" "$count"

niri msg event-stream |
  while read -r line; do
    case "${line}" in
      "Window opened"* | "Window closed"* | "Workspace focused"*)
        focused_id="$(niri msg -j workspaces | jq ".[] | select(.is_focused == true ) | .id")"
        count="$(niri msg -j windows | jq "[.[] | select(.workspace_id == ${focused_id})] | length")"
        printf "%d\n" "$count"
        ;;
    esac
  done
