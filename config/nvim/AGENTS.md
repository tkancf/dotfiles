# NVIM

Overview: Neovim config built on lazy.nvim, largest sub-tree in the repo, actively maintained.

## STRUCTURE

| Path | Role |
|------|------|
| `init.lua` | Monolith: lazy.nvim bootstrap + `vim.opt` block + global keymaps + autocmds + inline `vim-maketable` spec |
| `lua/plugins/` | 27 spec files, one per plugin |
| `lua/config/lsp.lua` | Native `vim.lsp.enable()` with 7 servers (lua_ls, roc_ls, gopls, pyright, ts_ls, terraformls, ansiblels) |
| `after/lsp/lua_ls.lua` | Neovim 0.11 per-server config (only lua_ls) |
| `queries/` | Custom treesitter queries: `moonbit/` (7 scm files), `markdown/`, `markdown_inline/` |
| `snippets/` | Snippy-format snippets (go.snippets, markdown.snippets) |
| `template/` | vim-sonictemplate templates, consumed by snacks-picker-sonictemplate |
| `docs/` | Empty placeholder |
| `lazy-lock.json` | Gitignored, pins 36 repos (lazy.nvim at commit 306a055) |

## CONVENTIONS

- One lazy.nvim spec file per plugin in `lua/plugins/`; filename = plugin short name (`mini-statusline.lua`, `treesitter.lua`).
- Each file returns a spec table with declarative `opts`/`event`/`keys` (see which-key.lua).
- New plugins registered via `{ import = 'plugins.<name>' }` in init.lua's spec list — explicit, never globbed.
- Leader groups (which-key.lua): `f`=File/Find, `b`=Buffer, `g`=Git, `l`=LSP, `s`=Search, `S`=Session, `p`=popup (Overlook), `.`=Scratch, `o`=Obsidian.
- Per-plugin `keys = {...}` arrays; every mapping needs `desc`.
- `s` prefix = window/buffer movement: `sl`/`sh`/`sj`/`sk` windows, `sn`/`sp` buffers.
- `:`/`;` swapped (normal + visual).
- Japanese one-line comment at top of each spec file describing the plugin.

## LSP (3-way split)

- `lua/config/lsp.lua`: `vim.lsp.enable(servers)` + `LspAttach` keymaps/formatting.
- `after/lsp/<server>.lua`: per-server settings (only lua_ls exists).
- `lua/plugins/nvim-lspconfig.lua`: lazy-loaded dependency shell only, no setup calls.

## ANTI-PATTERNS

- `lua/plugins/luasnip.lua` is DEAD config — not imported in init.lua; active stack is nvim-snippy + cmp-snippy. Do not revive it.
- `vim-maketable` is inline in init.lua (only exception to one-file-per-plugin). Do not extract.
- Never commit `lazy-lock.json`.
- Don't add plugins outside `lua/plugins/`.

## NOTES

- lazy.nvim bootstrapped via `git clone --branch=stable`, pinned by lazy-lock.json at commit 306a055.
- Updater checker disabled (`checker = { enabled = false }`).
- `snippets/` (snippy) and `template/` (sonictemplate) are two separate systems wired into completion and the snacks picker respectively.
- Moonbit is a primary language: dedicated plugin + 7 query files.
- Comments/commits in Japanese.
