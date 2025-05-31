extends Area2D

class_name misil

@export var misil_velocidad = 600

func _process(delta: float) -> void:
	position.y -= misil_velocidad * delta


func _on_body_entered(body: Node2D) -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is npc:
		(area as npc).explosion()
		
	if area is fuelstation:
		(area as fuelstation).explosion()
		
	#if area is Puente:
		#(area as Puente).explode()
	
	queue_free()
