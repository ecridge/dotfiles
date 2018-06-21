"------------------------------------------------------------------------------
" editorconfig/editorconfig: respect .editorconfig rules
"------------------------------------------------------------------------------

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
