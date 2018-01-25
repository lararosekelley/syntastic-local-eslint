" --------
" File: syntastic-local-eslint/ftplugin/vue.vim
" Description: Make Syntastic use node_modules/.bin/eslint if possible
" Author: Ty-Lucas Kelley <tylucaskelley@gmail.com>
" Source: https://github.com/tylucaskelley/syntastic-local-eslint
" Last Modified: 25 January 2018
" --------

" get node_modules path
function! s:GetNodeModules()
    " save vim cwd
    let vim_cwd = fnameescape(getcwd())

    " change directory to this folder
    silent! exec 'lcd' expand('%:p:h')

    let node_modules = finddir('node_modules', '.;')
    exec 'lcd' vim_cwd

    return node_modules is? '' ? '' : fnamemodify(node_modules, ':p')
endfunction

" get local eslint executable
function s:GetEslint(node_modules)
    let eslint_bin = a:node_modules is? '' ? '' : a:node_modules . '.bin/eslint'
    return exepath(eslint_bin)
endfunction

" set local eslint executable if found
function s:SetEslint(eslint)
    if a:eslint isnot? ''
        let b:syntastic_vue_eslint_exec = a:eslint
    endif
endfunction

" tell syntastic which eslint to use
function! s:main()
    let node_modules = s:GetNodeModules()
    let eslint = s:GetEslint(node_modules)

    call s:SetEslint(eslint)
endfunction

call s:main()
