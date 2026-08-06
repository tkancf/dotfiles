# FISH

Secondary shell with a full config tree. ~90% of `functions/` is vendored fisher-plugin code committed wholesale; treat it as upstream.

## STRUCTURE

- `config.fish` — entry point. `abbr -a` definitions, `fish_add_path`, zoxide/OrbStack/mise init, sources `local.fish`.
- `conf.d/` — auto-sourced alphabetically at startup (fish core feature, no manual sourcing).
- `functions/` — autoloaded on first call; filename must equal function name.
- `completions/` — autoloaded by command.
- `fish_plugins` — fisher manifest: `jorgebucaran/fisher`, `jethrokuan/z`, `gazorby/fish-abbreviation-tips`, `patrickf1/fzf.fish`.
- `local.fish` — gitignored, machine-specific overrides.
- `scripts/` — periodic helper scripts.
- `themes/` — empty (`.keep` only).

## CONVENTIONS

- All abbreviations live in `config.fish` via `abbr -a`, grouped under comment headers: edit config, Vim/Neovim, git, fzf, tmux, claude, VSCode, uv.
- `g` = lazygit; `g*` (gs, ga, gcm, gd, gg…) = git; `c` = claude; `v` = nvim.
- Naming scopes:
  - `__name` — private/plugin internals: `__z*` (z), `__abbr_tips_*`, legacy `__fzf_*` widgets.
  - `_name` — fzf.fish internals (`_fzf_*`, `_fzf_extract_var_info`).
  - `fish_*` — builtin hook overrides (`fish_prompt`).
  - un-prefixed — public/user.
- User-owned files: `config.fish`, `local.fish`, `fish_prompt.fish`, `codex-go.fish`, `codex-kimi.fish`, `fish_plugins`. Everything else in `functions/` is upstream, read-only.

## ANTI-PATTERNS

- Never edit vendored plugin files: `fisher.fish`, `__z*`, `__abbr_tips_*`, `__fzf_*`, `_fzf_*`.
- Never commit `local.fish` (holds API keys) or `fish_variables` (universal vars, machine state).
- Don't scatter `abbr` definitions into per-file functions; they belong in `config.fish`.

## NOTES

- Fish is NOT in `setup.sh` — `~/.config/fish` is a manual symlink to this dir (known installer gap).
- Two fzf stacks coexist: modern `_fzf_*` search bindings (fzf.fish) + legacy `__fzf_*` cd/complete widgets.
- `completions/docker.fish`, `kubectl.fish`, `orbctl.fish` are symlinks into `OrbStack.app`.
- `conf.d/fish_frozen_*.fish` are fish 4.3 migration artifacts.
- `completions/moon.fish` and `pnpm.fish` are generated completions.
