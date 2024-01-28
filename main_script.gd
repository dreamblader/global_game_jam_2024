extends Node2D

@onready var screen_shade:ColorRect = $ColorRect
@onready var game:HBoxContainer = $Arena
@onready var text:Label = $Label

var playing:bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.pressed && !playing:
		play()

# Called when the node enters the scene tree for the first time.
func play() -> void:
	playing = true
	screen_shade.visible = false
	text.visible = false
	game.start()
	

