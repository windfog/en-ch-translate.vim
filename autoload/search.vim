"execute vim internal command py or py3 to execute python module
exec g:python_vim_cmd . 'import vim'
exec g:python_vim_cmd . 'import sys'
exec g:python_vim_cmd . 'cwd = vim.eval("expand(\"<sfile>:p:h\")")'
exec g:python_vim_cmd . 'sys.path.insert(0,cwd)'
exec g:python_vim_cmd . 'from TranslateUtil import search'

function! search#SearchExplainByPython(words)
	exec g:python_vim_cmd . 'search.searchExplainByPython()'
endfunction

function! search#SearchExplain(type,...)
	if a:0
		silent execute "normal! gvy"
	elseif a:type == "line"
		silent execute "normal! '[V']y"
	else
		silent execute "normal! `[v`]y"
	endif
	call search#SearchExplainByPython(@@)
endfunction

function! s:WindowConfig()
	setl filetype=explain
	setl buftype=nofile
	setl bufhidden=hide
	setl noswapfile
	setl noreadonly
	setl nomodifiable
	setl nobuflisted
	setl nolist
	nnoremap <silent><buffer> q :close<CR>:call <SID>GoToLastWind()<CR>
endfunction

function! s:GoToLastWind()
	let cw=bufwinnr(g:lastbufName)
	execute cw . " wincmd w" 
endfunction

function! search#GetExplainWindowID()
	let g:lastbufName=bufname("%")
	let cwin=bufwinnr("__ExplainWindow__")
	if cwin == -1
		silent keepalt bo split __ExplainWindow__
		call s:WindowConfig()
		return winnr()
	else
		return cwin
	endif
endfunction
