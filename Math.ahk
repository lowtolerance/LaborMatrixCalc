IniRead, configFactor, config.ini, Main, Factor
IniRead, configLaborRate, config.ini,  Main, LaborRate
global factor := configFactor
global laborRate := configLaborRate

mult(hours) {
  mult := 1
  if (hours > 1) {
    mult := 1.01 + (Floor(hours) * factor)
  }
  return mult
}

calculatePrice(laborHours) {
  hours := Floor(laborHours)
  tenths := Mod(laborHours, 1)
  nextTier := (hours + 1) * laborRate * mult(hours + 1)
  currentTier := hours * laborRate * mult(hours)
  laborPrice := ((nextTier - currentTier) * tenths) + currentTier
  return format("{:0.2f}", laborPrice)
}