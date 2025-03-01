extends RigidBody2D


var beingDragged = false
var hoveredOn = false

var weight = 1.0
var mousePull = 10.0




func _ready() -> void:
	$'.'.set_pickable(true)
	$'.'.mouse_entered.connect(_mouse_entered)
	$'.'.mouse_exited.connect(_mouse_exited)

func _physics_process(delta: float) -> void:
	#print("relative mouse position: ", get_local_mouse_position(), ", rotation: ", $'.'.rotation, ", applying force: ", test)
	if beingDragged:
		print("part - being draggedd")
		var pull = get_local_mouse_position().normalized().rotated($'.'.rotation) * mousePull
		$'.'.apply_central_force(pull)




func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("LeftClick"):
		if hoveredOn:
			beingDragged = true
	else:
		beingDragged = false

func _mouse_entered():
	print("part - hovered on")
	hoveredOn = true


func _mouse_exited():
	print("part - hover exited")
	hoveredOn = false
