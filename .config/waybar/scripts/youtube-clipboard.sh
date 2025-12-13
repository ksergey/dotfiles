#!/usr/bin/env bash

set -euo pipefail

function is_youtube_url {
  [[ "$1" =~ ^(https?://)?(www.)?(youtu.be/|youtube.com/(embed/|v/|watch\?v=|watch\?.+&v=|playlist\?list=))([[:alnum:]|_|-]{11})($|&(.+)?) ]]
}

function update_status {
  CLIPBOARD="$(wl-paste)"

  if is_youtube_url "${CLIPBOARD}"; then
    printf '{"text": "Click to play youtube url via mpv", "class": "%s" }\n' "Click to play" "ready"
  else
    printf '{"text": "No youtube url", "class": "" }\n'
  fi
}

function watch {
  # Exit on pipe gone
  set -euo pipefail

  # Kill all child processes
  trap 'kill $(jobs -p) &> /dev/null' EXIT

  # Watch clipboard
  wl-paste --type text --watch "$0" update_status
}

function launch {
  YOUTUBE_URL="$(wl-paste)"
  if is_youtube_url "${YOUTUBE_URL}"; then
    mpv --wayland-app-id=youtube --keepaspect-window=no "${YOUTUBE_URL}"
  fi
}

"$@"
