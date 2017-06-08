-- Jeo keyboard layout.
jeo = require 'jeospoon'
jeo.setEditor('MacVim')
jeoEventTap = hs.eventtap.new(jeo.KEY_EVENTS, jeo.handleKeyEvent)
