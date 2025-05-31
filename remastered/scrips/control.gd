extends Control

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	audio.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/main.tscn")
	audio.stop()

func _on_button_2_pressed() -> void:
	get_tree().quit()
