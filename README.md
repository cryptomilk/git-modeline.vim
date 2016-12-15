git-modeline.vim
================

Vim plugin reading modelines from the git config

Configuration
-------------

The plugin applies modelines specified in the git config to the current vim
buffer. The plugin works with vim and neovim.
To set a modeline in the git config you can do it with the following command:

    git config --add vim.modeline "tabstop=8 shiftwidth=8 noexpandtab cindent"

To set a format specific modeline (you'll need the filetype plugin on), just
define a vim.modeline.<FT> git config entry.

Example, C indented with 4 spaces, but Makefile with 8 space tabs:

    git config --add vim.modeline-c "ts=4 sw=4 et"
    git config --add vim.modeline-make "ts=8 sw=8 noet"

If no filetype specific entry can be found it will use the default modeline.

The allowed modelines are defined in a variable and can be overwritten and
extended by setting the following in your .vimrc:

    let g:git_modeline_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "cindent",     "cin",  "nocindent", "nocin",
                \ "smartindent", "si",   "nosmartindent", "nosi",
                \ "autoindent",  "ai",   "noautoindent", "noai",
                \ "spell",
                \ "spelllang"
                \ ]
