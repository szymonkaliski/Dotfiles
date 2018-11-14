local cache  = { prevConnectedName = nil }
local module = { cache = cache }

local log    = hs.logger.new('viscosity', 'debug');

local getConnectedName = function()
  local _, result = hs.applescript.applescript([[
    tell application "Viscosity" to return name of first connection whose state is "connected"
  ]])

  if result == "" then return nil end
  return result
end

local disconnectVPN = function(connectionName)
  hs.applescript.applescript([[tell application "Viscosity" to disconnect "]] .. connectionName .. [["]])
end

local connectVPN = function(connectionName)
  if connectionName == nil then
    log.e("can't connect without connectionName!")
    return
  end

  hs.applescript.applescript([[tell application "Viscosity" to connect "]] .. connectionName .. [["]])
end

module.start = function()
  cache.prevConnectedName = getConnectedName()

  hs.hotkey.bind({ 'cmd', 'alt', 'ctrl' }, 'v', function()
    local connectedName = getConnectedName()

    if connectedName then
      disconnectVPN(connectedName)
    else
      connectVPN(cache.prevConnectedName)
    end

    cache.prevConnectedName = connectedName
  end)
end

module.stop = function()
end

return module