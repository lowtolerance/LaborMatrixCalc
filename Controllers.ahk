global LaborEntryWindow := "Order Item Entry - LABOR"
global laborHoursHandle := "WindowsForms10.EDIT.app.0.329445b_r9_ad12"
global laborPriceHandle := "WindowsForms10.EDIT.app.0.329445b_r9_ad14"
global NonStandardRateHandle := "WindowsForms10.BUTTON.app.0.329445b_r9_ad17"   

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

Hotkey, !+l, setLaborPrice
setLaborPrice() {
  if (isLaborScreenActive()) {
    enableNonStandardRate()
    ControlSetText, %laborPriceHandle%, % calculatePrice(getLaborHours()), %LaborEntryWindow%
  }
  return
}