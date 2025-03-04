extends Control

signal s_energyChanged
signal s_generatedEnergyChanged

var energyReserveMax = 200
var energyUsageRate = 1.0
var energyReserve = 200:
	set(val):
		energyReserve = val
		s_energyChanged.emit()

var generatedEnergyMax:float = 1000.0
var generatedEnergyUsage:float = 0.5
var generatedEnergy:float = 0.0:
	set(val):
		generatedEnergy = val
		s_generatedEnergyChanged.emit()


func addGeneratedEnergy(amount):
	generatedEnergy += amount


func useEnergyDragging():
	if energyReserve > energyUsageRate:
		energyReserve -= energyUsageRate
		return true
	return false


func fill():
	energyReserve = energyReserveMax
