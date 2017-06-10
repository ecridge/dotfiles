-------------------------------------------------------------------------------
-- Jeo keyboard layout
-------------------------------------------------------------------------------

jeo = require 'jeospoon'

jeo.setEditor('MacVim')
jeo.setTerminal('Hyper')

jeoEventTap = hs.eventtap.new(jeo.KEY_EVENTS, jeo.handleKeyEvent):start()
jeoEventTap:start()


-- TODO: Jeo <=> QWERTY when YubiKey inserted/removed.


-------------------------------------------------------------------------------
-- Allow forward delete to remove files in Finder
-------------------------------------------------------------------------------

finderDeleteTap = hs.eventtap.new(jeo.KEY_EVENTS, function(event)
  if hs.keycodes.map[event:getKeyCode()] == 'forwarddelete' then
    local keyDown = event:getType() == hs.eventtap.event.types.keyDown
    local newEvent = hs.eventtap.event.newKeyEvent({ 'cmd' }, 'delete', keyDown)
    newEvent:setProperty(42, 5462350) -- See jeospoon/init.lua
    return true, { newEvent }
  end
end)

function toggleFinderDelete(appName, eventType)
  if appName == 'Finder' then
    if eventType == hs.application.watcher.activated then
      finderDeleteTap:start()
    elseif eventType == hs.application.watcher.deactivated then
      finderDeleteTap:stop()
    end
  end
end

finderDeleteWatcher = hs.application.watcher.new(toggleFinderDelete)
finderDeleteWatcher:start()
