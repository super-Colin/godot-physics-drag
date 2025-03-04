extends Node2D





@export var weight = 1.0 # only for setting in on ready, use %Nucleus.mass as the source of truth
@export var isTarget = true

var mousePull = 1200.0






func _ready() -> void:
	#for orbiter in $'.'.get_node("Shell1").get_children():
		#print(orbiter)
		#orbiter.apply_central_impulse(Vector2(10, 0))
	if not isTarget:
		Globals.particleRef = $'.'
	%Nucleus.mass = weight
	%Nucleus.body_entered.connect(handleCollision)
	%Nucleus.fused.connect(calcGeneratedEnergy)
	$Nucleus/FusionExplosion.one_shot = true



func calcGeneratedEnergy():
	EnergyBank.addGeneratedEnergy(calcSelfEnergy())

#func handleCollision(rid, body, bodyIndex, shapeIndex):
func handleCollision(body):
	if isTarget:
		return
	if "mass" in body:
		#print("weight : ", body.mass, %Nucleus.mass)
		if isEnoughForFusion(body):
			$'.'.queue_free()
			#body.get_parent().fuse()
			body.fuse(1.5)



func calcSelfEnergy():
	return abs(%Nucleus.linear_velocity.x) + abs(%Nucleus.linear_velocity.y) * %Nucleus.mass * 0.0001


func isEnoughForFusion(body:Node)->bool:
	var selfEnergy = calcSelfEnergy()
	if selfEnergy >= body.requiredEnergyForFusion():
		return true
	return false


func _physics_process(delta: float) -> void:
	var pull = Vector2.ZERO
	if %Nucleus.beingDragged:
		tryDragging()
	%Label.text = str(%Nucleus.linear_velocity)



func tryDragging():
	if EnergyBank.useEnergyDragging():
		var pull = %Nucleus.get_local_mouse_position().normalized().rotated(%Nucleus.rotation) * mousePull
		#print("pulling - ", pull)
		%Nucleus.apply_central_force(pull)


func _input(event: InputEvent) -> void:
	if isTarget:
		return
	if Input.is_action_pressed("LeftClick"):
		if %Nucleus.hoveredOn:
			#print("dragging")
			%Nucleus.beingDragged = true
	elif Input.is_action_just_released("LeftClick"):
		%Nucleus.beingDragged = false
