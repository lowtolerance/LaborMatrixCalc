FileInstall, active.png, active.png
FileInstall, config.ini, config.ini

IniRead, autoCalcDisabled, config.ini, AutoCalc, Disabled
global disabled := autoCalcDisabled

global laborHoursHandle := "WindowsForms10.EDIT.app.0.329445b_r9_ad12"
global laborPriceHandle := "WindowsForms10.EDIT.app.0.329445b_r9_ad14"
global NonStandardRateHandle := "WindowsForms10.BUTTON.app.0.329445b_r9_ad17"                         
global LaborEntryWindow := "Order Item Entry - LABOR"

global inactive := 1

Gui, -caption +ToolWindow +HWNDguiID +AlwaysOnTop
Gui, Add, Picture, x0 y0 w9 h9 hwndPic, active.png
Gui, Show, NoActivate

Hotkey, !+l, setLaborPrice
Hotkey, !+a, disableAuto, On

Hotkey, If, disabled
Hotkey, !+a, enableAuto
Hotkey, If

SetTimer, checkIfLaborHoursFocused, 100
SetTimer, checkIfLaborScreenActive, 500
return

updateWindowPos() {
  WinGetPos, windowX, windowY, windowWidth, windowHeight, %LaborEntryWindow%
  ControlGetPos, controlX, controlY, controlWidth, controlHeight, %laborHoursHandle%, %LaborEntryWindow%
  xPos := controlX + windowX + controlWidth + 5
  yPos := controlY + windowY + 4
  Gui, Show, x%xPos% y%yPos% NoActivate
}

isLaborHoursControlActive() {
  ControlGetFocus, focused, %LaborEntryWindow%
  if (focused = laborHoursHandle) {
    return 1
  } else {
    return 0
  }
}

isLaborScreenActive() {
  WinGetActiveTitle, ActiveTitle
  if (ActiveTitle = LaborEntryWindow) {
    return 1
  } else {
    return 0
  }
}

checkIfLaborHoursFocused() {
  if (inactive != 1 and isLaborHoursControlActive()) {
    setLaborPrice()
  }
  return
}

checkIfLaborScreenActive() {
  if (isLaborScreenActive()) {
    showGUI()
  }
  else {
    hideGUI()
  }
  return
}

mult(hours) {
  IniRead, factor, config.ini, Main, Factor
  mult := 1
  if (hours > 1) {
    mult := 1.01 + (Floor(hours) * factor)
  }
  return mult
}

calculatePrice(laborHours) {
  IniRead, laborRate, config.ini,  Main, LaborRate
  hours := Floor(laborHours)
  tenths := Mod(laborHours, 1)
  nextTier := (hours + 1) * laborRate * mult(hours + 1)
  currentTier := hours * laborRate * mult(hours)
  laborPrice := ((nextTier - currentTier) * tenths) + currentTier
  return format("{:0.2f}", laborPrice)
}

enableNonStandardRate() {
  PixelGetColor, checked, 34, 288, RGB
  if (checked = 0xFFFFFF) {
    ControlClick, %NonStandardRateHandle%, %LaborEntryWindow% 
  }
  return
}

getLaborHours() {
  ControlGetText, laborHours, %laborHoursHandle%, %LaborEntryWindow%
  return laborHours
}

setLaborPrice() {
  if (isLaborScreenActive()) {
    enableNonStandardRate()
    ControlSetText, %laborPriceHandle%, % calculatePrice(getLaborHours()), %LaborEntryWindow%
  }
  return
}

hideGUI() {
  Gui, Show, hide
  inactive :=1
  return
}

showGUI() {
  if (disabled = 0) {
    updateWindowPos()
    inactive := 0
    return
  }
}

disableAuto() {
  disabled := 1
  hideGUI()
}

enableAuto() {
  disabled := 0
  showGUI()
}

#If disabled
#If