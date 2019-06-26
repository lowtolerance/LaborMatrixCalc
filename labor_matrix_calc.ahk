#Include GUI.ahk
#Include Controllers.ahk
#Include Math.ahk

FileInstall, active.png, active.png
FileInstall, config.ini, config.ini

IniRead, autoCalcDisabled, config.ini, AutoCalc, Disabled
global disabled := autoCalcDisabled

Hotkey, !+l, setLaborPrice
Hotkey, !+a, disableAuto, On

Hotkey, If, disabled
Hotkey, !+a, enableAuto
Hotkey, If

SetTimer, checkIfLaborHoursFocused, 100
SetTimer, checkIfLaborScreenActive, 100
return

checkIfLaborHoursFocused() {
  if (isLaborHoursControlActive()) {
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