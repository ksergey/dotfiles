#!/bin/bash

shaders=(grayscale paper)
current=$(hyprshade current)

next_shader_index=0

for i in "${!shaders[@]}"; do
  if [[ "${shaders[$i]}" = "${current}" ]]; then
    next_shader_index=$(expr $i + 1)
    break
  fi
done

if [[ ${next_shader_index} < ${#shaders[@]} ]]; then
  hyprshade on ${shaders[${next_shader_index}]}
else
  hyprshade off
fi
