local p_elevatorOpCode = 167
local _onRecieveOpCode

local p_elevatorWindow
local p_unlockedFloors
local p_currentFloor

local p_floorNumbers = 5

function init()
  p_elevatorWindow = g_ui.loadUI('lugia_elevator', rootWidget)
  g_game.handleExtended(p_elevatorOpCode, _onRecieveOpCode)
  for i = 1, p_floorNumbers do
    local button = p_elevatorWindow:getChildById('number'.. i)
    button:setOn(false)
  end
end

function terminate()
  g_game.unhandleExtended(p_elevatorOpCode, receiveData)
  p_elevatorWindow:destroy()
end

function show(i)
  p_elevatorWindow:show()
  p_elevatorWindow:raise()
  p_elevatorWindow:focus()
  local button = p_elevatorWindow:getChildById('number'.. i)
  button:setOn(true)
end

function hide()
  p_elevatorWindow:hide()
  for i = 1, p_floorNumbers do
    local button = p_elevatorWindow:getChildById('number'.. i)
    button:setOn(false)
  end
end

function _onRecieveOpCode(t)
  p_unlockedFloors = t.unlockedFloors
  p_currentFloor = t.currentFloor
  show(p_currentFloor)
end

function onClickButton(t)
  if not table.contains(p_unlockedFloors, tonumber(t)) then
    g_game.sendExtended(p_elevatorOpCode, -1)
    hide()
    return false
  end
  g_game.sendExtended(p_elevatorOpCode, tonumber(t))
  hide()
end