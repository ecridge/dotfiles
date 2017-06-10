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


-------------------------------------------------------------------------------
-- Change spaces by rocking the scroll wheel
-------------------------------------------------------------------------------

-- XXX: This is very unreliable.

local scrollEvents = { hs.eventtap.event.types.scrollWheel }

mouseTap = hs.eventtap.new(scrollEvents , function(event)
  local deltaX = event:getProperty(12) -- Scroll wheel axis 2
  if deltaX ~= 0 then
    -- Rocked left or right: turn into space change hotkey.
    local dstKey = deltaX < 0 and 'right' or 'left'
    hs.eventtap.keyStroke({ 'ctrl' }, dstKey, 500)
    return true
  else
    -- Rocked up or down: leave for focused app.
    return false
  end
end)

mouseTap:start()
