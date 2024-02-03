extends Node2D

@export var circle_texture: Array[CompressedTexture2D]
@export var square_texture: Array[CompressedTexture2D]
@export var label_circle: String
@export var label_square: String

@onready var circle_sprite: Sprite2D = $CircleButtonNormal
@onready var square_sprite: Sprite2D = $SquareButtonNormal
@onready var circle_text: Label = $CircleButtonNormal/LabelCircle
@onready var square_text: Label = $SquareButtonNormal/LabelSquare

var lock:bool = false

func _ready() -> void:
	circle_sprite.texture = circle_texture[0]
	square_sprite.texture = square_texture[0]
	circle_text.text = label_circle
	square_text.text = label_square


func reset() -> void:
	circle_sprite.position = Vector2(-40, 0)
	square_sprite.position = Vector2(40, 0)
	circle_sprite.rotation_degrees = 0
	square_sprite.rotation_degrees = 0
	circle_sprite.texture = circle_texture[0]
	square_sprite.texture = square_texture[0]
	lock = false
	rotation_degrees


func yeet() -> void:
	lock = true
	var tween = create_tween()
	tween.tween_property(circle_sprite, "position", Vector2(-45, -5), 0.25)
	tween.parallel().tween_property(circle_sprite, "rotation_degrees", -45, 0.25)
	tween.parallel().tween_property(square_sprite, "position", Vector2(45, -5), 0.25)
	tween.parallel().tween_property(circle_sprite, "rotation_degrees", 45, 0.25)
	tween.tween_property(circle_sprite, "rotation_degrees", -90, 0.1)
	tween.parallel().tween_property(square_sprite, "rotation_degrees", 90, 0.1)
	tween.parallel().tween_property(circle_sprite, "position",  Vector2(-45, 60), 0.1)
	tween.parallel().tween_property(square_sprite, "position", Vector2(45, 60), 0.1)


func change_button(button_id:int, press: bool) -> void:
	if !lock:
		var texture_index = 1 if press else 0
		var label_position = -10.0 if press else -16.0
		match button_id:
			1:
				circle_sprite.texture = circle_texture[texture_index]
				circle_text.position.y = label_position
			2:
				square_sprite.texture = square_texture[texture_index]
				square_text.position.y = label_position
