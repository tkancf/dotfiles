# ZSH

## OVERVIEW
Primary shell of the repo. Loaded via ZDOTDIR indirection: root `zshenv` sets ZDOTDIR to this dir; only `zshenv` is symlinked to `~/.zshenv`. All other startup files load from the repo.

## STRUCTURE
- `.zshrc` — entry point; sources every `rc.d/*.zsh` in numeric order
- `rc.d/` — `NN-` prefixed snippets (options, completion, eval, prompt, aliases, highlighting)
- `local.zsh` — machine-local overrides (gitignored)
- `.zcompdump` / `.zsh_history` — runtime state (gitignored)

## WHERE TO LOOK
| Concern | File |
|---------|------|
| Shell options | `rc.d/00-options.zsh` |
| Completion | `rc.d/10-completion.zsh` |
| Eval'd integrations (brew, mise, zoxide, atuin, fzf, cargo, OrbStack, pnpm, 1Password key) | `rc.d/11-eval.zsh` |
| Prompt | `rc.d/20-prompt.zsh` |
| Aliases | `rc.d/30-aliases.zsh` |
| Syntax highlighting | `rc.d/90-highlighting.zsh` |

## CONVENTIONS
- Files load by numeric prefix `00` → `90`; higher numbers load later.
- `90-highlighting.zsh` MUST be sourced last (wraps ZLE widgets). Nothing may be added after it.
- Machine-local settings go in `local.zsh` (gitignored), never in tracked files.
- `11-eval.zsh` sources `local.zsh` if present, so it is the last hook for local env setup.

## ANTI-PATTERNS
- Never add rc.d files numbered after `90` (prefix is the ceiling).
- Never commit `local.zsh`, `.zcompdump`, or `.zsh_history`.
- Don't hardcode machine-specific paths in tracked rc.d files.

## NOTES
- `11-eval.zsh` reads `OPENCODE_API_KEY` from 1Password via `op read 'op://Private/opencode/OPENCODE_API_KEY'`, cached in `~/.cache/opencode-api-key` (0600, 24h TTL; skipped if env already set), with `local.zsh` as fallback.
- zsh aliases contain chezmoi references (`cad`/`cap`) but the repo deploys via plain symlinks.
- `~/.zshrc` in HOME is vestigial; ZDOTDIR redirects startup to this dir.
