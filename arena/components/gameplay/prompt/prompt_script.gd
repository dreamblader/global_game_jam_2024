extends Area2D

var hit:bool=false
var size:float = 12.0

@export var scale_size_sprite: float = 12.0

@onready var colission: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $CircleEmpty


func set_size(value:float)-> void:
	var new_scale = value/scale_size_sprite
	size = value
	colission.shape.radius = value
	sprite.scale = Vector2(new_scale, new_scale)


func pressed() -> void:
	sprite.modulate.a = 0
	hit = true
	destroy()


func forgot() -> void:
	sprite.modulate = Color(0,1,1)
	destroy()


func destroy() -> void:
	queue_free()
