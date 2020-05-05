local composer = require( "composer" )
local socket = require("socket")
composer.gotoScene( "home" )

local isConnected = function(url)
  url = url or "www.google.com"
  local hostFound = true
  local con = socket.tcp()
  con:settimeout(3)
  if con:connect(url,80) == nil then
    hostFound = false
    native.showAlert("Sem conexão!", "Conecte-se à Internet.", {"OK"})
  else
  end
  return hostFound
end
isConnected()
    
  