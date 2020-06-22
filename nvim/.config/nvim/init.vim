" File: vimrc
" Author: S. Numerius <parvus.mortalis@gmail.com>

" Preamble -------------------------------------------------------- {{{

" Use Unicode characters. Has to be at the top of the file.
" The order of these commands are important.
if has('multi_byte')
  set encoding=utf-8
  scriptencoding utf-8
  setglobal fileencodings=utf-8
endif

" Download vim-plug if not downloaded
if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
end
" }}}
" Vim-Plug -------------------------------------------------------- {{{
call plug#begin('~/.local/share/nvim/plugins')
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  Plug 'junegunn/limelight.vim'
  Plug 'kovetskiy/sxhkd-vim'
  Plug 'lifepillar/vim-colortemplate'
  Plug 'parmort/vim-audit'
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'PotatoesMaster/i3-vim-syntax'
  Plug 'romainl/vim-cool'
  Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
  Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  Plug 'vimjas/vim-python-pep8-indent', { 'for': 'python' }
  Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }

  " Colorscheme
  Plug '/home/nolan/code/mtntop'
call plug#end()
" }}}
" Settings ------------------------------------------------------- {{{

set nocompatible               " Make vim behave like vim, not vi
filetype plugin indent on      " Turn on filetype detection. See ':h filetype'
set hidden                     " Don't quit abandoned buffers
set nowrap                     " Don't wrap lines
set autoindent                 " Copy indent from previous line
set copyindent                 " Copy indent structure (i.e. tabs and spaces)
" set lazyredraw                 " Only redraw the screen when no user input occurs
set bs=eol,start,indent        " Make the backspace behave normally except indent
set clipboard=unnamedplus      " Make vim use the C-c clipboard
set scrolloff=3                " Set scrolloff
set linebreak                  " Wrap lines at `breakat`
setglobal spelllang=en_us      " Spellchecking
set signcolumn=yes

let s:TRUSTED_LOCAL = '.git/safe/../../.vimrc.local'
if filereadable(s:TRUSTED_LOCAL)
  execute "source " . s:TRUSTED_LOCAL
endif

" File Searching {{{{
set path+=**
set wildmenu
set wildignore=*.o,node_modules
" }}}}
" Belloff {{{{
if exists('&belloff')
  set belloff=all " Turn off all error sounds
endif
" }}}}
" Colorcolumn {{{{
if exists('+colorcolumn')
  set cc=81 " Make the colorcolumn appear on column 81
endif
" }}}}
" Numbering {{{{
if exists('+relativenumber')
  set relativenumber " Make fancy line numbers appear
endif
set nu               " Always have the current line number displayed
" }}}}
" Syntax {{{{
if exists('+syntax')
  set cursorline " Make it easier to see current line
endif
syntax enable             " Pretty colors
" }}}}
" Searching {{{{
if has('extra_search')
  set hlsearch " Highlight current search
  set incsearch " Jump to the closest match while typing search
endif
set ignorecase " Search is case-insensitive
" }}}}
" Listchars {{{{
" See `:h listchars`
set list
set listchars=trail:·
set listchars+=tab:»»
set listchars+=nbsp:∅
set listchars+=extends:»
set listchars+=precedes:«
" }}}}
" Indenting {{{{
" Make tabs be 2 characters in width and use spaces
cal custom#misc#settabspace(2)
set smarttab
set expandtab
set shiftround
" }}}}
" Fillchars {{{{
if has('folding')
  if has('windows')
    set fillchars=vert:┃ " Make the border between vertical windows seamless
  endif
endif
" }}}}
" Shortmess {{{{
" Shortmess `:h 'shortmess'`
set shortmess=filmnrx " Use abbreviations in messages
set shortmess+=I " Don't show the intro message
set shortmess+=A " Don't show the "Attention" swapfile message
" }}}}
" Window splitting {{{{
" Split to the bottom-right instead of top-left
if has('windows')
  set splitbelow
endif

if has('vertsplit')
  set splitright
endif
" }}}}
" Colorscheme {{{{
set background=dark " Give vim a dark background
set termguicolors

colorscheme mtntop

hi Comment cterm=italic gui=italic
autocmd FileType json syntax match Comment +\/\/.\+$+
" }}}}
" Statusline {{{{
set noshowmode
set laststatus=2

hi User1 guibg=#141416 guifg=#ffff82
hi User2 guibg=#141416 guifg=#60a84c
hi User3 guibg=NONE guifg=#60a84c

set statusline=
      \%1*%{custom#statusline#mode()}\ %2*%{custom#statusline#git()}%*%{custom#statusline#name()}\ %{custom#statusline#mod()}
      \%=%{custom#statusline#type()}\ %{custom#statusline#coc()}\ %{ObsessionStatus()}\
      \ [U+%0004.B]\ [%4.l/%4.Lℓ,\ %3.p%%]
" }}}}
" Tabline {{{{
if has('windows')
  set showtabline=2
  set tabline=%!custom#tabline#line()
endif
" }}}}
" Goyo {{{{
function! s:goyo_enter()
  set wrap
endfunction

function! s:goyo_leave()
  set nowrap
  SourceConf
endfunction

autocmd! User GoyoEnter nested call custom#goyo#goyo_enter()
autocmd! User GoyoLeave nested call custom#goyo#goyo_leave()
" }}}}
" vimtex {{{{
let g:vimtex_view_general_viewer = 'zathura'
" }}}}
" Endwise {{{{
let g:endwise_no_mappings = 0
"}}}}
" COC {{{{{
set cmdheight=2
set updatetime=300
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <Plug>CustomCocCR pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <silent> <space>r <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" }}}}}
" vim-rspec {{{{
let g:rspec_command = "call custom#misc#runspecs('{spec}')"
" }}}}

" }}}
" Commands -------------------------------------------------------- {{{

" Use a command to return to the git project root
command! Root cal custom#misc#groot()

" Focus current fold
command! FocusLine cal custom#misc#focusline()

" Reload configuration without losing filetype specific stuff
command! -bar SourceConf cal custom#misc#sourceConf()

command! -nargs=? -bar -bang -complete=customlist,custom#mks#complete Mksession cal custom#mks#mkses(<q-args>, <bang>0)
command! -nargs=? -bar -complete=customlist,custom#mks#complete Rmsession cal custom#mks#rmses(<q-args>)

command! -bang -nargs=0 QFix call QFixToggle(<bang>0)
function! QFixToggle(loc)
  if a:loc
    if exists("g:lfix_win")
      lclose
      unlet g:lfix_win
    else
      lopen 10
      let g:lfix_win = bufnr("$")
    endif
  else
    if exists("g:qfix_win")
      cclose
      unlet g:qfix_win
    else
      copen 10
      let g:qfix_win = bufnr("$")
    endif
  endif
endfunction
" }}}
" Mappings ------------------------------------------------------- {{{

" Prefix Keys {{{{
nnoremap <Space> <nop>
nnoremap <CR> <nop>

let mapleader = "\\"
let maplocalleader = ","
" }}}}

" Make enter behave correctly in the quickfix
au BufReadPost quickfix nnoremap <silent><buffer> <CR> <CR><C-w>j:q<CR>

" Swap ; and :
nnoremap ; :
nnoremap : ;

" Function Keys {{{{
set pastetoggle=<F2>
nnoremap <F3> :QFix<CR>
nnoremap <F4> :QFix!<CR>
" nnoremap <F5>
nnoremap <F6> :SpellToggle<CR>
" nnoremap <F7>
" nnoremap <F8>
" nnoremap <F9>
" nnoremap <F10>
" nnoremap <F12>
" }}}}

nnoremap <Space>q @q

" Still retain little-used functionality of comma
nnoremap ,, ,

" Stop using custom mappings for already decent mappings
nnoremap <leader>bn :echo "Use gt"<CR>
nnoremap <leader>bp :echo "Use gT"<CR>

nnoremap <leader>e ggVG

" Basic operations made simpler
nnoremap <leader>q :bd!<CR>
nnoremap <leader><S-q> :wqa!<CR>
nnoremap <leader><C-q> :qa!<CR>

" Spacing
nnoremap <leader><Tab> i<Tab><Esc>
nnoremap <leader><Space> i<Space><Esc>

" Delete unnecessary whitespace
nnoremap <leader>d<Tab> ma:%s/	/  /g<CR>`a:delmarks a<CR>
nnoremap <leader>d<Space> ma:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar>
      \ :nohl <Bar> :unlet _s <CR>`a:delmarks a<CR>

" Map za and zA to zx and zX
nnoremap zx za
nnoremap zX zA

" Make Y behave like other capitals
nnoremap Y y$

" Unimpaired++
call custom#misc#nunmap("[e")
call custom#misc#nunmap("]e")

nmap [ee <plug>unimpairedMoveUp
xmap [ee <plug>unimpairedMoveSelectionUp
nmap ]ee <plug>unimpairedMoveDown
xmap ]ee <plug>unimpairedMoveSelectionDown

nnoremap [ev :e ~/.config/nvim/init.vim<CR>
nnoremap ]ev :tabnew ~/.config/nvim/init.vim<CR>

nnoremap [ea :e ~/.config/nvim/autoload<CR>
nnoremap ]ea :tabnew ~/.config/nvim/autoload<CR>

nnoremap [ad :ALEDetail<CR>

" Text object for one character
onoremap <silent> ic :norm! v<CR>

" Make escape behave sanely in terminal mode
if has('nvim')
  tnoremap <ESC> <C-\><C-n>
endif

" Projectionist
nnoremap ga :A<CR>
nnoremap gr :R<CR>

" Remap CommandT mappings
nmap <C-p> <Plug>(CommandT)
nmap <leader>h <Plug>(CommandTHelp)
nmap <leader>s <Plug>(CommandTBuffer)
nmap <leader>j <nop>

" Open the gemfile; use find to err if file not found
nnoremap <leader>gg :find Gemfile<CR>

" TODO: Move to ruby ftplugin
nnoremap <silent> <localleader>c :%s/^[	\ ]*#[\ \n].*//g<CR>:%s/^\n//g<CR>:nohl<CR>gg

" Open Goyo
nnoremap go :Goyo<CR>

" Open Netrw in current folder
nnoremap <leader>x :Texplore<CR>

" I have a habit of holding shift for too long in v-line
vnoremap K k

" Dispatch
nnoremap <leader>d :Dispatch<CR>
" }}}
" Abbrevs --------------------------------------------------------- {{{

" Use update instead of write
cnoreabbrev w update

" Vim-Plug
cnoreabbrev pi PlugInstall
cnoreabbrev pu PlugUpdate
cnoreabbrev pc PlugClean

" Source vimrc
cnoreabbrev vs SourceConf

" Shebang
inoreabbrev <expr> #!! "#!/usr/bin/" . (empty(&filetype) ? 'bash' : 'env '.&filetype)

" }}}
" Macros ----------------------------------------------------------- {{{
augroup macros

  " Add a semicolon to the end of current line
  au FileType javascript,typescript,cpp,arduino,java nnoremap <CR>s maA;<Esc>`a:delmarks<Space>a<CR>
  au FileType vim nnoremap <CR>s maggOscriptencoding utf-8<Esc>`a:delmarks a<CR>

augroup END
" }}}
