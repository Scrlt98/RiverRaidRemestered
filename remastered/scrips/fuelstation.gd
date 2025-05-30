extends Area2D

class_name fuelstation

signal puntos(points: int)

@onready var animacion: AnimatedSprite2D = $AnimatedSprite2D

func explosion():
	animacion.play("fuel explosion")
	puntos.emit(125)

func _on_animated_sprite_2d_animation_finished() -> void:
	if animacion.animation == "fuel explosion":
		queue_free()
		


func _on_body_entered(body: Node2D) -> void:
	(body as Player).get_node("PoderSistema").incrementofuel()

func _on_body_exited(body: Node2D) -> void:
	(body as Player).get_node("PoderSistema").reduccionfuel()
