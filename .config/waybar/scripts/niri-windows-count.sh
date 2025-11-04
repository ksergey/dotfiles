#!/usr/bin/env bash

set -euo pipefail

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
