extends RigidBody2D


var beingDragged = false
var hoveredOn = false


func fuse(scaleUp):
	$'.'.mass *= scaleUp
	$Hitbox.scale *= scaleUp
	$Icon.scale *= scaleUp
	$FusionExplosion.emitting = true

func _ready() -> void:
	$'.'.set_pickable(true) # SUPER IMPORTANT!!! Mouse entered/exited won't trigger without this!
	$'.'.mouse_entered.connect(_mouse_entered)
	$'.'.mouse_exited.connect(_mouse_exited)


func requiredEnergyForFusion():
	#return %Nucleus.mass * %Nucleus.mass
	#return (1 + %Nucleus.mass) * (1 + %Nucleus.mass) * (1 + %Nucleus.mass)
	#return mass * mass * mass
	return (1 + mass) * (1 + mass) * 100
	#return mass * mass * 1000


func _mouse_entered():
	#print("part - hovered on")
	hoveredOn = true


func _mouse_exited():
	#print("part - hover exited")
	hoveredOn = false
