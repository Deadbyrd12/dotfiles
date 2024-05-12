local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- Appearance
config.color_scheme = 'Catppuccin Mocha'
config.default_prog = { 'powershell' }
config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true

-- Disable ligatures
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- Keybinds
config.disable_default_key_bindings = true
config.keys = {
    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'T', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = '!', mods = 'SHIFT|CTRL', action = act.SpawnTab 'DefaultDomain' },
    { key = '@', mods = 'SHIFT|CTRL', action = act.SpawnTab {DomainName = 'WSL:NixOS' } },
    { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = false } },

    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },

    { key = 'O', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'P', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },

    { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  }

return config
