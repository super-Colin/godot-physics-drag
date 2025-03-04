extends Node2D

var particleScene = preload("res://particle.tscn")




func _ready() -> void:
	Globals.s_resetCannon.connect(spawnNewShot)
	spawnNewShot()


func spawnNewShot():
	var newParticle = particleScene.instantiate()
	newParticle.position = $ParticleSpawn.position
	newParticle.isTarget = false
	$'.'.add_child(newParticle)
	
