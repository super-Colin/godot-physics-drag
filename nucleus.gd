extends RigidBody2D


var beingDragged = false
var hoveredOn = false




func _ready() -> void:
	$'.'.set_pickable(true) # SUPER IMPORTANT!!! Mouse entered/exited won't trigger without this!
	$'.'.mouse_entered.connect(_mouse_entered)
	$'.'.mouse_exited.connect(_mouse_exited)





func _mouse_entered():
	#print("part - hovered on")
	hoveredOn = true


func _mouse_exited():
	#print("part - hover exited")
	hoveredOn = false
