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