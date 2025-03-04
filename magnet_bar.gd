@tool
extends Node2D

#region     LENGTH
signal s_editor_lengthChanged # signal
@export var length:int = 100: # varibale
	set(val):
		length = val
		if not Engine.is_editor_hint(): return
		#s_editor_lengthChanged.emit()
		editor_adjustLength()
func editor_adjustLength(): # response function
	$Largest/Bar.shape.size.y = length / 2
	$Largest/Bar.position.y = length / 1.5
	$Large/Bar.shape.size.y = length / 4
	$Large/Bar.position.y = length / 3.2
	$Small/Bar.shape.size.y = length / 8
	$Small/Bar.position.y = length / 8
	$Smallest/Bar.shape.size.y = length / 16
	$Smallest/Bar.position.y = length / 32
#endregion   LENGTH

#region      GRAVITYVECTOR
signal s_editor_gravityVectorChanged # signal
@export var gravityVector:Vector2 = Vector2.UP: # varibale
	set(val):
		gravityVector = val
		if not Engine.is_editor_hint(): return
		#s_editor_gravityVectorChanged.emit()
		editor_adjustGravityVector()
func editor_adjustGravityVector(): # response function
	print("adjusting gravity to: ", gravityVector)
	$Largest.gravity_direction = gravityVector / 2
	$Large.gravity_direction = gravityVector / 4
	$Small.gravity_direction = gravityVector / 8
	$Smallest.gravity_direction = gravityVector / 16
#endregion   GRAVITYVECTOR






func _ready() -> void:
	#     EDITOR
	s_editor_lengthChanged.connect(editor_adjustLength)
	s_editor_gravityVectorChanged.connect(editor_adjustGravityVector)
	if Engine.is_editor_hint(): return
	#END  EDITOR











func _process(delta: float) -> void:
	if Engine.is_editor_hint(): return
