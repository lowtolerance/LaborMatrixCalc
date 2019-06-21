IniRead, configlaborRate, config.ini,  Main, LaborRate
IniRead, configFactor, config.ini, Main, Factor
global laborRate := configlaborRate
global factor := configFactor

Mult(hours) {
  mult := 1
  if (hours > 1) {
    mult := 1.01 + (Floor(hours) * factor)
  }
  return mult
}

CalcPrice(laborHours) {
  hours := Floor(laborHours)
  tenths := Mod(laborHours, 1)
  nextTier := (hours + 1) * laborRate * Mult(hours + 1)
  currentTier := hours * laborRate * Mult(hours)
  laborPrice := ((nextTier - currentTier) * tenths) + currentTier
  return format("{:0.2f}", laborPrice)
}

!+l::
WinGetActiveTitle, Title
ControlGetText, laborHours, WindowsForms10.EDIT.app.0.329445b_r9_ad12, %Title%
price := CalcPrice(laborHours)
ControlSetText, WindowsForms10.EDIT.app.0.329445b_r9_ad14, %price%, %Title%
