# ccstatusline-preset

A ready-made status line for [Claude Code](https://docs.claude.com/en/docs/claude-code/statusline), built on [ccstatusline](https://github.com/sirmalloc/ccstatusline).

```
Model: Opus 5.5 | 🧠 medium | 👤 you@example.com (team) | [████░░░░] 42% | ⎇ main | Cached: 120k
```

## What it shows

| Widget | Example | Notes |
|---|---|---|
| Model | `Model: Opus 5.5` | Current model |
| Effort | `🧠 medium` | Thinking effort level; changes when you run `/effort` |
| Account | `👤 you@example.com (team)` | Logged-in Claude account, from `config/account.sh` |
| Context | `[████░░░░] 42%` | Context window usage |
| Git branch | `⎇ main` | Current branch |
| Cached tokens | `Cached: 120k` | Prompt cache tokens |

The account widget respects `CLAUDE_CONFIG_DIR`, so it shows the right account if you switch between profiles.

## Requirements

- Claude Code
- [Bun](https://bun.sh) or Node.js (to run `ccstatusline`)
- `jq`

## Install

```sh
git clone https://github.com/dinhnv/ccstatusline-preset.git
cd ccstatusline-preset
./install.sh
```

The script:

1. Copies `config/settings.json` and `config/account.sh` to `~/.config/ccstatusline/`.
2. Sets `statusLine` in `~/.claude/settings.json` (or `$CLAUDE_CONFIG_DIR/settings.json`) to run ccstatusline.

Any file it replaces is backed up first as `<file>.bak.<timestamp>`.

## Customize

Run the ccstatusline TUI to add, remove or recolor widgets:

```sh
bunx ccstatusline@latest
```

Or edit `~/.config/ccstatusline/settings.json` directly. A few tweaks:

- Effort icon: change `metadata.label` on the `effort` widget (default here is `"🧠 "`).
- Git branch icon: set `"character"` on the `git-branch` widget. With a [Nerd Font](https://www.nerdfonts.com/) you can use `` or ``.
- Color effort by level: in the TUI, select the Thinking Effort widget and press `l`.

## Uninstall

Restore the `.bak.<timestamp>` files the installer created, or remove the `statusLine` key from your Claude settings.

## License

MIT
