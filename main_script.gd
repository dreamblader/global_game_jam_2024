extends Node2D

@onready var screen_shade:ColorRect = $ColorRect
@onready var game:HBoxContainer = $Arena
@onready var text:Label = $Label
@onready var logo:Sprite2D = $Logo

@export var fade_duration:float = 2.0

var playing:bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.pressed && !playing:
		play()


func play() -> void:
	playing = true
	var tween:Tween = create_tween()
	tween.tween_property(screen_shade, "modulate:a", 0, fade_duration)
	tween.tween_callback(start)
	text.visible = false
	logo.visible = false


func start() -> void:
	screen_shade.visible = false
	game.start()


func _on_arena_end() -> void:
	var tween:Tween = create_tween()
	screen_shade.modulate.a = 0
	screen_shade.visible = true
	tween.tween_property(screen_shade, "modulate:a", 1, fade_duration)
	tween.tween_callback(start_again)


func start_again() -> void:
	playing = false
	logo.visible = true
	text.visible = true
	game.reset()
