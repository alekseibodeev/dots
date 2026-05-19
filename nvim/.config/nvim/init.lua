-- Set <space> as the leader key
-- See `:h mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- OPTIONS
--
-- See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:h option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

-- Use 4 spaces to insert a <Tab>
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.expandtab = true

-- Show a line width guide at 80 characters
vim.o.colorcolumn = '80'

vim.o.number = true -- Show line numbers in a column.

-- Show line numbers relative to where the cursor is.
-- Affects the 'number' option above, see `:h number_relativenumber`.
vim.o.relativenumber = true

-- Always show a sing column
vim.o.signcolumn = 'yes'

-- Turn off line wraps
vim.o.wrap = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 10    -- Keep this many screen lines above/below the cursor.
vim.o.list = true       -- Show <tab> and trailing spaces.

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true

-- KEYMAPS
--
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Map <leader>y to yank to the system's clipboard
vim.keymap.set({ 'n', 'v', }, '<leader>y', '"+y')
-- Map <leader>p to past from the system's clipboard
vim.keymap.set({ 'n', 'v', }, '<leader>p', '"+p')

-- AUTOCOMMANDS (EVENT HANDLERS)
--
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.hl.on_yank()
    end,
})

-- USER COMMANDS: DEFINE CUSTOM COMMANDS
--
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
    local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
    local filename = vim.api.nvim_buf_get_name(0)
    print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename, })
        :wait().stdout)
end, { desc = 'Print the git blame for the current line', })

-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd('packadd! nohlsearch')

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add({
    -- Base16 color schemes
    { src = 'https://github.com/RRethy/base16-nvim', },
    -- File explorer
    { src = 'https://github.com/stevearc/oil.nvim', },
    -- Utility functions !!REQUIRED by telescope!!
    { src = 'https://github.com/nvim-lua/plenary.nvim', },
    -- Fuzzy finder
    { src = 'https://github.com/nvim-telescope/telescope.nvim', },
    -- Autocompletion
    { src = 'https://github.com/nvim-mini/mini.completion', },
    -- Git integration
    { src = 'https://github.com/lewis6991/gitsigns.nvim', },
})

vim.cmd('colorscheme base16-selenized-dark')

require('oil').setup()
vim.keymap.set('n', '-', '<cmd>Oil<cr>')

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files)
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep)

if vim.fn.executable('lua-language-server') == 1 then
    vim.lsp.enable('lua_ls')
end

if vim.fn.executable('pyright') == 1 then
    vim.lsp.enable('pyright')
end

if vim.fn.executable('ruff') == 1 then
    vim.lsp.enable('ruff')
end

if vim.fn.executable('bash-language-server') == 1 then
    vim.lsp.enable('bashls')
end

vim.keymap.set({ 'n', 'v', 'x', }, '<leader>lf', vim.lsp.buf.format)

require('mini.completion').setup()
require('gitsigns').setup()

-- DIAGNOSTIC
--
-- See `:h vim.diagnostic`

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})
