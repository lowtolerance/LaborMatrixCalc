Gui, -caption +ToolWindow +HWNDguiID +AlwaysOnTop
Gui, Add, Picture, x0 y0 w9 h9 hwndPic, active.png
Gui, Show, Hide NoActivate

global laborHoursHandle := "WindowsForms10.EDIT.app.0.329445b_r9_ad12"
global LaborEntryWindow := "Order Item Entry - LABOR"

updateWindowPos() {
  WinGetPos, windowX, windowY, windowWidth, windowHeight, %LaborEntryWindow%
  ControlGetPos, controlX, controlY, controlWidth, controlHeight, %laborHoursHandle%, %LaborEntryWindow%
  xPos := controlX + windowX + controlWidth + 5
  yPos := controlY + windowY + 4
  if (xPos != Nothing) {
    Gui, Show, x%xPos% y%yPos% NoActivate
  }
}

hideGUI() {
  Gui, Show, hide
  return
}

showGUI() {
  if (disabled = 0) {
    updateWindowPos()
    return
  }
}