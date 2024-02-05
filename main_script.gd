extends Control

@onready var fade:ColorRect = $Fade
@onready var game:Control = $Arena
@onready var menu:Control = $Menu

@export var fade_duration:float = 1.0

var playing:bool = false


func _ready() -> void:
	game.visible = false
	menu.visible = true
	fade.modulate.a = 0


func play() -> void:
	playing = true
	menu.visible = false
	game.visible = true
	fade_out(start)


func start() -> void:
	game.start()


func start_again() -> void:
	playing = false
	game.visible = false
	menu.visible = true
	fade_out(game.reset)


func _on_arena_end() -> void:
	fade_in(start_again)


func _on_menu_play() -> void:
	fade_in(play)


func fade_in(call:Callable) -> void:
	var tween:Tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, fade_duration)
	tween.tween_callback(call)


func fade_out(call:Callable) -> void:
	var tween:Tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, fade_duration)
	tween.tween_callback(call)
