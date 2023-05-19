setlocal noexpandtab
setlocal tabstop=8
setlocal softtabstop=0
setlocal shiftwidth=8

augroup golang
    autocmd!

    " Try to autoformat using goimports (golang.org/x/tools/cmd/goimports),
    " or if that's not available, 'go fmt'.
    if executable("goimports")
        autocmd BufWritePost *.go silent !goimports -w % 2>/dev/null
    elseif executable("go")
        autocmd BufWritePost *.go silent !go fmt % 2>/dev/null
    endif
augroup END
