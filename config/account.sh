#!/bin/sh
# Print the Claude account for the current config dir (Orca profiles set CLAUDE_CONFIG_DIR).
f="${CLAUDE_CONFIG_DIR:+$CLAUDE_CONFIG_DIR/.claude.json}"
[ -f "$f" ] || f="$HOME/.claude.json"
jq -r '.oauthAccount // empty | "👤 \(.emailAddress) (\(.organizationType // "?" | sub("^claude_";"")))"' "$f" 2>/dev/null
