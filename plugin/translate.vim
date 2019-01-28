if !has('python') && !has('python3')
	echoerr "your vim has no python feather compiled with,en-ch-translate,exist!"
	finish
else
	if has('python')
		let g:python_version=2
		let g:python_vim_cmd="py "
	else
		let g:python_version=3
		let g:python_vim_cmd="py3 "
	endif
endif

if exists('g:loaded_translate_plugin')
	echom "en-ch-translate-plugin has already been loaded before!"
	finish	
endif
let g:loaded_translate_plugin=1

nnoremap <silent> <leader>w :set operatorfunc=search#SearchExplain<CR>g@
vnoremap <silent> <leader>w :<C-U>call search#SearchExplain(visualmode(),1)<CR>

command! -nargs=1 Dict call search#SearchExplainByPython(<f-args>)

