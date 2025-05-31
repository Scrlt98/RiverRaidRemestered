extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("ses")
	
	
func pausa():
	get_tree().paused = true
	$AnimationPlayer.play("ses")
	
	
func esc():
	if Input.is_action_just_pressed("pausa") and !get_tree().paused:
		pausa()
	elif Input.is_action_just_pressed("pausa") and get_tree().paused:
		resume()
		


func _on_continue_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Escenas/main.tscn")

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/control.tscn")
	
func _process(delta: float) -> void:
	esc()
