-------------------------------------------------------------------------------
-- Automatically reload Hammerspoon when ~/.hammerspoon/*.lua changes
-------------------------------------------------------------------------------

function reloadConfig(files)
  local shouldReload = false

  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      shouldReload = true
    end
  end

  if shouldReload then
    hs.reload()
  end
end

reloadConfigWatcher = hs.pathwatcher.new(
  os.getenv("HOME") .. "/.hammerspoon/",
  reloadConfig
):start()

hs.notify.new({
  title = "Hammerspoon",
  informativeText = "Configuration reloaded"
}):send()
