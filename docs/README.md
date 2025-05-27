# tkancf/dotfiles

## 事前準備
<!--{{{-->
- [homebrew](https://brew.sh/)のインストール
- [chezmoi](https://www.chezmoi.io/)のインストール

### homebrewのインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### chezmoiのインストール

```bash
brew install chezmoi
```
<!--}}}-->
## 初期設定

```bash
chezmoi init tkancf --apply --ssh -v
```

## ツール

- Neovim
    - メインエディタ
- tmux
- mise
    - 主なツールのインストール
- Vim
    - サブエディタ

## Chezmoi

Chezmoi is a powerful and flexible dotfile manager. It helps you manage your configuration files (dotfiles) across multiple machines securely and efficiently.

### Usage in this Repository

In this repository, Chezmoi is likely used to manage the dotfiles and configurations for various tools and applications. This allows for consistent setup and easy synchronization of personal configurations across different development environments. By storing dotfiles in this version-controlled repository, Chezmoi can track changes, roll back to previous versions, and apply configurations to new machines with minimal effort.

### `.chezmoiignore` File

The `.chezmoiignore` file specifies files and directories that Chezmoi should ignore. This is similar to a `.gitignore` file used by Git. Any patterns listed in this file will not be managed by Chezmoi.

The current content of the `.chezmoiignore` file is:

```
# 除外ファイル (Excluded files)
README.md
docs/
```

This means:
- `README.md`: The main `README.md` file at the root of the repository is excluded from Chezmoi's management. This is typically a project overview file and not a personal configuration file.
- `docs/`: The entire `docs/` directory is excluded. This directory is intended for documentation (like this file) and not for dotfiles that Chezmoi would manage.

## Homebrew

Homebrew is a popular open-source package manager for macOS (and Linux, though this configuration seems focused on macOS). It simplifies the installation and management of software on your system.

### `Brewfile`

A `Brewfile` is a configuration file used by `homebrew-bundle`, an extension of Homebrew. It allows you to declare a list of packages, casks, taps, and Mac App Store apps that you want to install or have installed on your system. This makes it easy to replicate your development environment on a new machine or keep your existing setup consistent.

You can use the command `brew bundle install` in the directory containing the `Brewfile` (or provide a path to it) to install everything listed.

### Packages in this Repository's `Brewfile`

The `Brewfile` located at `dot_config/homebrew/Brewfile` in this repository specifies the following:

#### Taps

Taps are third-party repositories that provide additional formulas (package definitions) or casks (definitions for GUI applications).
- `homebrew/bundle`: Provides the `bundle` command itself, allowing for `Brewfile` functionality.
- `homebrew/cask`: Provides casks for installing macOS applications.
- `homebrew/core`: The official core repository for Homebrew formulas.

#### Brews (Command-Line Tools)

These are command-line utilities installed via Homebrew.
- `git`: A distributed version control system.
- `mas`: A command-line interface for the Mac App Store, allowing you to install and manage apps from there.
- `tmux`: A terminal multiplexer, allowing you to manage multiple terminal sessions from a single window.
- `vim`: A highly configurable text editor.

#### Casks (GUI Applications)

Casks are used to install macOS applications with graphical user interfaces.
- `1password`: A password manager.
- `1password-cli`: The command-line interface for 1Password.
- `bettertouchtool`: A utility for customizing input devices on macOS.
- `discord`: A communication platform for voice, video, and text.
- `docker`: A platform for developing, shipping, and running applications in containers.
- `google-chrome`: A web browser.
- `iterm2`: A terminal emulator for macOS.
- `karabiner-elements`: A powerful keyboard customizer for macOS.
- `kindle`: Amazon's e-reader application.
- `obsidian`: A knowledge base and note-taking application.
- `raycast`: A launcher and productivity tool for macOS.
- `visual-studio-code`: A source code editor.
- `xmind`: A mind mapping and brainstorming software.

*Note: `alfred` is listed in the Brewfile but is commented out, meaning it is not currently managed or installed by this Brewfile.*

#### Mas (Mac App Store Apps)

These are applications installed from the Mac App Store using `mas`.
- `BetterSnapTool` (id: 417375580): A window management utility that allows for quick window snapping and resizing.

## Karabiner-Elements

Karabiner-Elements is a powerful and highly customizable keyboard customizer for macOS. It allows users to remap keys, create complex modification rules, and tailor keyboard behavior to their specific needs and workflows.

### `private_karabiner.json`

The `private_karabiner.json` file (located at `dot_config/karabiner/private_karabiner.json` in this repository) is the primary configuration file for Karabiner-Elements. It stores all the defined profiles, along with their associated simple and complex key modifications. When you make changes through the Karabiner-Elements GUI, those changes are saved to this file.

This file can contain multiple profiles, allowing users to switch between different keyboard layouts or sets of rules quickly.

### Profiles in this Repository

The `private_karabiner.json` file in this repository defines the following profiles:

1.  **JS-Mac-Keyboard**: This profile seems to be tailored for a Japanese Mac keyboard layout with specific modifications.
2.  **Game**: This profile is likely intended for gaming, potentially disabling certain keys or enabling game-specific macros (though its specific rules are not detailed in this `private_karabiner.json` except for its name).
3.  **tofu65**: This profile is likely designed for a "tofu65" keyboard or a similar 65% layout, which often requires custom mappings due to the reduced number of physical keys.
4.  **karabiner-ts**: This profile is generated using TypeScript and the `karabiner.ts` library.

### "karabiner-ts" Profile (Generated via TypeScript)

The "karabiner-ts" profile is particularly interesting as it is not manually configured through the Karabiner-Elements GUI but is instead generated by the TypeScript code found in `dot_config/karabiner-config/src/index.ts`. This script uses the `karabiner.ts` library, which provides a way to define Karabiner rules programmatically.

The key mappings defined in `dot_config/karabiner-config/src/index.ts` for the "karabiner-ts" profile are as follows:

*   **Backquote/Tilde**: The `international3` key (often found on Japanese keyboards, corresponding to the key for backquote/tilde on US layouts) is mapped to `grave_accent_and_tilde`.
*   **Shift Keys to Option Keys**:
    *   `left_shift` is remapped to `left_option`.
    *   `right_shift` is remapped to `right_option`.
*   **Command Keys to Shift Keys**:
    *   `left_command` is remapped to `left_shift`.
    *   `right_command` is remapped to `right_shift`.
*   **Japanese Input Keys (`japanese_eisuu`, `japanese_kana`)**:
    *   When `japanese_eisuu` (英数) is pressed alone, it functions as `japanese_eisuu`. When pressed in combination with other keys, it acts as `left_command`.
    *   When `japanese_kana` (かな) is pressed alone, it functions as `japanese_kana`. When pressed in combination with other keys, it acts as `right_command`.
*   **Spacebar Behavior**:
    *   When the `spacebar` is pressed alone, it sends a `spacebar` input.
    *   When `spacebar` is pressed in combination with other keys, it acts as `left_control`.
*   **Caps Lock to Hyper**:
    *   The `caps_lock` key is remapped to "Hyper," which is a combination of `left_command` + `left_option` + `left_control` + `left_shift`. This is a common modification to make Caps Lock a powerful modifier key.

The parameters within this profile in `private_karabiner.json` (like `basic.to_if_alone_timeout_milliseconds`) fine-tune the behavior of these "if_alone" mappings.

### Other Profiles

The other profiles defined in `private_karabiner.json` have their own sets of rules:

*   **JS-Mac-Keyboard**: This profile is currently selected (`"selected": true`). It includes several complex modifications, such as:
    *   Mapping `left_shift` + `caps_lock` to `page_down` and `right_shift` + `caps_lock` to `left_command` + `mission_control`.
    *   Mapping `international3` to `grave_accent_and_tilde` (similar to the "karabiner-ts" profile).
    *   Remapping `left_command` to `left_option`.
    *   A rule for the spacebar: "Post space is pressed alone, left_ctrl otherwise," meaning if space is pressed and released, it's space; if held and another key is pressed, it acts as `left_control`.
    *   Modifications for `japanese_eisuu` and `japanese_kana` keys to act as command keys when combined with other keys, and as themselves if pressed alone. This is similar to the "karabiner-ts" logic but implemented directly in the JSON.
    *   A simple modification to change `right_command` to `right_option`.

*   **Game**: This profile is listed but has no specific rules detailed within the `complex_modifications` or `simple_modifications` sections of the provided `private_karabiner.json`. It might be configured directly through the GUI with simpler rules not shown, or it's a placeholder.

*   **tofu65**: This profile also has specific complex modifications, notably:
    *   A rule to send `japanese_eisuu` (for alphanumeric input mode) if `left_control` is pressed alone, and `left_control` if held or used with other keys.
    *   A similar rule for `right_command` to send `japanese_kana` (for Kana input mode) if pressed alone, and `right_command` if held or used with other keys.

These profiles showcase the flexibility of Karabiner-Elements in tailoring keyboard behavior for different contexts or hardware.

## Kitty

Kitty is a fast, feature-rich, GPU-based terminal emulator. It offloads rendering to the GPU, which can result in lower system load and smoother scrolling compared to some other terminal emulators. Kitty is highly configurable and supports various advanced features like tabs, windows (splits), ligatures, and themes.

### Main Configuration File (`kitty.conf`)

The primary configuration for Kitty is handled by the `kitty.conf` file, located at `dot_config/kitty/kitty.conf` in this repository. This file contains settings that customize the appearance, behavior, and integration of Kitty with the system.

Key settings found in this `kitty.conf`:

*   **`editor /usr/bin/vim`**: Sets the default editor that Kitty will use for operations like opening files (e.g., via `kitty +open file.txt`) to `/usr/bin/vim`.
*   **`shell /opt/homebrew/bin/fish`**: Specifies the default shell to be launched when Kitty starts. In this case, it's Fish shell, installed via Homebrew at `/opt/homebrew/bin/fish`.
*   **`kitty_mod command`**: Defines the primary modifier key for Kitty-specific shortcuts. Here, the `Command` key (⌘) on macOS is set as `kitty_mod`. This means keyboard shortcuts like `kitty_mod+t` (for a new tab) would translate to `Cmd+t`.
*   **`font_family Hack Nerd Font Mono`**: Sets the default font to "Hack Nerd Font Mono". Nerd Fonts are popular as they include a wide range of glyphs and icons, which are useful for prompts and status lines in terminal applications.
*   **`font_size 16.0`**: Sets the default font size to 16 points.
*   **`background_opacity 0.8`**: Configures the terminal background to be partially transparent. A value of `0.8` means 80% opacity (or 20% transparency).
*   **`enabled_layouts splits:split_axis=horizontal`**: Defines the available window layout. This configuration enables the "splits" layout and sets the default split direction to horizontal. This means when you split a window (e.g., with `kitty_mod+enter`), it will create a new split horizontally by default.
*   **`action_alias launch_tab launch --type=tab --cwd=current`**: Creates a custom alias for an action. This specific alias, `launch_tab`, makes it easier to define keyboard shortcuts for launching a new tab that inherits the current working directory (`--cwd=current`) of the active terminal.

### Theme Configuration

Kitty's appearance, particularly its color scheme, is also highly customizable.

In this configuration:

*   The theme is included from an external file using the line:
    ```
    include current-theme.conf
    ```
    This tells Kitty to load additional color definitions from `current-theme.conf` (located in the same directory, `dot_config/kitty/`).

*   The `current-theme.conf` file itself defines the colors for a theme commented as "Wombat" in `kitty.conf`. This file contains a list of color settings. For example:
    *   `background #171717` (a dark gray, almost black)
    *   `foreground #ded9ce` (a light, slightly warm gray)
    *   `cursor #bbbbbb` (a medium gray)
    *   And many other colors for the ANSI color palette (color0-color15), selection background, etc.

This separation of the theme into its own file keeps the main `kitty.conf` cleaner and makes it easier to switch themes by changing the `include` directive or modifying the theme file directly.

## Lazygit

Lazygit is a simple terminal UI for git commands. It provides an interactive, TUI (Text-based User Interface) frontend for Git, allowing users to perform common Git operations like staging, committing, branching, and viewing history without needing to memorize or type out complex Git commands. This can significantly speed up workflows and make Git more accessible, especially for those who prefer a visual interface within the terminal.

### Configuration File (`config.yml`)

Lazygit's behavior and appearance can be customized using the `config.yml` file. In this repository, this file is located at `dot_config/lazygit/config.yml`.

Key settings found in this `config.yml`:

#### `git` Section

This section controls how Lazygit interacts with Git and displays Git-related information.

*   **`paging`**:
    *   `colorArg: always`: Ensures that Git commands that support color output (like `git diff`, `git log`) will always produce colored output.
    *   `pager: delta --dark --paging=never`: This is a significant customization. Instead of using the default pager (like `less`), Lazygit is configured to use `delta`.
        *   `delta` is an advanced syntax-highlighting pager specifically designed for Git and diff output. It provides much richer and more readable diffs than standard pagers.
        *   `--dark` suggests that a dark theme is preferred for `delta`'s output.
        *   `--paging=never` tells `delta` not to use its internal pager, as Lazygit handles the display and scrolling of content itself.

*   **`allBranchesLogCmd` and `branchLogCmd`**: These settings define custom Git log commands that Lazygit uses to display commit history.
    *   `allBranchesLogCmd`: Used for displaying the log for all branches.
    *   `branchLogCmd`: Used for displaying the log for a specific branch (`{{branchName}}` is a placeholder Lazygit fills in).
    *   Both commands use `git log --graph --color=always` to show the branch structure graphically with colors.
    *   The `--date=format:'%Y-%m-%d %H:%M'` part formats the date as `YYYY-MM-DD HH:MM`.
    *   The `--pretty=format:'%C(#a0a0a0 reverse)%h%Creset %C(cyan)%ad%Creset %C(#dd4814)%ae%Creset %C(yellow reverse)%d%Creset %n%C(white bold)%s%Creset%n'` part defines a very specific custom format for each log entry:
        *   `%h`: Abbreviated commit hash (colored `#a0a0a0 reverse`).
        *   `%ad`: Author date (colored `cyan`).
        *   `%ae`: Author email (colored `#dd4814`).
        *   `%d`: Commit decorations (like branch names, tags) (colored `yellow reverse`).
        *   `%s`: Commit subject/message (colored `white bold`).
        *   `%n`: Newline.
        *   This custom formatting provides a detailed and color-coded log view within Lazygit.

#### `os` Section

This section relates to operating system-specific configurations, such as how Lazygit invokes an editor.

*   **`editPreset: 'nvim'`**: This setting specifies that when Lazygit needs to open a file for editing (e.g., for a commit message or an interactive rebase), it should use Neovim (`nvim`).

#### `customCommands` Section

This section allows users to define their own custom commands that can be triggered with keybindings within Lazygit.

*   The configuration includes one custom command:
    *   **`key: 'O'`**: The command is bound to the uppercase 'O' key.
    *   **`command: 'gh repo view --web'`**: The command to be executed is `gh repo view --web`. This uses the GitHub CLI (`gh`) to open the current repository's page in a web browser.
    *   **`context: 'files'`**: This command will be available when the "files" panel/context is active in Lazygit.
    *   **`description: 'Open repository in GitHub'`**: This is the description that will be shown for the custom command in Lazygit's menus or help.

#### Commented-out Settings

*   `# gui:`
    *   `# nerdFontsVersion: "3"`: This line is commented out. If it were active, it would indicate to Lazygit that a Nerd Font version 3 is in use, which can help with the rendering of certain icons or glyphs. Since it's commented, Lazygit will use its default assumptions or auto-detection for Nerd Font support.

## mise

Mise (pronounced "meez") is a versatile tool manager that allows you to manage multiple versions of programming languages, CLIs, and other development tools. It helps ensure consistent development environments across different projects and makes it easy to switch between tool versions. Mise uses a TOML configuration file to define the tools and their desired versions.

### `config.toml` - `[tools]` Section

The `dot_config/mise/config.toml` file in this repository specifies the tools to be managed under the `[tools]` section. Most tools are set to `"latest"`, which means mise will attempt to install and use the most recent stable release of that tool.

Examples of tools managed in this configuration:

*   **Directly named tools**:
    *   `yarn = "latest"`
    *   `go = "latest"`
    *   `neovim = "latest"`
    *   `deno = "latest"`
    *   `ripgrep = "latest"`
    *   `zoxide = "latest"`
    *   `ghq = "latest"`
    *   `fzf = "latest"`
    *   `lazygit = "latest"`
    *   `delta = "latest"`
    *   `gitui = "latest"`
    *   `yazi = "latest"`
    *   `node = "latest"`
    *   `lua-language-server = "latest"`
    *   `fd = "latest"`
    *   `github-cli = "latest"`
    *   `tmux = "latest"`
    *   `ffmpeg = "latest"`
    *   `pnpm = "latest"`
    *   `rust = "latest"`

*   **Tools specified with a source/plugin prefix**: Mise allows specifying tools from different sources or plugins.
    *   `"go:github.com/rhysd/vim-startuptime" = "latest"`: Installs `vim-startuptime` using the Go plugin, likely from the specified GitHub repository.
    *   `"npm:typescript-language-server" = "latest"`: Installs `typescript-language-server` via npm (Node Package Manager).
    *   `"go:golang.org/x/tools/gopls" = "latest"`: Installs `gopls` (the Go language server) using the Go plugin.
    *   `"cargo:create-tauri-app" = "latest"`: Installs `create-tauri-app` using cargo (Rust's package manager).
    *   `"npm:@anthropic-ai/claude-code" = "latest"`: Installs the `@anthropic-ai/claude-code` package via npm.
    *   `"npm:@github/copilot-language-server" = "latest"`: Installs the `@github/copilot-language-server` package via npm.

This approach provides flexibility in how tools are acquired and managed by mise.

### `config.toml` - `[settings]` Section

The `[settings]` section in the `config.toml` file allows for configuring mise's behavior.

*   **`experimental = true`**: This setting enables experimental features within mise. This might be necessary for certain tools or advanced functionalities that are not yet considered stable. It's advisable to check the mise documentation for what specific experimental features this flag enables.

## Neovim

Neovim is a highly extensible, Vim-based text editor that aims to improve the user experience and plugin architecture of Vim. It is known for its performance, modern features, and extensive customization capabilities, primarily through Lua scripting.

### Configuration Structure

Neovim's configuration in this repository is located primarily within the `dot_config/nvim/` directory. The main configuration is written in Lua.

*   **`init.lua`**: This is the main entry point for Neovim's configuration. When Neovim starts, it executes this file.
*   The `init.lua` script is responsible for loading other configuration components:
    *   `config.basic`: Handles basic editor settings, such as options for indentation, line numbers, and general editing behavior.
    *   `config.keymap`: Contains custom key mappings, defining shortcuts for various commands and actions.
    *   `config.lazy`: This part sets up the `lazy.nvim` plugin manager. `lazy.nvim` is a modern plugin manager for Neovim that allows for easy installation, lazy-loading, and management of plugins.

### Plugin Management with `lazy.nvim`

Plugins significantly extend Neovim's functionality. They are managed by `lazy.nvim` and their configurations are defined as individual Lua files (or modules) located under the `dot_config/nvim/lua/plugins/` directory.

The following plugin configuration files are present, giving an overview of the installed features:

*   `codecompanion.lua`
*   `colorscheme.lua`
*   `dial.nvim.lua`
*   `gitsigns.lua`
*   `image-preview.nvim.lua`
*   `image.nvim.lua`
*   `lazydev.lua`
*   `lexima-alter-command.vim.lua`
*   `lexima.vim.lua`
*   `luarocks.nvim.lua`
*   `marktodo.lua`
*   `mini.icons.lua`
*   `neogit.lua`
*   `nvim-cmp.lua`
*   `nvim-lspconfig.lua`
*   `obsidian.nvim.lua`
*   `oil.nvim.lua`
*   `plenary-nvim.lua`
*   `snacks.lua`
*   `tkancf/snacks-markdown-title.lua`
*   `treesitter.lua`
*   `vim-ambiwidth.lua`
*   `vim-asterisk.lua`
*   `vim-maketable.lua`
*   `vim-qfreplace.lua`
*   `vim-sandwich.lua`
*   `which-key.lua`

### Key Plugins and Their Roles

While there are many plugins, some of the more prominent or essential ones in this configuration include:

*   **`nvim-lspconfig.lua`**: Configures Language Server Protocol (LSP) clients. LSP allows Neovim to integrate with language-specific servers to provide features like auto-completion, go-to-definition, find references, diagnostics (errors and warnings), and more.
*   **`nvim-cmp.lua`**: Provides autocompletion capabilities. It's a highly configurable completion engine that can source suggestions from LSP, snippets, paths, and other sources.
*   **`treesitter.lua`**: Integrates with `nvim-treesitter`, which provides advanced syntax highlighting, code parsing, and structural information about code. This allows for more accurate highlighting, code navigation, and text objects.
*   **`gitsigns.lua`**: Adds Git difference indicators in the sign column (the column to the left of the line numbers). This visually shows which lines have been added, modified, or deleted.
*   **`neogit.lua`**: Offers a Magit-like interface for Git operations directly within Neovim, allowing for staging, committing, branching, and other Git commands through an interactive UI.
*   **`obsidian.nvim.lua`**: Provides tools and integrations for working with [Obsidian](https://obsidian.md/) vaults, enabling features like note navigation, linking, and management within Neovim.
*   **`which-key.lua`**: A helpful utility that displays available keybindings when a prefix key is pressed (e.g., after pressing `<leader>`), guiding the user through complex key sequences.
*   **`colorscheme.lua`**: This file likely contains the logic to set and manage the Neovim colorscheme, defining the editor's overall look and feel.

### Other Configurations

Beyond plugins, the core editor behavior is customized through files like `lua/config/basic.lua` (for general editor settings like indentation, appearance, etc.) and `lua/config/keymap.lua` (for defining custom keyboard shortcuts). These files work in conjunction with `init.lua` and the plugins to create a tailored editing environment.

## Fish Shell

Fish is a user-friendly command-line shell for Linux, macOS, and other Unix-like operating systems. It aims to provide a rich set of features out-of-the-box, with a focus on discoverability and ease of use. Key features include autosuggestions, syntax highlighting, and extensive scripting capabilities.

### Main Configuration File (`config.fish`)

The primary configuration file for Fish is `dot_config/private_fish/config.fish`. This file is executed when Fish starts and is used to set up the shell environment, define aliases (called "abbreviations" in Fish), and manage shell behavior.

Key aspects of this configuration:

*   **Environment Setup**:
    *   **Homebrew**: `eval (/opt/homebrew/bin/brew shellenv)` initializes the Homebrew environment.
    *   **mise**: The configuration notes that mise is automatically activated when using Brew and Fish. It also mentions how to disable this auto-activation if needed (`set -Ux MISE_FISH_AUTO_ACTIVATE 0`).
    *   **zoxide**: `zoxide init fish | source` initializes `zoxide`, a tool for intelligent directory navigation.
*   **Shell Behavior**:
    *   `set fish_greeting`: Suppresses the default greeting message when Fish starts.
*   **Environment Variables**:
    *   `set -x XDG_CONFIG_HOME "$HOME/.config"`: Sets the standard XDG base directory for configuration files.
    *   `set -x EDITOR "nvim"`: Sets the default command-line editor to Neovim.
    *   `set -gx PNPM_HOME "/Users/tkan/Library/pnpm"` and `set -gx PATH "$PNPM_HOME" $PATH`: Configures the environment for `pnpm` (a Node.js package manager) by setting `PNPM_HOME` and adding it to the `PATH`.
*   **Abbreviations (`abbr`)**: Fish's equivalent of aliases. This configuration makes extensive use of abbreviations for common commands:
    *   Configuration editing:
        *   `cnn "cd ~/.config/nvim/ && nvim ./lua/plugins/ # edit neovim config"`
        *   `cnf "cd ~/.config/fish/ && nvim config.fish # edit fish config"`
    *   Chezmoi shortcuts:
        *   `cc "chezmoi cd"`
        *   `cad "chezmoi add ~/.config/nvim/ ~/.config/fish/  ~/.config/wezterm/ ~/.config/lazygit/ ~/.config/wezterm/ ~/.tmux.conf ~/.gitconfig ~/.vimrc ~/.config/mise/"`
        *   `cap "chezmoi init tkancf --apply --ssh -v"`
    *   Vim/Neovim:
        *   `v "neovim"`
    *   Git:
        *   `g "lazygit"`
        *   `gs "git status"`
        *   `ga "git add"`
        *   `gcm "git commit -m"`
    *   fzf integration:
        *   `bb "abbr --show | fzf"` (show and filter abbreviations with fzf)
        *   `cdg "cd (ghq list --full-path | fzf)"` (change directory to a `ghq`-managed repository selected via `fzf`)

### Plugin Management

Fish plugins are managed using [Fisher](https://github.com/jorgebucaran/fisher), a plugin manager for Fish. The list of installed plugins is maintained in `dot_config/private_fish/fish_plugins`.

The plugins used in this configuration are:

*   **`jorgebucaran/fisher`**: Fisher itself, the plugin manager.
*   **`jethrokuan/z`**: Implements the `z` command, which allows for quick navigation to frequently used directories based on "frecency" (frequency and recency).
*   **`gazorby/fish-abbreviation-tips`**: Provides interactive tips/suggestions for defined abbreviations as you type.
*   **`patrickf1/fzf.fish`**: Integrates `fzf` (a command-line fuzzy finder) with Fish, providing enhanced searching and completion capabilities.

### Configuration Directory (`conf.d`)

The `dot_config/private_fish/conf.d/` directory contains additional Fish configuration files that are automatically loaded. These files help organize the configuration.

Files in this directory include:

*   **`abbr_tips.fish`**: Likely contains configurations for the `fish-abbreviation-tips` plugin.
*   **`fzf.fish`**: Contains configurations related to `fzf.fish` plugin and fzf integrations.
*   **`rustup.fish`**: Likely sets up the environment for `rustup` (the Rust toolchain installer).
*   **`z.fish`**: Contains configurations for the `z` (directory jumping) plugin.
*   *(`.keep` is likely a placeholder to ensure the directory is tracked by Git even if empty otherwise).*

### Custom Functions (`functions/`)

The `dot_config/private_fish/functions/` directory stores custom functions that extend Fish's capabilities. These functions can range from simple helper scripts to more complex integrations.

Key functions and groups of functions observed from the file listing:

*   **`__abbr_tips_*` functions**: Helper functions for the `fish-abbreviation-tips` plugin (e.g., `__abbr_tips_bind_newline.fish`, `__abbr_tips_init.fish`).
*   **`__fzf_*` functions**: A suite of functions providing core `fzf` integrations, such as `__fzf_cd.fish` (for changing directories), `__fzf_complete.fish` (for completions), `__fzf_find_file.fish`, and various search helpers (`_fzf_search_git_log.fish`, `_fzf_search_history.fish`).
*   **`__z*` functions**: Helper functions for the `z` directory jumping plugin (e.g., `__z.fish`, `__z_add.fish`, `__z_complete.fish`).
*   **`fish_prompt.fish`**: This is a standard Fish function that defines the appearance and content of the command prompt. Customizing this file allows for a personalized prompt.
*   **`fisher.fish`**: A function related to the Fisher plugin manager.
*   **`fzf_configure_bindings.fish`**: A function likely used to set up fzf keybindings.
*   *(`.keep` is likely a placeholder file).*

These custom functions, along with plugins and abbreviations, create a highly personalized and efficient shell environment.

## WezTerm

WezTerm is a GPU-accelerated cross-platform terminal emulator and multiplexer written in Rust. It provides a modern terminal experience with a focus on performance, features, and extensive configurability through a Lua scripting interface.

### Main Configuration File (`wezterm.lua`)

The primary configuration for WezTerm is located at `dot_config/wezterm/wezterm.lua`. This file is a Lua script that WezTerm executes on startup to customize its appearance, behavior, and key bindings.

Key aspects of this configuration:

*   **Appearance Settings**:
    *   `config.color_scheme = 'Molokai'`: Sets the terminal's color scheme to "Molokai," a popular dark theme.
    *   `config.window_background_opacity = 0.85`: Makes the terminal window partially transparent (85% opaque).
    *   `config.hide_tab_bar_if_only_one_tab = true`: Automatically hides the tab bar when there is only a single tab open, maximizing screen real estate.
    *   `config.font = wezterm.font_with_fallback({...})`: Defines the font configuration using a fallback mechanism.
        *   Primary font: "Hack Nerd Font". Nerd Fonts are often used for their inclusion of many glyphs and icons.
        *   Fallback font: "Cica", which is likely used for characters or emoji not covered by Hack Nerd Font, with `assume_emoji_presentation = true` suggesting it's prioritized for emoji rendering.

*   **Custom Key Bindings (`config.keys`)**: The configuration defines several custom key bindings, primarily using the Command (CMD) key as a modifier on macOS. These are categorized below:

    *   **Tab Operations**:
        *   `CMD + t`: Spawns a new tab in the current pane's domain (`SpawnTab = "CurrentPaneDomain"`).
        *   `CMD + w`: Closes the current tab, with a confirmation prompt (`CloseCurrentTab = { confirm = true }`).
        *   `CMD + n`: Activates the next tab (`ActivateTabRelative(1)`).
        *   `CMD + p`: Activates the previous tab (`ActivateTabRelative(-1)`).
        *   `CMD + e`: Shows the tab navigator, allowing for quick switching between tabs (`ShowTabNavigator`).

    *   **Pane Operations**:
        *   `CMD + 5`: Splits the current pane horizontally (`SplitHorizontal { domain = "CurrentPaneDomain" }`).
        *   `CMD + '` (apostrophe/single quote): Splits the current pane vertically (`SplitVertical { domain = "CurrentPaneDomain" }`).
        *   `CMD + z`: Toggles the zoom state of the current pane (`TogglePaneZoomState`).

    *   **Clipboard Operations**:
        *   `CMD + c`: Copies the selected text to the clipboard (`CopyTo = "Clipboard"`).
        *   `CMD + v`: Pastes text from the clipboard (`PasteFrom = "Clipboard"`).

These settings and key bindings tailor WezTerm to provide a user experience consistent with common macOS application shortcuts while leveraging WezTerm's specific features for terminal management.

" vim: foldmethod=marker foldlevel=1
