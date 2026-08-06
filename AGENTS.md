# PROJECT KNOWLEDGE BASE

**Generated:** 2026-08-06
**Commit:** d08bddb
**Branch:** main

## OVERVIEW
tkancf's macOS dotfiles: zsh (primary) + fish (secondary) shells, Neovim, herdr multiplexer, git, legacy tmux/vim. Plain git repo at `~/.config/dotfiles`, deployed via symlinks (`setup.sh`, minimal/full modes); packages via Homebrew (`Brewfile`).

## STRUCTURE
```
dotfiles/
├── setup.sh              # symlink installer (minimal|full); backs up targets to .backup/
├── Brewfile              # brew bundle: git, mas, ocgo, casks, 1 MAS app
├── zshenv                # sets ZDOTDIR → config/zsh (the only zsh file actually linked)
├── gitconfig             # git identity + include ~/.gitconfig.local (NOT linked by setup.sh)
├── tmux.conf             # legacy tmux (being replaced by herdr)
├── vimrc                 # legacy vim
├── README.md             # clone/setup instructions
├── .backup/              # timestamped pre-symlink backups (gitignored)
├── .codex/               # Codex CLI skill (nvim-plugin-add)
├── .omo/                 # omo runtime state (gitignored)
└── config/
    ├── zsh/              # LIVE zsh config via ZDOTDIR indirection
    ├── nvim/             # lazy.nvim; one spec file per plugin
    ├── fish/             # secondary shell; functions/ is mostly vendored plugin code
    ├── herdr/            # multiplexer config (tmux successor)
    ├── ghostty/          # terminal config
    ├── mise/             # tool version pinning (go/node/python/pnpm, nvim nightly)
    ├── opencode/         # opencode AI agent config + herdr plugin
    ├── omo/              # omo agent config → ~/.omo
    ├── keyboard/         # tofu_jr keyboard layout (tracked, NOT deployed)
    └── tmux/             # session-color.sh helper (tracked, NOT deployed)
```

## WHERE TO LOOK
| Task | Location |
|------|----------|
| What gets deployed where | `setup.sh` (single source of truth) |
| Shell startup | `zshenv` → `config/zsh/.zshrc` → `config/zsh/rc.d/` |
| Fish config | `config/fish/config.fish` + `conf.d/`, `functions/` |
| Neovim plugins | `config/nvim/init.lua` → `lua/plugins/` |
| LSP setup | `lua/config/lsp.lua` + `after/lsp/` |
| Git identity | `gitconfig` (+ `~/.gitconfig.local`) |
| Terminal | `config/ghostty/config` |
| Multiplexer | `config/herdr/config.toml` (tmux.conf is legacy) |
| Packages | `Brewfile` |
| Tool versions | `config/mise/config.toml` |
| AI tool configs | `config/opencode/`, `config/omo/` |

## CODE MAP
No program code — "symbols" are config entry points and their wiring:

| Entry | Type | Location | Linked to | Role |
|-------|------|----------|-----------|------|
| zshenv | shell startup | repo root | ~/.zshenv | sets ZDOTDIR to config/zsh |
| .zshrc | shell startup | config/zsh/ | via ZDOTDIR | sources rc.d/*.zsh in order |
| rc.d/*.zsh | snippets | config/zsh/rc.d/ | sourced by .zshrc | 00-options … 90-highlighting |
| config.fish | shell startup | config/fish/ | ~/.config/fish (manual link) | abbrs, PATH, init |
| init.lua | editor entry | config/nvim/ | ~/.config/nvim | lazy.nvim bootstrap + plugin imports |
| lua/plugins/*.lua | editor modules | config/nvim/lua/plugins/ | imported by init.lua | one lazy spec per plugin |
| setup.sh | installer | repo root | n/a | links configs, backs up targets |
| Brewfile | packages | repo root | n/a | brew bundle manifest |
| config.toml | multiplexer | config/herdr/ | ~/.config/herdr | herdr settings (tmux successor) |

## CONVENTIONS
- Deploy by symlink only (`ln -sf`), never copy. `./setup.sh [minimal|full]`; minimal = zshenv/zsh/herdr/nvim, full adds vimrc/tmux/mise/ghostty/opencode/omo.
- Machine-local overrides go in gitignored files: `config/zsh/local.zsh`, `config/fish/local.fish`, `~/.gitconfig.local`. Never put machine-specific settings in tracked configs.
- zsh rc.d loads by `NN-` numeric prefix; `90-highlighting.zsh` MUST stay last (syntax highlighting wraps ZLE widgets).
- nvim: one lazy.nvim spec file per plugin in `lua/plugins/`, registered via `{ import = 'plugins.<name>' }` in init.lua. Keymaps need `desc`, prefer `<leader>`.
- Keep edits ASCII-only unless the file already uses non-ASCII (existing files contain Japanese comments).
- git: branch `main`, `pull.ff = only`, `merge.ff = false`, `conflictstyle = diff3`, `useConfigOnly = true`.
- All packages via `Brewfile`; tool versions via mise (`config/mise/config.toml`).
- No lint/format tooling exists in this repo — do not invent any.

## ANTI-PATTERNS (THIS PROJECT)
- NEVER commit: `.backup/`, `.omo/`, `config/nvim/lazy-lock.json`, `config/fish/fish_variables`, `config/zsh/.zcompdump`, `config/zsh/.zsh_history`, `config/fish/local.fish`, `config/zsh/local.zsh`.
- Never add machine-specific settings to tracked files — use the `local.*` overrides.
- Never add zsh rc.d files that must load after `90-` (that prefix is the ceiling).
- Never add nvim plugins outside `lua/plugins/` or register them outside init.lua's import list.
- Never edit vendored fish plugin code (most of `config/fish/functions/`) — it is upstream code pinned in the repo.

## UNIQUE STYLES
- ZDOTDIR indirection: only `zshenv` is symlinked; all other zsh startup loads from the repo via ZDOTDIR. `~/.zshrc` on disk is vestigial.
- `config/fish` is symlinked manually but absent from setup.sh lists — known installer gap.
- `gitconfig` is NOT deployed by setup.sh; `~/.gitconfig` is a manual copy (currently identical).
- setup.sh moves existing targets to `.backup/<timestamp>/` before linking; backups accumulate in-repo (gitignored).
- zsh aliases reference chezmoi (`cad`/`cap`), but deployment is plain symlinks — leftover migration path; no chezmoi config in repo.
- herdr is migrating in as tmux's successor; tmux.conf still deployed in `full` mode.

## COMMANDS
```bash
./setup.sh                   # deploy minimal (zshenv, zsh, herdr, nvim)
./setup.sh full              # deploy everything (vimrc, tmux, mise, ghostty, opencode, omo)
brew bundle --file=Brewfile  # install packages
git pull                     # update (no dedicated update script)
```

## NOTES
- setup.sh hardcodes the repo path `$HOME/.config/dotfiles` — breaks if cloned elsewhere.
- `11-eval.zsh` reads OPENCODE_API_KEY from 1Password (`op read`), cached in `~/.cache/opencode-api-key` (0600, 24h TTL) to avoid an unlock prompt on every new tab; falls back to `local.zsh`.
- `config/fish/local.fish` currently holds a live API key — keep gitignored.
- `config/opencode/plugins/herdr-agent-state.js` is regenerated by herdr — treat as generated.
- Working tree was dirty on 2026-08-06: 4 modified (zshenv, 00-options, 11-eval, 30-aliases) + untracked `90-highlighting.zsh`.

## SUBPROJECTS
- `config/zsh/AGENTS.md` — shell startup, rc.d ordering
- `config/fish/AGENTS.md` — fish layout, vendored vs user code
- `config/nvim/AGENTS.md` — plugin conventions, LSP split
