extends Area2D

class_name Puente

signal destruido
signal punto_spaw(spaw_point: Vector2)
signal puntos(points: int)
var fue_destuido = false
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var animaciones  = [
	$AnimatedSprite2D,$AnimatedSprite2D/AnimatedSprite2D,
	$AnimatedSprite2D/AnimatedSprite2D2, $AnimatedSprite2D/AnimatedSprite2D2/AnimatedSprite2D,
	$AnimatedSprite2D/AnimatedSprite2D3, $AnimatedSprite2D/AnimatedSprite2D3/AnimatedSprite2D,
	$AnimatedSprite2D3, $AnimatedSprite2D3/AnimatedSprite2D,
	$AnimatedSprite2D3/AnimatedSprite2D2, $AnimatedSprite2D3/AnimatedSprite2D2/AnimatedSprite2D,
	$AnimatedSprite2D3/AnimatedSprite2D3, $AnimatedSprite2D3/AnimatedSprite2D3/AnimatedSprite2D
] as Array[AnimatedSprite2D]

func _ready() -> void:
	for animacion in animaciones:
		(animacion as AnimatedSprite2D).connect("animation_finished", func(): if animacion.animation == "explosion puente": animacion.hide() )

func explode():
	for animacion in animaciones:
		animacion.modulate = Color.DARK_BLUE
		animacion.play("explosion puente")
		
		puntos.emit(20)
		destruido.emit()
		fue_destuido = true
	audio.play()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if !fue_destuido:
			(body as Player).explode()
		else:
			punto_spaw.emit(self.position)
			


func _on_area_entered(area: Area2D) -> void:
	if area is misil:
		explode()
		set_collision_mask_value(3, false)
