let g:default_julia_version = '1.6'

" language server
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\   'julia': ['/Users/dpo/bin/julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       using Pkg;
\       import StaticLint;
\       import SymbolServer;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "");
\       server.runlinter = true;
\       run(server);
\   ']
\ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

let g:latex_to_unicode_auto = 0
let g:latex_to_unicode_file_types = ["julia", "markdown", "pandoc"]

" for vim-commentary
autocmd FileType julia setlocal commentstring=#\ %s
