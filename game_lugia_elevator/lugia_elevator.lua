local elevatorOpCode = 167
local _onRecieveOpCode

local p_elevatorWindow
local p_unlockedFloors
local p_currentFloor

function init()
  p_elevatorWindow = g_ui.loadUI('lugia_elevator', rootWidget)
  g_game.handleExtended(elevatorOpCode, _onRecieveOpCode)
end

function terminate()
  g_game.unhandleExtended(elevatorOpCode, receiveData)
  p_elevatorWindow:destroy()
end

function show()
  p_elevatorWindow:show()
  p_elevatorWindow:raise()
  p_elevatorWindow:focus()
end

function hide()
  p_elevatorWindow:hide()
end

function _onRecieveOpCode(t)
  p_unlockedFloors = t.unlockedFloors
  p_currentFloor = t.currentFloor
  show()
end

function onClickButton(t)
  if not table.contains(p_unlockedFloors, tonumber(t)) then
    g_game.sendExtended(elevatorOpCode, -1)
    hide()
    return false
  end
  g_game.sendExtended(elevatorOpCode, tonumber(t))
  hide()
end