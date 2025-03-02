extends Node2D





@export var weight = 0.1
@export var isTarget = true

var mousePull = 1000.0






func _ready() -> void:
	#for orbiter in $'.'.get_node("Shell1").get_children():
		#print(orbiter)
		#orbiter.apply_central_impulse(Vector2(10, 0))
	if not isTarget:
		Globals.particleRef = $'.'
	%Nucleus.mass = weight
	%Nucleus.body_entered.connect(handleCollision)


#func handleCollision(rid, body, bodyIndex, shapeIndex):
func handleCollision(body):
	if isTarget:
		return
	print("collision: ", body)
	if "mass" in body:
		#print("weight : ", body.mass)
		if isEnoughForFusion(body):
			print("bam!")
			$'.'.queue_free()
			body.get_parent().queue_free()


func isEnoughForFusion(body:Node)->bool:
	#var selfEnergy = %Nucleus.linear_velocity * %Nucleus.mass
	var selfEnergy = abs(%Nucleus.linear_velocity.x) + abs(%Nucleus.linear_velocity.y) * %Nucleus.mass * 0.0001
	#var otherEnergy = body.linear_velocity * body.mass
	var otherEnergy = abs(body.linear_velocity.x) + abs(body.linear_velocity.y) * body.mass
	print("selfEnergy: ", selfEnergy, ", otherEnergy: ", otherEnergy, ", requiredEnergyForFusion: ", body.requiredEnergyForFusion())
	#if selfEnergy >= (%Nucleus.requiredEnergyForFusion() + body.requiredEnergyForFusion()):
	if selfEnergy >= body.requiredEnergyForFusion():
		return true
	return false


func _physics_process(delta: float) -> void:
	var pull = Vector2.ZERO
	if %Nucleus.beingDragged:
		pull = %Nucleus.get_local_mouse_position().normalized().rotated(%Nucleus.rotation) * mousePull
		#print("pulling - ", pull)
		%Nucleus.apply_central_force(pull)
	%Label.text = str(%Nucleus.linear_velocity)
	
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
