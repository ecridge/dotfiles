-- Jeo keyboard layout.
jeo = require 'jeospoon'
jeo.setEditor('MacVim')
jeo.setTerminal('Hyper')
jeoEventTap = hs.eventtap.new(jeo.KEY_EVENTS, jeo.handleKeyEvent)
jeoEventTap:start()
