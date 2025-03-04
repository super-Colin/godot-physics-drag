extends Control


func _ready() -> void:
	%Reset.pressed.connect(resetShot)
	EnergyBank.s_energyChanged.connect(updateEnergyReserveLabels)
	EnergyBank.s_generatedEnergyChanged.connect(updateEnergyGeneratedLabels)
	%ReservesBar.max_value = EnergyBank.energyReserveMax
	%ReservesBar.value = EnergyBank.energyReserve
	updateEnergyReserveLabels()
	updateEnergyGeneratedLabels()

func resetShot():
	Globals.s_resetCannon.emit()
	Globals.s_resetChamber.emit()
	EnergyBank.fill()

func updateEnergyReserveLabels():
	%ReservesBar.value = EnergyBank.energyReserve

func updateEnergyGeneratedLabels():
	%GeneratedBar.value = EnergyBank.generatedEnergy
