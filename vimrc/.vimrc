call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-tbone'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'luochen1990/rainbow'

Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }  " fzf is a fuzzy file search
Plug 'junegunn/fzf.vim'

Plug 'tmux-plugins/vim-tmux'

" Conquer of Completion
" Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

Plug 'JuliaEditorSupport/julia-vim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
" Plug 'roxma/nvim-completion-manager'  " optional

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'

" Autocompletion with Deoplete
" Plug 'Shougo/deoplete.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'

Plug 'SirVer/ultisnips'      " snippets engine
Plug 'honza/vim-snippets'  " actual snippets

" let g:ale_completion_enabled = 1 " must be set before ALE is loaded
" Plug 'dense-analysis/ale'  " syntax checking / linting

Plug 'sonph/onehalf', {'rtp': 'vim/'}

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

" map <Up> g<Up>
" map <Down> g<Down>
" imap <Up> <C-[> <Up> i
" imap <Down> <C-[> <Down> i

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" define highlight group for unwanted whitespace
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/

" highlight the current line
" :hi CursorLine cterm=bold
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

" Deoplete configuration
" set pyxversion=3
" let g:deoplete#enable_at_startup = 1

" Deoplete conflicts with LaTeX-to-Unicode completion
" autocmd FileType julia
"        \ call deoplete#custom#buffer_option('auto_complete', v:false)

" source ~/dotfiles/vimrc/coc.vim
source ~/dotfiles/vimrc/fzf.vim
source ~/dotfiles/vimrc/julia.vim
source ~/dotfiles/vimrc/markdown.vim
source ~/dotfiles/vimrc/vimtex.vim

source ~/dotfiles/vimrc/colorscheme.vim

set t_ZH=[3m
set t_ZR=[23m

" ALE configuration
" TOO DAMN SLOW!!!
" let g:ale_completion_enabled = 0
" let g:ale_sign_warning = '!'
" let g:ale_sign_error = '!!'
" " only run linters on save
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" " set omnifunc=ale#completion#OmniFunc
" " call deoplete#custom#option('sources', {
" "   \ '_': ['ale'],
" " \})

" UltiSnips configuration
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<s-tab>"
let g:UltiSniptsJumpBackwardTrigger="<c-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-ultisnips"]
