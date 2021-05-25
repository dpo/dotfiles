call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-tbone'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

Plug 'luochen1990/rainbow'

Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }  " fzf is a fuzzy file search
Plug 'junegunn/fzf.vim'

Plug 'tmux-plugins/vim-tmux'

Plug 'JuliaEditorSupport/julia-vim'
Plug 'kdheepak/JuliaFormatter.vim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
" Plug 'roxma/nvim-completion-manager'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'

Plug 'SirVer/ultisnips'      " snippets engine
Plug 'honza/vim-snippets'  " actual snippets

" Plug 'lifepillar/vim-mucomplete'  " autocompletion

Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'cocopon/iceberg.vim'

" Initialize plugin system
call plug#end()

" local customization
set expandtab        " Replace all tabs by spaces.
set textwidth=0      " Do not limit the number of columns in general.
set shiftwidth=2     " Number of spaces to auto indent.
set tabstop=2        " Default width of a tab.
set shiftround       " Use multiple of shiftwidth when indenting with '<' and '>'.
set scrolloff=3      " Keep 3 context lines above and below the cursor.
set linebreak        " Don't wrap text in the middle of a word.
set number           " Show line numbers.
autocmd BufEnter * silent! lcd %:p:h  " automatically change to current file's dir

set cmdheight=2      " Get rid of pesky 'Press ENTER or type command to continue'

" GitGutter configuration
set updatetime=100   " update time for gitgutter symbols in ms
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

" indent blocks visually with persistent selection
vnoremap > >gv
vnoremap < <gv

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" define highlight group for unwanted whitespace
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/

" automatically remove trailing whitespace when saving
autocmd BufWritePre * %s/\s\+$//e

" highlight cursor line
" see colorscheme.vim for details
:set cursorline

" Rainbow parens
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\ 'separately': {
\		'*': {},
\   'julia': {
\     'parentheses_options': 'containedin=juliarawString contained',
\   },
\ },
\}

" source ~/dotfiles/vimrc/coc.vim
source ~/dotfiles/vimrc/fzf.vim
source ~/dotfiles/vimrc/julia.vim
source ~/dotfiles/vimrc/markdown.vim
source ~/dotfiles/vimrc/vimtex.vim

source ~/dotfiles/vimrc/colorscheme.vim

set t_ZH=[3m
set t_ZR=[23m

" mucomplete configuration
" let g:mucomplete#enable_auto_at_startup = 1
" let g:mucomplete#completion_delay = 1
" set completeopt+=menuone
" set completeopt+=noselect
" set shortmess+=c   " Shut off completion messages
" set belloff+=ctrlg " If Vim beeps during completion

" UltiSnips configuration
let g:UltiSnipsExpandTrigger = "<tab>"        " Do not use <tab>
let g:UltiSnipsJumpForwardTrigger = "<s-tab>"  " Do not use <c-j>
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<s-tab>"
" let g:UltiSniptsJumpBackwardTrigger="<c-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-ultisnips"]

" see MuComplete documentation on conflict with UltiSnips
" let g:ulti_expand_or_jump_res = 0

" fun! TryUltiSnips()
"   if !pumvisible() " With the pop-up menu open, let Tab move down
"     call UltiSnips#ExpandSnippetOrJump()
"   endif
"   return ''
" endf

" fun! TryMUcomplete()
"   return g:ulti_expand_or_jump_res ? "" : "\<plug>(MUcompleteFwd)"
" endf

" inoremap <plug>(TryUlti) <c-r>=TryUltiSnips()<cr>
" imap <expr> <silent> <plug>(TryMU) TryMUcomplete()
" imap <expr> <silent> <tab> "\<plug>(TryUlti)\<plug>(TryMU)"

