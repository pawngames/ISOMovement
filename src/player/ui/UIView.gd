extends Control

var compass_angle:float = 0.0

func _ready():
	pass

func set_direction(angle:float):
	compass_angle = angle

func _process(delta):
	$Sprite/Node2D.rotation = lerp_angle(
		$Sprite/Node2D.rotation, 
		compass_angle, 
		.1)
	pass
