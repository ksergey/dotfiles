#!/bin/bash

url="$1"

yt-dlp -f 'ba' -x --audio-format mp3 "${url}"
