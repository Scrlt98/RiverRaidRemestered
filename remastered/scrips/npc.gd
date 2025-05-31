extends Area2D

class_name npc

signal puntos(points: int)

@export var npc_config: npc_configuracion
@export var cambio_direccion_comienzo: bool

@onready var animacion: AnimatedSprite2D = $AnimatedSprite2D
@onready var colision: CollisionShape2D = $CollisionShape2D
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var direccion = 1
var velocidad
var movimiento = true

func _ready() -> void:
	colision.shape = npc_config.npc_colision
	if cambio_direccion_comienzo:
		if npc_config.npc_tipo == "avion":
			scale.x = 1
		else:
			scale.x = -1
		
	animacion.play(npc_config.npc_tipo)
	
	
	if npc_config.npc_tipo == "avion":
		set_collision_mask_value(2, -15)
	
	velocidad = npc_config.velocidad
	
func _physics_process(delta: float) -> void:
	if movimiento:
		position.x += velocidad * delta * direccion
		
func explosion():
	movimiento = false
	animacion.modulate= npc_config.explosion_color
	animacion.play("explosion")
	puntos.emit(npc_config.puntos)
	audio.play()

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		scale.x *=-1
		direccion *= -1
		
	if body is Player:
		explosion()
		(body as Player).explode()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animacion.animation == "explosion":
		queue_free()
