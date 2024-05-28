-- Set OS
-- if os.getenv('WSL_DISTRO_NAME') then -> wsl
-- if vim.fn.has("win32") or vim.fn.has("win32unix") then
--     vim.g.os = "Windows"
-- elseif vim.fn.has("unix") then
--     vim.g.os = "Linux"
-- elseif vim.fn.has("macunix") then
--     vim.g.os = "Mac"
-- end

-- Get local clipboard provider
function local_clipboard()
    -- Use win32yank if available.
    -- This ensures the system clipboard is used in WSL (even if accessed via SSH)
    if vim.fn.executable("win32yank.exe") ~= 0 then
        return {
            name = "win32yank",
            copy = { "win32yank.exe", "-i", "--crlf" },
            paste = { "win32yank.exe", "-o", "--lf" },
        }
    -- TODO try other clipboard providers (xclip, wlclip, tmux, etc.)
    -- Fallback: Use a local clipboard file to sync between neovim instances
    else
        return {
            name = "clipfile",
            copy = { "tee", vim.env.HOME .. "/.vimclip" },
            paste = { "cat", vim.env.HOME .. "/.vimclip" }
        }
    end
end

local copy_remote = require('vim.ui.clipboard.osc52').copy
local local_clip = local_clipboard()
if local_clip then
    vim.g.clipboard = {
        name = "local:" .. local_clip.name,
        copy = {
            ["+"] = function(lines)
                copy_remote("+")(lines)
                vim.fn.system(local_clip.copy, lines)
            end,
            ["*"] = function(lines)
                copy_remote("*")(lines)
                vim.fn.system(local_clip.copy, lines)
            end,
        },
        paste = {
            ["+"] = local_clip.paste,
            ["*"] = local_clip.paste
        }
    }
    vim.opt.clipboard = "unnamedplus"               -- use + as default register for clipboard operations
end

vim.opt.backup = false                          -- creates a backup file
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
-- vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = false                  -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications

vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 0                          -- the number of spaces inserted for each indentation (0 => tabstop)
vim.opt.tabstop = 4                             -- insert 2 spaces for a tab
vim.opt.smartindent = false
vim.opt.cindent = true
vim.opt.cinkeys:remove('0#')                    -- Fix comment indentation
