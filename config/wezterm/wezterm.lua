local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Molokai'
config.window_background_opacity = 1.0
config.font_size = 18.0
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback({
    { family = "Cica", assume_emoji_presentation = false },
    { family = "Hack Nerd Font Mono", assume_emoji_presentation = true },
})

config.keys = {
    {
        key = 'p',
        mods = 'CMD',
        action = wezterm.action.ActivateCommandPalette,
    },
    -- タブ操作
    {
        key = "t",
        mods = "CMD",
        action = wezterm.action{ SpawnTab = "CurrentPaneDomain" }
    },
    {
        key = "w",
        mods = "CMD",
        action = wezterm.action{ CloseCurrentTab = { confirm = true } }
    },
    {
        key = "n",
        mods = "CMD",
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        key = "p",
        mods = "CMD",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        key = "e",
        mods = "CMD",
        action = wezterm.action.ShowTabNavigator
    },
    -- ペイン操作
    {
        key = "5",
        mods = "CMD",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
    },
    {
        key = "'",
        mods = "CMD",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
    },
    {
        key = "z",
        mods = "CMD",
        action = wezterm.action.TogglePaneZoomState
    },
    -- ペイン移動
    {
        key = "h",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection "Left"
    },
    {
        key = "j",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection "Down"
    },
    {
        key = "k",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection "Up"
    },
    {
        key = "l",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection "Right"
    },
    -- ペインサイズ調整
    {
        key = "LeftArrow",
        mods = "CMD|SHIFT",
        action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
        key = "RightArrow",
        mods = "CMD|SHIFT",
        action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
        key = "UpArrow",
        mods = "CMD|SHIFT",
        action = wezterm.action.AdjustPaneSize { "Up", 5 }
    },
    {
        key = "DownArrow",
        mods = "CMD|SHIFT",
        action = wezterm.action.AdjustPaneSize { "Down", 5 }
    },
    -- ペインを閉じる
    {
        key = "x",
        mods = "CMD",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    -- コピーモード
    {
        key = "v",
        mods = "CMD",
        action = wezterm.action.ActivateCopyMode
    },
    -- スクロール
    {
        key = "u",
        mods = "CMD",
        action = wezterm.action.ScrollByPage(-0.5)
    },
    {
        key = "d",
        mods = "CMD",
        action = wezterm.action.ScrollByPage(0.5)
    },
    -- クリップボード操作
    {
        key = "c",
        mods = "CMD",
        action = wezterm.action{ CopyTo = "Clipboard" }
    },
    {
        key = "Enter",
        mods = "CMD",
        action = wezterm.action{ PasteFrom = "Clipboard" }
    },
}

-- コピーモード内でのキーマッピング
config.key_tables = {
    copy_mode = {
        -- 移動
        { key = "h", mods = "NONE", action = wezterm.action.CopyMode "MoveLeft" },
        { key = "j", mods = "NONE", action = wezterm.action.CopyMode "MoveDown" },
        { key = "k", mods = "NONE", action = wezterm.action.CopyMode "MoveUp" },
        { key = "l", mods = "NONE", action = wezterm.action.CopyMode "MoveRight" },

        -- 単語移動
        { key = "w", mods = "NONE", action = wezterm.action.CopyMode "MoveForwardWord" },
        { key = "b", mods = "NONE", action = wezterm.action.CopyMode "MoveBackwardWord" },
        { key = "e", mods = "NONE", action = wezterm.action.CopyMode "MoveForwardWordEnd" },
        -- 行移動
        { key = "0", mods = "NONE", action = wezterm.action.CopyMode "MoveToStartOfLine" },
        { key = "$", mods = "NONE", action = wezterm.action.CopyMode "MoveToEndOfLineContent" },
        { key = "^", mods = "NONE", action = wezterm.action.CopyMode "MoveToStartOfLineContent" },
        -- ページ移動
        { key = "g", mods = "NONE", action = wezterm.action.CopyMode "MoveToScrollbackTop" },
        { key = "G", mods = "NONE", action = wezterm.action.CopyMode "MoveToScrollbackBottom" },
        { key = "u", mods = "CTRL", action = wezterm.action.CopyMode "PageUp" },
        { key = "d", mods = "CTRL", action = wezterm.action.CopyMode "PageDown" },
        { key = "b", mods = "CTRL", action = wezterm.action.CopyMode "PageUp" },
        { key = "f", mods = "CTRL", action = wezterm.action.CopyMode "PageDown" },
        -- 選択開始・終了
        { key = "v", mods = "NONE", action = wezterm.action.CopyMode { SetSelectionMode = "Cell" } },
        { key = "V", mods = "NONE", action = wezterm.action.CopyMode { SetSelectionMode = "Line" } },
        { key = "v", mods = "CTRL", action = wezterm.action.CopyMode { SetSelectionMode = "Block" } },
        -- コピーとモード終了
        { key = "y", mods = "NONE", action = wezterm.action.Multiple {
            { CopyTo = "ClipboardAndPrimarySelection" }
        }
    },
    { key = "Enter", mods = "NONE", action = wezterm.action.Multiple {
        { CopyTo = "ClipboardAndPrimarySelection" },
        { CopyMode = "Close" }
    }
},
-- 検索
{ key = "/", mods = "NONE", action = wezterm.action.Search { CaseSensitiveString = "" } },
{ key = "?", mods = "NONE", action = wezterm.action.Search { CaseInSensitiveString = "" } },
{ key = "n", mods = "NONE", action = wezterm.action.CopyMode "NextMatch" },
{ key = "N", mods = "NONE", action = wezterm.action.CopyMode "PriorMatch" },
-- モード終了
{ key = "q", mods = "NONE", action = wezterm.action.CopyMode "Close" },
{ key = "Escape", mods = "NONE", action = wezterm.action.CopyMode "Close" },
{ key = "c", mods = "CTRL", action = wezterm.action.CopyMode "Close" },
  },

  search_mode = {
      { key = "Enter", mods = "NONE", action = wezterm.action.CopyMode "PriorMatch" },
      { key = "Escape", mods = "NONE", action = wezterm.action.CopyMode "Close" },
      { key = "n", mods = "CTRL", action = wezterm.action.CopyMode "NextMatch" },
      { key = "p", mods = "CTRL", action = wezterm.action.CopyMode "PriorMatch" },
      { key = "r", mods = "CTRL", action = wezterm.action.CopyMode "CycleMatchType" },
      { key = "u", mods = "CTRL", action = wezterm.action.CopyMode "ClearPattern" },
  },
}

-- タブタイトルの設定
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local title = tab.tab_title
    if title and #title > 0 then
        return title
    end
    return tab.active_pane.title
end)

-- ウィンドウタイトルの設定
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
    local zoomed = ""
    if tab.active_pane.is_zoomed then
        zoomed = "[Z] "
    end

    local index = ""
    if #tabs > 1 then
        index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
    end

    return zoomed .. index .. tab.active_pane.title
end)

config.tab_bar_at_bottom = true

return config
