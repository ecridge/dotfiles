"------------------------------------------------------------------------------
" Go-specific autocommands
"------------------------------------------------------------------------------

aug GoSpecific
  au!
  au FileType go setl cc= | setl tw=80
  au FileType go setl sw=4 | setl ts=4 | setl noet
  au FileType go setl listchars=extends:$,nbsp:+,precedes:$,tab:\ \ ,trail:-
  au FileType go setl com=:// | setl fo+=ar
aug END
