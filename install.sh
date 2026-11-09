#!/bin/sh
# Install the ccstatusline preset and point Claude Code's status line at it.
# Existing files are backed up with a timestamp suffix before being replaced.
set -eu

REPO_DIR=$(cd "$(dirname "$0")" && pwd)
CCS_DIR="$HOME/.config/ccstatusline"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
CLAUDE_SETTINGS="$CLAUDE_DIR/settings.json"
STAMP=$(date +%Y%m%d%H%M%S)

need() { command -v "$1" >/dev/null 2>&1 || { echo "error: '$1' is required but not installed" >&2; exit 1; }; }
need jq
command -v bunx >/dev/null 2>&1 || command -v npx >/dev/null 2>&1 || {
  echo "error: need bunx (Bun) or npx (Node.js) to run ccstatusline" >&2; exit 1; }

backup() { [ -e "$1" ] && cp "$1" "$1.bak.$STAMP" && echo "backed up $1 -> $1.bak.$STAMP" || true; }

# 1. ccstatusline config + account script
mkdir -p "$CCS_DIR"
backup "$CCS_DIR/settings.json"
backup "$CCS_DIR/account.sh"
cp "$REPO_DIR/config/settings.json" "$CCS_DIR/settings.json"
cp "$REPO_DIR/config/account.sh" "$CCS_DIR/account.sh"
chmod +x "$CCS_DIR/account.sh"
echo "installed ccstatusline config to $CCS_DIR"

# 2. Claude Code statusLine setting
if command -v bunx >/dev/null 2>&1; then
  CMD="bunx -y ccstatusline@latest"
else
  CMD="npx -y ccstatusline@latest"
fi

mkdir -p "$CLAUDE_DIR"
backup "$CLAUDE_SETTINGS"
[ -f "$CLAUDE_SETTINGS" ] || echo '{}' > "$CLAUDE_SETTINGS"
tmp=$(mktemp)
jq --arg cmd "$CMD" '.statusLine = {type: "command", command: $cmd, padding: 0, refreshInterval: 10}' \
  "$CLAUDE_SETTINGS" > "$tmp" && mv "$tmp" "$CLAUDE_SETTINGS"
echo "set statusLine in $CLAUDE_SETTINGS to: $CMD"

echo "done. The status line updates on the next refresh in Claude Code."
