extends Node2D





@export var isTarget = true

@export var weight = 0.1
var mousePull = 200.0






func _ready() -> void:
	#for orbiter in $'.'.get_node("Shell1").get_children():
		#print(orbiter)
		#orbiter.apply_central_impulse(Vector2(10, 0))
	if not isTarget:
		Globals.particleRef = $'.'
	%Nucleus.mass = weight

func _physics_process(delta: float) -> void:
	var pull = Vector2.ZERO
	if %Nucleus.beingDragged:
		pull = %Nucleus.get_local_mouse_position().normalized().rotated(%Nucleus.rotation) * mousePull
		#print("pulling - ", pull)
		%Nucleus.apply_central_force(pull)
	
	#for orbiter in $'.'.get_node("Shell1").get_children():
		#var relPos = orbiter.position - %Nucleus.position
		##var orbitalForce = (orbiter.position - %Nucleus.position) / (pow(orbiter.position.distance_to(%Nucleus.position), 2))
		##var orbitalForce = relPos.normalized().rotated(%Nucleus.rotation) * -100.0
		##var orbitalForce = relPos.normalized().rotated(PI/4) * -50.0 
		#var orbitalForce = relPos.normalized() * -50.0 
		#orbitalForce = orbitalForce / (pow(orbiter.position.distance_to(%Nucleus.position), 2)) * 100.0 
		##print("orbitalForce: ", orbitalForce)
		#orbiter.apply_central_force(orbitalForce)


func _input(event: InputEvent) -> void:
	if isTarget:
		return
	if Input.is_action_pressed("LeftClick"):
		if %Nucleus.hoveredOn:
			#print("dragging")
			%Nucleus.beingDragged = true
	elif Input.is_action_just_released("LeftClick"):
		%Nucleus.beingDragged = false
