extends Area2D

@export var siguiente_escena: String

func change_scene():
	get_tree().change_scene_to_file(siguiente_escena)
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		change_scene()
		
