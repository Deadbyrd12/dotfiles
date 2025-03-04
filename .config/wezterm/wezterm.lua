local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.enable_wayland = true
config.hide_tab_bar_if_only_one_tab = true

config.color_scheme = 'AdventureTime'
config.font = wezterm.font 'JetBrains Mono'

config.keys = {
    {
        key = 'r',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },
}

-- and finally, return the configuration to wezterm
return config
