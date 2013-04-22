" vim: set sw=4 sts=4 et ft=vim :
" Script:           git_modeline.vim
" Author:           Andreas Schneider <asn@cryptomilk.org>
" Info:             Based on securemodelines by
"                   Ciaran McCreesh <ciaran.mccreesh at googlemail.com>
" Requires:         Vim 7
" License:          Redistribute under the same terms as Vim itself
" Purpose:          A git config vim modeline parser
"
" git config --add vim.modeline "tabstop=8 shiftwidth=8 noexpandtab cindent"

if &compatible || v:version < 700 || exists('g:loaded_git_modeline')
    finish
endif
let g:loaded_git_modeline = 1

if (! exists("g:git_modeline_allowed_items"))
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
endif

if (! exists("g:git_modeline_verbose"))
    let g:git_modeline_verbose = 0
endif

fun! <SID>IsInList(list, i) abort
    for l:item in a:list
        if a:i == l:item
            return 1
        endif
    endfor
    return 0
endfun

fun! <SID>DoOne(item) abort
    let l:matches = matchlist(a:item, '^\([a-z]\+\)\%([-+^]\?=[a-zA-Z0-9_\-.]\+\)\?$')
    if len(l:matches) > 0
        if <SID>IsInList(g:git_modeline_allowed_items, l:matches[1])
            exec "setlocal " . a:item
        elseif g:git_modeline_verbose
            echohl WarningMsg
            echo "Ignoring '" . a:item . "' in modeline"
            echohl None
        endif
    endif
endfun

fun! <SID>DoSetModeline(line) abort
    for l:item in split(a:line)
        call <SID>DoOne(l:item)
    endfor
endfun

fun! <SID>GitConfigModeline() abort
    let git_config_modeline = system("git config --get vim.modeline")
    if strlen(git_config_modeline)
        call <SID>DoSetModeline(git_config_modeline)
    endif
endfun

aug GitConfigModelines
    autocmd!
    autocmd BufNewFile,BufRead,StdinReadPost * :call <SID>GitConfigModeline()
aug END
