" Author: N. Prochnau <parvus.mortalis@gmail.com>
" vim: foldmethod=marker

" Preamble -------------------------------------------------------- {{{

" Use Unicode characters. Has to be at the top of the file.
" The order of these commands are important.
if has('multi_byte')
  set encoding=utf-8
  scriptencoding utf-8
  setglobal fileencodings=utf-8
endif

if !has('nvim')
  set runtimepath+=$XDG_CONFIG_HOME/nvim,$XDG_CONFIG_HOME/nvim/after
  set packpath+=$XDG_CONFIG_HOME/nvim,$XDG_CONFIG_HOME/nvim/after
  set term=xterm-256color
endif

" Open the current directory if no command-line arguments were passed in
if has('vim_starting') && !argc(-1)
  edit .
endif

" }}}
" Plugins --------------------------------------------------------- {{{
if &loadplugins
  if has('packages')
    " Misc.
    packadd! vim-obsession
    packadd! vim-eunuch
    packadd! vim-unimpaired
    packadd! vim-rsi
    packadd! vim-repeat
    packadd! vim-scriptease

    " Focus / Zen
    packadd! goyo.vim
    packadd! limelight.vim

    " Tie-ins
    packadd! vim-tmux-navigator
    packadd! vim-fugitive
    packadd! vim-dispatch
    packadd! vim-dadbod

    " Misc. Filetypes
    packadd! vim-cpp-modern
    packadd! sxhkd-vim
    packadd! vim-ledger
    packadd! vim-javascript
    packadd! nlua.nvim
    packadd! vimtex

    " Code completion
    packadd! nvim-treesitter
    packadd! vim-closer
    packadd! nvim-lsp
    packadd! vim-commentary
    packadd! vim-endwise
    packadd! vim-ragtag
    packadd! vim-surround

    packadd! deoplete.nvim
    packadd! deoplete-lsp

    " Ruby
    packadd! vim-rails
    packadd! vim-bundler

    " Python
    packadd! SimpylFold
    packadd! vim-python-pep8-indent

    " Navigation
    packadd! telescope.nvim
    packadd! vim-dirvish
    packadd! vim-projectionist
    packadd! loupe

    " Libs
    packadd! plenary.nvim
    packadd! popup.nvim

    " Colorscheme
    packadd! vim-one
    packadd! seoul256.vim
  else
    " Catchall, in case I'm ever using an old vim (Hey, wait! You use neovim!)
    source $HOME/.config/nvim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
    call pathogen#infect('pack/bundle/opt/{}')
  endif
endif

" }}}
" Commands -------------------------------------------------------- {{{

" Focus current fold
command! FocusLine call parmort#focusline()

" Reload configuration without losing filetype specific stuff
command! -bar SourceConf call parmort#sourceConf()

command! -nargs=? -bar -bang -complete=customlist,parmort#mks#complete Mksession call parmort#mks#mkses(<q-args>, <bang>0)
command! -nargs=? -bar -complete=customlist,parmort#mks#complete Rmsession call parmort#mks#rmses(<q-args>)
" }}}
" Mappings ------------------------------------------------------- {{{

" Prefix Keys {{{{
let mapleader = " "
let maplocalleader = "\\"
" }}}}

" Swap ; and :
nnoremap ; :
nnoremap : ;

function! s:loclist()
  try
    lw
  catch /^Vim\%((\a\+)\)\=:E776/
  endtry
endfunction

nnoremap <F3> <cmd>cw<CR>
nnoremap <F4> <cmd>lw<CR>
nnoremap <F6> <cmd>SpellToggle<CR>

" Get used to new mappings
nnoremap <localleader>q <cmd>echo "Use Space q"<CR>
nnoremap <localleader><S-q> <cmd>echo "Use Space S-q"<CR>
nnoremap <localleader><C-q> <cmd>echo "Use Space C-q"<CR>

" Basic operations made simpler
nnoremap <leader>q <cmd>bd!<CR>
nnoremap <leader><S-q> <cmd>wqa!<CR>
nnoremap <leader><C-q> <cmd>qa!<CR>

" Map za and zA to zx and zX
nnoremap zx za
nnoremap zX zA

" Make Y behave like other capitals
nnoremap Y y$

" Unimpaired++
call parmort#nunmap("[e")
call parmort#nunmap("]e")

nmap [ee <plug>unimpairedMoveUp
xmap [ee <plug>unimpairedMoveSelectionUp
nmap ]ee <plug>unimpairedMoveDown
xmap ]ee <plug>unimpairedMoveSelectionDown

" Open vimrc in current or new tab
nnoremap [ev <cmd>e ~/.config/nvim/init.vim<CR>
nnoremap ]ev <cmd>tabnew ~/.config/nvim/init.vim<CR>

" Open vim folder in current or new tab
nnoremap [ea <cmd>e ~/.config/nvim<CR>
nnoremap ]ea <cmd>tabnew ~/.config/nvim<CR>

" Select all the things
nnoremap [h ggVG

" Text object for one character (for mnemonic purposes)
onoremap <silent> ic <cmd>norm! v<CR>

" Make escape behave sanely in terminal mode
if has('nvim')
  tnoremap <ESC> <C-\><C-n>
endif

" Projectionist
nnoremap ga <cmd>A<CR>

" Open Goyo
nnoremap go <cmd>Goyo<CR>

" Open directory in current folder
nnoremap <leader>x <cmd>tabnew .<CR>

" I have a habit of holding shift for too long in v-line
vnoremap K k

" Dispatch
nnoremap <leader>d <cmd>Dispatch<CR>
nnoremap <leader>m <cmd>Make<CR>

" Loupe
nnoremap <nop> <Plug>(LoupeClearHighlight)

" Fugitive
nnoremap <leader>g <cmd>G<CR>

" Turn off highlighting
nnoremap <silent> gl :nohlsearch<C-R>=has('diff')?'<BAR>diffupdate':''<CR><CR>

" }}}
" Abbrevs --------------------------------------------------------- {{{

" Use update instead of write
cnoreabbrev w update

" Source vimrc
cnoreabbrev vs SourceConf

" }}}
