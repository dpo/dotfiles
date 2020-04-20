let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_latexmk_continuous = 0
let g:vimtex_indent_enabled = 0

" replace code by math in the editor
set conceallevel=1
let g:tex_conceal='abdmg'

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" only use chktex
" way too slow checking parentheses and braces: unuseable
" let g:ale_linters = {
" \   'latex': ['lacheck'],
" \}

" Autocompletion with Deoplete
" call deoplete#custom#var('omni', 'input_patterns', {
"   \ 'tex': g:vimtex#re#deoplete
" \})
