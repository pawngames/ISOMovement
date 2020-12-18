extends Area

func _ready():
	pass

func _on_FadeArea_body_entered(body):
	_material_fade(body, true)
	pass

func _on_FadeArea_body_exited(body):
	_material_fade(body, false)
	pass

func _material_fade(body, fade:bool):
	var parent = body.get_parent()
	if parent is MeshInstance:
		var mesh = (parent as MeshInstance)
		#var material = (mesh.material_override as SpatialMaterial)
		for i in range(mesh.mesh.get_surface_count()):
			var material = mesh.mesh.surface_get_material(i)
			if material != null:
				if fade:
					material.albedo_color.a = .5
				else:
					material.albedo_color.a = 1.0
