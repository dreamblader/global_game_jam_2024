extends Node2D

@export var circle_texture: Array[CompressedTexture2D]
@export var square_texture: Array[CompressedTexture2D]
@export var label_circle: String
@export var label_square: String

@onready var circle_sprite: Sprite2D = $CircleButtonNormal
@onready var square_sprite: Sprite2D = $SquareButtonNormal
@onready var circle_text: Label = $LabelCircle
@onready var square_text: Label = $LabelSquare


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	circle_sprite.texture = circle_texture[0]
	square_sprite.texture = square_texture[0]
	circle_text.text = label_circle
	square_text.text = label_square


func change_button(button_id:int, press: bool) -> void:
	var texture_index = 1 if press else 0
	var label_position = -10.0 if press else -16.0
	match button_id:
		1:
			circle_sprite.texture = circle_texture[texture_index]
			circle_text.position.y = label_position
		2:
			square_sprite.texture = square_texture[texture_index]
			square_text.position.y = label_position
