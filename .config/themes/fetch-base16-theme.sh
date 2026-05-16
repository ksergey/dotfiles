#!/usr/bin/env bash

# Base16 YAML to semantic color palette converter
# Usage: ./fetch-base16-theme.sh https://raw.githubusercontent.com/tinted-theming/schemes/refs/heads/spec-0.11/base16/nord.yaml

set -euo pipefail

# Terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

error() {
    echo -e "${RED}Error:${NC} $1" >&2
    exit 1
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

info() {
    echo -e "${YELLOW}→${NC} $1"
}

# Check arguments
if [ $# -ne 1 ]; then
    error "Usage: $0 <Base16 YAML URL>\nExample: $0 https://raw.githubusercontent.com/tinted-theming/schemes/refs/heads/spec-0.11/base16/nord.yaml"
fi

URL="$1"
TEMP_FILE=$(mktemp)

# Cleanup on exit
trap 'rm -f "$TEMP_FILE"' EXIT

# Download file
info "Downloading: $URL"
if ! curl -fsSL "$URL" -o "$TEMP_FILE"; then
    error "Failed to download file"
fi
success "File downloaded"

# Manual YAML parser (no external dependencies)
declare -A YAML_DATA

parse_yaml() {
    local file="$1"
    local in_palette=0
    local key
    local value
    local indent=""

    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

        # Get indentation level (spaces count)
        local current_indent
        current_indent=$(echo "$line" | sed -E 's/^([[:space:]]*).*/\1/')
        current_indent=${#current_indent}

        # Trim line for processing
        local trimmed="${line#"${line%%[![:space:]]*}"}"

        # Check if we're entering palette section
        if [[ "$trimmed" =~ ^palette:[[:space:]]*$ ]]; then
            in_palette=1
            continue
        fi

        # If we're in palette and indentation decreases, exit palette
        if [ $in_palette -eq 1 ] && [ $current_indent -eq 0 ]; then
            in_palette=0
        fi

        # Process key-value pairs (only top-level or inside palette)
        if [[ "$trimmed" =~ ^([a-zA-Z_][a-zA-Z0-9_]*):[[:space:]]*(.*)$ ]]; then
            key="${BASH_REMATCH[1]}"
            value="${BASH_REMATCH[2]}"

            value=${value%\"*}
            value=${value##*\"}

            # Store if it's a baseXX key (top-level or inside palette)
            YAML_DATA["$key"]="$value"
        fi
    done < "$file"
}

parse_yaml "$TEMP_FILE"

# Extract values
NAME="${YAML_DATA[name]:-Unknown}"
AUTHOR="${YAML_DATA[author]:-Unknown}"
VARIANT="${YAML_DATA[variant]:-dark}"

BASE00="${YAML_DATA[base00]:-}"
BASE01="${YAML_DATA[base01]:-}"
BASE02="${YAML_DATA[base02]:-}"
BASE03="${YAML_DATA[base03]:-}"
BASE04="${YAML_DATA[base04]:-}"
BASE05="${YAML_DATA[base05]:-}"
BASE06="${YAML_DATA[base06]:-}"
BASE07="${YAML_DATA[base07]:-}"
BASE08="${YAML_DATA[base08]:-}"
BASE09="${YAML_DATA[base09]:-}"
BASE0A="${YAML_DATA[base0A]:-}"
BASE0B="${YAML_DATA[base0B]:-}"
BASE0C="${YAML_DATA[base0C]:-}"
BASE0D="${YAML_DATA[base0D]:-}"
BASE0E="${YAML_DATA[base0E]:-}"
BASE0F="${YAML_DATA[base0F]:-}"

# Verify colors were loaded
if [ -z "$BASE00" ]; then
    error "Failed to find base00 in file. Make sure this is a valid Base16 YAML file"
fi

info "Scheme: ${NAME} by ${AUTHOR} (${VARIANT})"
echo ""

NAME="${NAME// /-}"
NAME="${NAME,,}"
ROOT="${HOME}/.config/themes/${NAME}"

mkdir -p "${ROOT}"

CAVA_FILE="${ROOT}/cava-theme"
cat > "$CAVA_FILE" << EOF
# Base16 $NAME for Cava
# Author: $AUTHOR

[color]
gradient = 1
gradient_count = 8
gradient_color_1 = '$BASE0B'
gradient_color_2 = '$BASE0A'
gradient_color_3 = '$BASE09'
gradient_color_4 = '$BASE08'
gradient_color_5 = '$BASE0E'
gradient_color_6 = '$BASE0D'
gradient_color_7 = '$BASE0C'
gradient_color_8 = '$BASE07'
EOF
success "Cava: $CAVA_FILE"

NIRI_FILE="${ROOT}/niri-theme.kdl"
cat > "${NIRI_FILE}" << EOF
layout {
    border {
        active-color "${BASE0D}"
        inactive-color "${BASE02}"
    }
    focus-ring {
        active-color "${BASE0D}"
        inactive-color "${BASE02}"
    }
}
EOF
success "Niri: ${NIRI_FILE}"

# Generate Kitty config
KITTY_FILE="${ROOT}/kitty-theme.conf"
cat > "${KITTY_FILE}" << EOF
# Base16 $NAME for Kitty
# Author: $AUTHOR

background $BASE00
foreground $BASE05
selection_background $BASE0D
selection_foreground $BASE00

# Basic 16 colors
color0 $BASE00
color1 $BASE08
color2 $BASE0B
color3 $BASE0A
color4 $BASE0D
color5 $BASE0E
color6 $BASE0C
color7 $BASE05
color8 $BASE03
color9 $BASE08
color10 $BASE0B
color11 $BASE0A
color12 $BASE0D
color13 $BASE0E
color14 $BASE0C
color15 $BASE06
EOF
success "Kitty: $KITTY_FILE"


ROFI_FILE="${ROOT}/rofi-theme.rasi"
cat > "${ROFI_FILE}" << EOF
* {
    base00: ${BASE00};
    base01: ${BASE01};
    base02: ${BASE02};
    base03: ${BASE03};
    base04: ${BASE04};
    base05: ${BASE05};
    base06: ${BASE06};
    base07: ${BASE07};
    base08: ${BASE08};
    base09: ${BASE09};
    base0A: ${BASE0A};
    base0B: ${BASE0B};
    base0C: ${BASE0C};
    base0D: ${BASE0D};
    base0E: ${BASE0E};
    base0F: ${BASE0F};
}
EOF
success "Rofi: ${ROFI_FILE}"

TMUX_FILE="${ROOT}/tmux-theme.conf"
cat > "${TMUX_FILE}" << EOF
# frame default
set -g @background '${BASE03}'
# frame selected
set -g @selected '${BASE0D}'

set -g @active '${BASE0D}'
set -g @inactive '${BASE03}'

set -g @color0 '${BASE0A}'
set -g @color1 '${BASE0B}'
set -g @color2 '${BASE0C}'
EOF
success "Tmux: ${TMUX_FILE}"

WAYBAR_FILE="${ROOT}/waybar-theme.css"
cat > "${WAYBAR_FILE}" << EOF
@define-color base00 ${BASE00};
@define-color base01 ${BASE01};
@define-color base02 ${BASE02};
@define-color base03 ${BASE03};
@define-color base04 ${BASE04};
@define-color base05 ${BASE05};
@define-color base06 ${BASE06};
@define-color base07 ${BASE07};
@define-color base08 ${BASE08};
@define-color base09 ${BASE09};
@define-color base0A ${BASE0A};
@define-color base0B ${BASE0B};
@define-color base0C ${BASE0C};
@define-color base0D ${BASE0D};
@define-color base0E ${BASE0E};
@define-color base0F ${BASE0F};
EOF
success "Waybar: ${WAYBAR_FILE}"

DUNST_FILE="${ROOT}/dunst-theme"
cat > "${DUNST_FILE}" << EOF
[global]
    frame_width = 2
    corner_radius = 8
    font = "JetBrainsMono Nerd Font Propo" 10
    icon_theme = "Colloid-Dark,Papirus-Dark,Adwaita"
    icon_position = left
    min_icon_size = 22
    max_icon_size = 128
    icon_path = /usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/
[urgency_low]
    background = "${BASE01}"
    foreground = "${BASE05}"
    frame_color = "${BASE05}"
    timeout = 6
    default_icon = dialog-information
[urgency_normal]
    background = "${BASE01}"
    foreground = "${BASE05}"
    frame_color = "${BASE05}"
    timeout = 6
    default_icon = dialog-information
[urgency_critical]
    background = "${BASE01}"
    foreground = "${BASE08}"
    frame_color = "${BASE08}"
    timeout = 0
    default_icon = dialog-warning
EOF
success "Dunst: ${DUNST_FILE}"
