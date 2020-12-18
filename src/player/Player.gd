extends KinematicBody

onready var ui = $CameraRef/Camera/MeshInstance/Viewport/UIView
onready var player_m = $Sprite3D

export var SPEED=10
var camera_ref_rotation:float = PI/2
var player_ref_rotation:float = PI/4

#https://gamedevelopment.tutsplus.com/tutorials/creating-isometric-worlds-a-primer-for-game-developers--gamedev-6511

func _ready():
	ui.set_direction(camera_ref_rotation)
	pass

func _process(delta):
	var direction:Vector3 = Vector3(0,0,0)
	
	if Input.is_action_pressed("ui_up"):
		direction.x -= SPEED
	if Input.is_action_pressed("ui_down"):
		direction.x += SPEED
	if Input.is_action_pressed("ui_left"):
		direction.z += SPEED
	if Input.is_action_pressed("ui_right"):
		direction.z -= SPEED
	
	if Input.is_action_just_pressed("ui_select"):
		camera_ref_rotation += PI/2
		player_ref_rotation += PI/2
		ui.set_direction(camera_ref_rotation)
	
	$CameraRef.rotation.y = lerp($CameraRef.rotation.y, camera_ref_rotation, .1)
	
	var direction_sprite = direction.rotated(Vector3.UP, PI/4)
	match int(rad2deg(Vector2(direction_sprite.z, direction_sprite.x).angle())):
		0:
			$Sprite3D.frame = 3
		45: 
			$Sprite3D.frame = 2
		-45: 
			$Sprite3D.frame = 4
		90: 
			$Sprite3D.frame = 1
		-90: 
			$Sprite3D.frame = 5
		135: 
			$Sprite3D.frame = 0
		-135: 
			$Sprite3D.frame = 6
		180: 
			$Sprite3D.frame = 7
	
	direction = direction.rotated(Vector3.UP, player_ref_rotation)
	if direction.x != 0 or direction.z != 0:
		player_m.rotation.y = lerp_angle(
			player_m.rotation.y, 
			Vector2(direction.z, direction.x).angle(), .2)
	
	
	move_and_slide(direction, Vector3.UP)
	pass
