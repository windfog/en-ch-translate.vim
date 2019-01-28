if exists("b:current_syntax")
	finish
endif

syntax match explain_title '^.\{-}:'
syntax match querywords '\(^查找:\s\{2}\)\@<=.\+'
syntax match shortexplains '\(^翻译:\s\{2}\)\@<=.\+'
syntax match explains '\(^解释:\s\{2}\)\@<=\_.\+'

highlight g_queryword cterm=underline  ctermfg=green
highlight g_shortexplains cterm=bold ctermfg=red
highlight g_explains cterm=bold ctermfg=yellow

highlight link explain_title Title
highlight link querywords g_queryword
highlight link shortexplains g_shortexplains
highlight link explains g_explains

let b:current_syntax="explain"
