# Author: Nuncvc1v0

#!/usr/bin/env bash

# Hyprland Game Mode Toggle Script
# Toggles performance optimizations for gaming
# Disables animations, blur, shadows, gaps for maximum FPS

set -euo pipefail

# State file to persist game mode status
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/hypr_gamemode_state"

# Colors for notifications
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >&2
}

# Check if hyprctl is available
if ! command -v hyprctl &> /dev/null; then
    log "${RED}Error: hyprctl not found. Are you running Hyprland?${NC}"
    notify-send -u critical "❌ Game Mode Error" "hyprctl not found"
    exit 1
fi

# Get current animation state (1 = enabled, 0 = disabled)
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

# Check if command succeeded
if [ -z "$HYPRGAMEMODE" ]; then
    log "${RED}Error: Failed to get animation state${NC}"
    notify-send -u critical "❌ Game Mode Error" "Failed to check current state"
    exit 1
fi

# Toggle game mode
if [ "$HYPRGAMEMODE" = 1 ]; then
# ENABLE GAME MODE (disable animations and effects)
    log "${GREEN}Enabling Game Mode...${NC}"

    if hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:active_opacity 1.0;\
        keyword decoration:inactive_opacity 1.0;\
        keyword decoration:fullscreen_opacity 1.0;\
        keyword decoration:rounding 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1" 2>&1; then

# Save state
        echo "enabled" > "$STATE_FILE"

        log "${GREEN}✓ Game Mode ENABLED${NC}"

# Send notification BEFORE enabling DND
        notify-send -t 3000 "🎮 Game Mode: ENABLED"

# Give notification time to appear before DND (small delay)
        sleep 1

# Disable notifications (Do Not Disturb)
        if command -v swaync-client &> /dev/null; then
            swaync-client -dn 2>/dev/null || log "${YELLOW}Warning: Failed to enable DND${NC}"
        fi
    else
        log "${RED}✗ Failed to enable Game Mode${NC}"
        notify-send -u critical "❌ Game Mode Error" "Failed to apply settings"
        exit 1
    fi

else
    log "${YELLOW}Disabling Game Mode...${NC}"

# Reload Hyprland config to restore original settings
    if hyprctl reload 2>&1; then

# Enable notifications
        if command -v swaync-client &> /dev/null; then
            swaync-client -df 2>/dev/null || log "${YELLOW}Warning: Failed to disable DND${NC}"
        fi

# Remove state file
        rm -f "$STATE_FILE"

        log "${GREEN}✓ Game Mode DISABLED${NC}"
        notify-send -t 3000 "🖥️ Game Mode: DISABLED"
    else
        log "${RED}✗ Failed to reload config${NC}"
        notify-send -u critical "❌ Game Mode Error" "Failed to reload configuration"
        exit 1
    fi
fi

# Final status check
FINAL_STATE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$FINAL_STATE" = 0 ]; then
    log "Current state: ${GREEN}Game Mode Active${NC}"
else
    log "Current state: ${YELLOW}Normal Mode${NC}"
fi

exit 0
