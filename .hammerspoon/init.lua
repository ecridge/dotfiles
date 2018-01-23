-------------------------------------------------------------------------------
-- Jeo keyboard layout
-------------------------------------------------------------------------------

jeo = require 'jeospoon'

jeo.setEditor('Google Chrome')

jeoEventTap = hs.eventtap.new(jeo.KEY_EVENTS, jeo.handleKeyEvent):start()
jeoEventTap:start()


-------------------------------------------------------------------------------
-- Toggle Jeo when a YubiKey is inserted
-------------------------------------------------------------------------------

yubikeyWatcher = hs.usb.watcher.new(function(event)
  if event.vendorName == 'Yubico' then
    if event.eventType == 'added' then
      jeo.enablePassThrough()
    else
      jeo.disablePassThrough()
    end
  end
end)

yubikeyWatcher:start()


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

-- TODO: Find a method of tying mouse events to a specific device. This means
--   that the right-hand command key can be mapped to Mission Control when it
--   originates from the mouse, and the sideways scrolling from the mouse can
--   be used to change spaces while sideways scrolling on the trackpad is just
--   interpreted as a pan.
--
--   Also: find out how to send <Esc>:w<Return> when Cmd-S is sent to Hyper.
--   My initial attempt didn't work for the save hotkey, and for the literal
--   Cmd-S combo is still didn't delete the original key presses.
