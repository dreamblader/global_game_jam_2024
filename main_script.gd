extends Control

@onready var fade:ColorRect = $Fade
@onready var manager:Control = $SceneManager
@onready var menu:Control = $Menu

@export var fade_duration:float = 1.0

var playing:bool = false


func _ready() -> void:
	fade.modulate.a = 0


func fade_in() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, fade_duration)
	tween.tween_callback(apply_next_screen)


func fade_out() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, fade_duration)
	tween.tween_callback(start_next_screen)


func _on_scene_manager_call_transition() -> void:
	fade_in()


func apply_next_screen() -> void:
	manager.apply()
	fade_out()


func start_next_screen() -> void:
	manager.start()
