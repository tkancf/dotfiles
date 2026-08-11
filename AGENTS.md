# PROJECT KNOWLEDGE BASE

**Generated:** 2026-08-06
**Commit:** d08bddb
**Branch:** main

## OVERVIEW
tkancf's macOS dotfiles: zsh (primary) + fish (secondary) shells, Neovim, herdr multiplexer, git, legacy tmux/vim. Plain git repo at `~/.config/dotfiles`, deployed via `mise bootstrap dotfiles` (`[dotfiles]` in `config/mise/config.toml`); packages via Homebrew (`Brewfile`).

## STRUCTURE
```
dotfiles/
├── Brewfile              # brew bundle: git, mas, ocgo, casks, 1 MAS app
├── zshenv                # sets ZDOTDIR → config/zsh (the only zsh file actually linked)
├── gitconfig             # git identity + include ~/.gitconfig.local (deployed via mise)
├── tmux.conf             # legacy tmux (being replaced by herdr)
├── vimrc                 # legacy vim
├── scripts/              # check.sh: zsh/fish 構文 + brew bundle + mise status の整合性チェック
├── README.md             # clone/setup instructions
├── .backup/              # pre-mise-migration backups (gitignored)
├── .codex/               # Codex CLI skill (nvim-plugin-add)
└── config/
    ├── zsh/              # LIVE zsh config via ZDOTDIR indirection
    ├── nvim/             # lazy.nvim; one spec file per plugin
    ├── fish/             # secondary shell; functions/ is mostly vendored plugin code
    ├── herdr/            # multiplexer config (tmux successor)
    ├── agents/skills/    # herdr agent skill → ~/.agents/skills (npx skills add)
    ├── ghostty/          # terminal config
    ├── mise/             # [dotfiles] deploy list + tool version pinning (go/node/python/pnpm, nvim nightly)
    ├── opencode/         # opencode AI agent config + herdr plugin (NOT deployed; see NOTES)
    ├── keyboard/         # tofu_jr keyboard layout (tracked, NOT deployed)
    └── tmux/             # session-color.sh helper (tracked, NOT deployed)
```

## WHERE TO LOOK
| Task | Location |
|------|----------|
| What gets deployed where | `config/mise/config.toml` `[dotfiles]` (single source of truth) |
| Shell startup | `zshenv` → `config/zsh/.zshrc` → `config/zsh/rc.d/` |
| Fish config | `config/fish/config.fish` + `conf.d/`, `functions/` |
| Neovim plugins | `config/nvim/init.lua` → `lua/plugins/` |
| LSP setup | `lua/config/lsp.lua` + `after/lsp/` |
| Git identity | `gitconfig` (+ `~/.gitconfig.local`) |
| Terminal | `config/ghostty/config` |
| Multiplexer | `config/herdr/config.toml` (tmux.conf is legacy) |
| Packages | `Brewfile` |
| Tool versions | `config/mise/config.toml` |
| AI tool configs | `config/opencode/` |
| Agent skills (herdr) | `config/agents/skills/herdr/` → `~/.agents/skills/herdr` |

## CODE MAP
No program code — "symbols" are config entry points and their wiring:

| Entry | Type | Location | Linked to | Role |
|-------|------|----------|-----------|------|
| zshenv | shell startup | repo root | ~/.zshenv | sets ZDOTDIR to config/zsh |
| .zshrc | shell startup | config/zsh/ | via ZDOTDIR | sources rc.d/*.zsh in order |
| rc.d/*.zsh | snippets | config/zsh/rc.d/ | sourced by .zshrc | 00-options … 90-highlighting |
| config.fish | shell startup | config/fish/ | ~/.config/fish | abbrs, PATH, init |
| init.lua | editor entry | config/nvim/ | ~/.config/nvim | lazy.nvim bootstrap + plugin imports |
| lua/plugins/*.lua | editor modules | config/nvim/lua/plugins/ | imported by init.lua | one lazy spec per plugin |
| mise config.toml | deploy list | config/mise/ | ~/.config/mise | [dotfiles] entries + [tools] pins |
| Brewfile | packages | repo root | n/a | brew bundle manifest |
| config.toml | multiplexer | config/herdr/ | ~/.config/herdr | herdr settings (tmux successor) |

## CONVENTIONS
- Deploy by symlink only, never copy. `mise bootstrap dotfiles apply` (entries in `config/mise/config.toml` `[dotfiles]`); pass targets to apply a subset (minimal = zshenv/zsh/herdr/nvim, everything else is deployed with the default full set).
- Machine-local overrides go in gitignored files: `config/zsh/local.zsh`, `config/fish/local.fish`, `~/.gitconfig.local`. Never put machine-specific settings in tracked configs.
- zsh rc.d loads by `NN-` numeric prefix; `90-highlighting.zsh` MUST stay last (syntax highlighting wraps ZLE widgets).
- nvim: one lazy.nvim spec file per plugin in `lua/plugins/`, registered via `{ import = 'plugins.<name>' }` in init.lua. Keymaps need `desc`, prefer `<leader>`.
- Keep edits ASCII-only unless the file already uses non-ASCII (existing files contain Japanese comments).
- git: branch `main`, `pull.ff = only`, `merge.ff = false`, `conflictstyle = diff3`, `useConfigOnly = true`.
- All packages via `Brewfile`; tool versions + dotfile deployment via mise (`config/mise/config.toml`).
- No lint/format tooling exists in this repo — do not invent any.

## ANTI-PATTERNS (THIS PROJECT)
- NEVER commit: `.backup/`, `config/nvim/lazy-lock.json`, `config/fish/fish_variables`, `config/zsh/.zcompdump`, `config/zsh/.zsh_history`, `config/fish/local.fish`, `config/zsh/local.zsh`.
- Never add machine-specific settings to tracked files — use the `local.*` overrides.
- Never add zsh rc.d files that must load after `90-` (that prefix is the ceiling).
- Never add nvim plugins outside `lua/plugins/` or register them outside init.lua's import list.
- Never edit vendored fish plugin code (most of `config/fish/functions/`) — it is upstream code pinned in the repo.

## UNIQUE STYLES
- ZDOTDIR indirection: only `zshenv` is symlinked; all other zsh startup loads from the repo via ZDOTDIR. `~/.zshrc` on disk is vestigial.
- `config/fish` is deployed by mise (secondary shell); still absent from the `minimal` target set.
- `gitconfig` is deployed by mise (2026-08-11 から; それまでは手動コピー)。`gitignore` (global excludes) も配備済み。
- mise refuses to overwrite unmanaged files without `--force` (既存の手動 `~/.gitconfig` は `mise bootstrap dotfiles apply ~/.gitconfig --force` で 1 回だけ上書き適用)。`mise bootstrap dotfiles status` reports applied/missing/differs. `.backup/` holds pre-mise-migration files (gitignored).
- zsh/fish use plain-symlink deployment; the legacy chezmoi aliases (`cad`/`cap`/`cc`/`cz`) were removed in the 2026-08-07 review.
- herdr is migrating in as tmux's successor; tmux.conf still deployed.

## COMMANDS
```bash
mise bootstrap dotfiles apply                    # deploy all dotfiles
mise bootstrap dotfiles apply ~/.zshenv ~/.config/zsh ~/.config/herdr/config.toml ~/.config/nvim  # minimal set
mise bootstrap dotfiles status                   # show applied/missing/differs
scripts/check.sh                                 # zsh/fish 構文 + brew bundle + mise status チェック
brew bundle --file=Brewfile                      # install packages
git pull                                         # update (no dedicated update script)
```

## NOTES
- Dotfile sources in `[dotfiles]` resolve relative to `config/mise/`; the repo can live anywhere. First run on a new machine needs `MISE_CONFIG_FILE=~/.config/dotfiles/config/mise/config.toml` before the `~/.config/mise` symlink exists (see README).
- `11-eval.zsh` reads OPENCODE_API_KEY from 1Password (`op read`), cached in `~/.cache/opencode-api-key` (0600, 24h TTL) to avoid an unlock prompt on every new tab; falls back to `local.zsh`.
- `config/fish/local.fish` currently holds a live API key — keep gitignored.
- `config/opencode/plugins/herdr-agent-state.js` is regenerated by herdr — treat as generated.
- `config/opencode` is NOT in `[dotfiles]`; `~/.config/opencode` is a live directory (opencode manages node_modules etc. there). Sync `config/opencode/*` by hand and never re-add it to the deploy list.
- Reviewed 2026-08-07: deduped gitconfig, completed Brewfile (herdr/mise/opencode/fzf/ghq/zoxide/claude-code/ghostty), portable opencode plugin path, removed zig/roc/OrbStack/chezmoi leftovers. 2026-08-11: setup.sh 削除 (mise bootstrap dotfiles に一本化)、gitconfig を配備に追加、Brewfile に rg/fd/bat/jq + Nerd Font 追加、scripts/check.sh 新設、OPENCODE_API_KEY を Keychain 保存に変更、OrbStack 由来の壊れた fish completions を削除。

## SUBPROJECTS
- `config/zsh/AGENTS.md` — shell startup, rc.d ordering
- `config/fish/AGENTS.md` — fish layout, vendored vs user code
- `config/nvim/AGENTS.md` — plugin conventions, LSP split
